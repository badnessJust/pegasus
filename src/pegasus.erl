%%%-------------------------------------------------------------------
%%% @author james
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% to connect to pegasus for bills
%%% configure error logger to get your preffered login
%%% to make the payment you the call will be made an then a process will continually poll via the status call to check if it was successful
%%% @end
%%% Created : 01. Jul 2016 5:11 PM
%%%-------------------------------------------------------------------
-module(pegasus).
-author("james").

-include("../include/pegasus_app_common.hrl").
-include("../../core/include/core_app_common.hrl").
-include("../include/response.hrl").
-include("../include/PegPay.hrl").
%% API
-export([
  get_details/1,
  pay_bill/1,
  authenticate/1,
  check_transaction_status/1,
  get_transaction_status/1,
  confirmation_poll/1,
  test/0,
  test/2
]).

%% @doc
%% to get the customer details this is the function called
%% it corresponds to QueryCustomerDetails in the api document
%% configure error logger in vm to get logs
%% @end
-spec(get_details(#payment{}) ->
  {ok, Message :: binary(), Trace :: term()} | {error, Message :: binary(), Trace :: term()}).
get_details(#payment{customer_id = CustomerId, type = BillID, transaction_id = TransactionId}) ->
  Settings = pegasus_env_util:get_settings(),
  {Bill, Param} = pegasus_util:get_type_and_param(BillID),
  Value = 'PegPay_client':'QueryCustomerDetails'(
    #'QueryCustomerDetails'{
      % Optional:
      query =
      #'QueryRequest'{
        % Optional:
        'QueryField1' = binary_to_list(CustomerId), %% CustomerRef/Id
        % Optional:
        'QueryField2' = Param,%%Kampala
        % Optional:
        'QueryField4' = Bill, %NWSC
        % Optional:
        'QueryField5' = Settings#pegasus_settings.api_username,
        % Optional:
        'QueryField6' = Settings#pegasus_settings.api_password
      }},
    _Soap_headers = [],
    _Soap_options = [{url, Settings#pegasus_settings.url},{timeout, 30000}
    ]),
  case Value of
    {ok, 200, _, _, _, _, ReturnedBody} ->
      BodyDecoded = pegasus_xml_response:get_details_response(ReturnedBody),
      case BodyDecoded#query_details_response.status_code of
        <<"0">> ->
          Body = [
            {<<"TransactionRef">>, TransactionId},
            {<<"CustomerId">>, BodyDecoded#query_details_response.customer_ref},
            {<<"Biller">>, list_to_binary(Bill)},
            {<<"CustomerName">>, iolist_to_binary([BodyDecoded#query_details_response.customer_name
            ,<<" ">>,CustomerId])},
            {<<"PaymentItem">>, erlang:iolist_to_binary([list_to_binary(Bill), <<" ">>, list_to_binary(Param)])},
            {<<"Balance">>, BodyDecoded#query_details_response.outstanding_balance},
            {<<"Area/BouquetCode">>, BodyDecoded#query_details_response.'Area/BouquetCode'},
            {<<"CustomerType">>, BodyDecoded#query_details_response.customer_type}
          ],
          {ok, {BodyDecoded#query_details_response.status_description, BodyDecoded#query_details_response.customer_name}, Body};

        StatusCode ->
          Description =  BodyDecoded#query_details_response.status_description,
          {error, pegasus_util:get_message(StatusCode, TransactionId,Description), Value}
      end;
    {ok, S1, _, E1} ->
      error_logger:error_msg("ErrorCode ~w  Error ~w ~n", [S1, E1]),
      {error, <<"transaction initiation failed">>, E1};
    {error, Error} ->
      error_logger:error_msg("Error ~w ~n", [Error]),
      {error, <<"service provider unavailable, please try again">>, Error};
    Error2 ->
      error_logger:error_msg("Error ~w ~n", [Error2]),
      {error, <<"service provider temporarily unavailable">>, Error2}
  end.

%% @doc
%% To make a bill payment, it corresponds to PrepaidVendorPostTransaction in the api doc
%% to test this function without actually making the api call (mock http call) adjust the environment variable: test (see pegasus_env_util)
%% fields:
%%PostField1 CustomerRef(Utility CustomerID)
%%PostField2 Customer Name
%%PostField21 Customer Type e.g. PREPAID or POSTPAID etc.
%%PostField3 Area
%%PostField4 UtilityCode
%%PostField5 PaymentDate in dd/MM/yyyy e.g. 28/12/2015
%%PostField7 TransactionAmount
%%PostField8 TransactionType e.g. CASH,EFT etc.
%%PostField9 VendorCode
%%PostField10 Password
%%PostField11 CustomerTel
%%PostField12 Reversal (is 0 for Prepaid Vendors)
%%PostField13 TranIdToReverse(is left blank)
%%PostField14 Teller e.g. can be customerTel or customer Name
%%PostField15 Offline (is 0)
%%PostField16 DigitalSignature
%%PostField17 ChequeNumber(is left Empty)
%%PostField18 Narration
%%PostField19 Email(can be Empty)
%%PostField20 Vendor Transaction ID
%% @end
-spec(pay_bill(#payment{}) ->
  {ok, Message :: binary(), Trace :: term()} | {error, Message :: binary(), Trace :: term()}).
pay_bill(Payment = #payment{email = EmailRaw, amount = AmountRaw, customer_id = CustomerIdRaw, type = BillID, transaction_id = TransactionIdRaw, phone_number = PhoneNumberRaw, customer_details = CustomerDetails}) ->
  Settings = pegasus_env_util:get_settings(),
  {Bill, Param} = pegasus_util:get_type_and_param(BillID),
  Amount = integer_to_list(AmountRaw),
  PaymentDate = pegasus_util:get_payment_date(),
  Narration = "Paying for " ++ Bill ++ " " ++ Param ++ " of " ++ Amount ++ " via chapchap",
  TransactionType = pegasus_util:get_transacion_type(Bill),
  PhoneNumber = binary_to_list(PhoneNumberRaw),
  TransactionId = binary_to_list(TransactionIdRaw),
  error_logger:error_msg("Email ~w ~n ", [[Payment#payment.email, EmailRaw]]),
  Email = binary_to_list(EmailRaw),

%% @doc signing procedure
%%  dataToSign (CustRef + CustName + CustomerTel +
%%    VendorTransactionID + VendorCode + Password + PaymentDate + Teller +
%%    TransactionAmount + Narration + TransactionType;) OR literally
%% (PostField1 + PostField2 + PostField11 + PostField20 + PostField9 + PostField10 +
%%  PostField5 + PostField14 + PostField7 + PostField18 + PostField8)
%% @end

  {<<"CustomerName">>, CustomerNameRaw} = lists:keyfind(<<"CustomerName">>, 1, CustomerDetails),
  CustomerName = binary_to_list(CustomerNameRaw),
  CustomerId = binary_to_list(CustomerIdRaw),

  Authenticationsignature = pegasus_signature:get_signature(
    CustomerId,
    CustomerName,
    PhoneNumber,
    TransactionId,
    Settings,
    PaymentDate,
    Amount,
    Narration,
    TransactionType
  ),
  Value = case pegasus_env_util:test() of
            prod ->
              'PegPay_client':'PrepaidVendorPostTransaction'(
                    #'PrepaidVendorPostTransaction'{
                      % Optional:
                      trans =
                      #'TransactionRequest'{
                        % Optional:
                        'PostField1' = CustomerId,
                        % Optional:
                        'PostField2' = CustomerName,
                        % Optional:
                        'PostField3' = Param,
                        % Optional:
                        'PostField4' = Bill, %% UtilityCode
                        % Optional:
                        'PostField5' = PaymentDate, %% payment date, dd/MM/yyyy
                        % Optional:
                        'PostField6' = "",
                        % Optional:
                        'PostField7' = Amount, %% amount
                        % Optional:
                        'PostField8' = TransactionType,%%PostField8 TransactionType e.g. CASH,EFT etc.
                        % Optional:
                        'PostField9' = Settings#pegasus_settings.api_username,
                        % Optional:
                        'PostField10' = Settings#pegasus_settings.api_password,
                        % Optional:
                        'PostField11' = PhoneNumber, %% CustomerTel
                        % Optional:
                        'PostField12' = "0",%%Reversal (is 0 for Prepaid Vendors)
                        % Optional:
                        'PostField13' = "",
                        % Optional:
                        'PostField14' = PhoneNumber, %%Teller e.g. can be customerTel or customer Name
                        % Optional:
                        'PostField15' = "0",%%Offline (is 0)
                        % Optional:
                        'PostField16' = Authenticationsignature, %DigitalSignature
                        % Optional:
                        'PostField17' = "",%ChequeNumber(is left Empty
                        % Optional:
                        'PostField18' = Narration,
                        'PostField19' = Email,
                        % Optional:
                        'PostField20' = TransactionId,
                        % Optional:
                        'PostField21' = Param %%Customer Type e.g. PREPAID or POSTPAID etc.
                      }},
                _Soap_headers = [],
                _Soap_options = [{url, Settings#pegasus_settings.url}, {timeout, 30000}]);
            test_success ->
              test_values:get_test_success_value();
            test_faliure ->
              test_values:get_test_failed_value();
            _ ->
              throw(<<"wrong test parameter!!! ">>)
          end,

  case Value of
    {ok, 200, _, _, _, _, ReturnedBody} ->
      BodyDecoded = pegasus_xml_response:get_post_transaction_response(ReturnedBody),
      case BodyDecoded#post_transaction_response.status_code of
        <<"1000">> ->
          ResultPollStart = confirmation_poll(Payment),
          case ResultPollStart of
            {ok, _} ->
              Body = [
                {receipt_id, BodyDecoded#post_transaction_response.peg_pay_id},
                {status_code, BodyDecoded#post_transaction_response.status_code},
                {status_description, BodyDecoded#post_transaction_response.status_description}
              ],
              {ok, {BodyDecoded#post_transaction_response.status_description, BodyDecoded#post_transaction_response.peg_pay_id}, Body};
            {error, Error3} -> {error, <<"failed to initialize ">>, Error3}
          end;
        StatusCode ->
          Description =  BodyDecoded#post_transaction_response.status_description,
          {error, pegasus_util:get_message(StatusCode, TransactionId,Description), Value}
      end;
    {ok, S1, _, E1} ->
      error_logger:error_msg("Error ~w ~n", [E1]),
      error_logger:error_msg("Code ~w ~n", [S1]),
      {error, <<"transaction initiation failed, please try again">>, E1};
    {error, Error} ->
      error_logger:error_msg("Error ~w ~n", [Error]),
      {error, <<"service provider temporarily unavailable, please try again">>, Error};
    {error,{client,{http_request,req_timedout}},<<>>} ->
      {error, <<"service provider temporarily unavailable, please try again">>, {error,timeout}};
    Error2 ->
      error_logger:error_msg("Error ~w ~n", [Error2]),
      {error, <<"service provider temporarily unavailable, please try again">>, Error2}
  end.

%% @doc
%% to check the status of the transaction
%% it will accept a payment record, or external referece ie transaction id
%% @end
-spec(get_transaction_status(ExternalReference :: binary()) ->
  {ok, Message :: binary(), Trace :: term()} | {error, Message :: binary(), Trace :: term()}).
get_transaction_status(#payment{transaction_id = TransactionId}) ->
  check_transaction_status(TransactionId);
get_transaction_status(TransactionId) ->
  check_transaction_status(TransactionId).
-spec(check_transaction_status(ExternalReference :: binary()) ->
  {ok, Message :: binary(), Trace :: term()} | {error, Message :: binary(), Trace :: term()}).
check_transaction_status(TransactionId) ->
  Settings = pegasus_env_util:get_settings(),
  Value = 'PegPay_client':'GetTransactionDetails'(
    #'GetTransactionDetails'{
      % Optional:
      query =
      #'QueryRequest'{
        'QueryField5' = Settings#pegasus_settings.api_username,
        % Optional:
        'QueryField6' = Settings#pegasus_settings.api_password,
        'QueryField10' = binary_to_list(TransactionId)}},
    _Soap_headers = [],
    _Soap_options = [{url, Settings#pegasus_settings.url},{timeout, 30000}]),
  case Value of
    {ok, 200, _, _, _, _, ReturnedBody} ->
      BodyDecoded = pegasus_xml_response:get_status_response(ReturnedBody),
      case BodyDecoded#get_status_response.status_code of
        <<"0">> ->
          Body = [
            {status_code, BodyDecoded#get_status_response.status_code},
            {status_description, BodyDecoded#get_status_response.status_description},
            {receipt, BodyDecoded#get_status_response.receipt},
            {recharge_pin, BodyDecoded#get_status_response.recharge_pin},
            {company_ref, BodyDecoded#get_status_response.company_ref}
          ],
          {ok, {BodyDecoded#get_status_response.status_description, BodyDecoded#get_status_response.receipt}, {Body, BodyDecoded}};
        <<"1000">> ->
          Bodyx = [
            {status_code, <<"1000">>},
            {status_description, <<"PENDING">>}
          ],
          {pending, pegasus_util:get_message(<<"1000">>, TransactionId), {Bodyx, BodyDecoded}};
        StatusCode ->
          MessageX = pegasus_util:get_message(StatusCode, TransactionId),
          Bodyx = [
            {status_code, StatusCode},
            {status_description, MessageX}
          ],
          {error, MessageX, {Bodyx, StatusCode}}
      end;
    {ok, S1, _, E1} ->
      error_logger:error_msg("E1 ~w ~n", [E1]),
      error_logger:error_msg("S1 ~w ~n", [S1]),
      {error, <<"transaction initiation failed">>, E1};
    {error, Error} ->
      error_logger:error_msg("Error ~w ~n", [Error]),
      {error, <<"service provider unavailable, please try again">>, Error};
    {error,{client,{http_request,req_timedout}},<<>>} ->
      {error, <<"service provider unavailable, please try again">>, {error,timeout}};
    Error2 ->
      error_logger:error_msg("Error ~w ~n", [Error2]),
      {error, <<"fatal error in making contact with service provider, please try again">>, Error2}

  end.

%% @doc for testing the polling of the transaction @end
-spec(check_transaction_test(ExternalReference :: binary()) ->
  {ok, Message :: binary(), Trace :: term()} | {error, Message :: binary(), Trace :: term()}).
check_transaction_test(_) ->

  Body = [
    {status_code, <<"0">>},
    {status_description, <<"SUCCESS">>},
    {receipt, <<"qo8u02u0s903">>},
    {recharge_pin, <<"qo8u02u0s90332">>},
    {company_ref, <<"98832">>}
  ],
  {ok, {<<"SUCCESS">>, <<"qo8u02u0s903">>}, {Body, #get_status_response{
    status_code = <<"0">>,
    status_description = <<"SUCCESS">>,
    receipt = <<"qo8u02u0s903">>,
    recharge_pin = <<"qo8u02u0s90332">>,
    company_ref = <<"98832">>
  }}}.

-spec(check_transaction_test_pending(ExternalReference :: binary()) ->
  {ok, Message :: binary(), Trace :: term()} | {error, Message :: binary(), Trace :: term()}).
check_transaction_test_pending(ExternalReference) ->

  {pending, pegasus_util:get_message("1000", ExternalReference), "1000"}.

-spec(check_transaction_test_failed(ExternalReference :: binary()) ->
  {ok, Message :: binary(), Trace :: term()} | {error, Message :: binary(), Trace :: term()}).
check_transaction_test_failed(ExternalReference) ->

  {error, pegasus_util:get_message("100", ExternalReference), "100"}.


%% @doc this is called to authenticate the signature of pegasus
-spec(authenticate(#core_request{}) -> ok | {error, Error :: term()}).
authenticate(Request) ->
  case application:get_env(test) of
    {ok, false} -> authenticate(production, Request);
    {ok, true} -> authenticate(test, Request);
    _ -> authenticate(test, Request)
  end.

authenticate(test, _Request) ->
  ok;
authenticate(production, #core_request{args_list = ArgsList}) ->
  try
    Signature = lists:keyfind(<<"signature">>, 1, ArgsList),
    Decrypted = pegasus_signature:decrypt(Signature),
    {ok, DateTime} = lists:keyfind(<<"date_time">>, 1, ArgsList),
    {ok, Amount} = lists:keyfind(<<"amount">>, 1, ArgsList),
    {ok, Narrative} = lists:keyfind(<<"narrative">>, 1, ArgsList),
    {ok, NetworkRef} = lists:keyfind(<<"network_ref">>, 1, ArgsList),
    {ok, ExternalRef} = lists:keyfind(<<"external_ref">>, 1, ArgsList),

    Decrypted =:= erlang:iolist_to_binary([DateTime, Amount, Narrative, NetworkRef, ExternalRef])
  of
    true -> ok;
    false -> {error, <<"signature authentiacation failed">>}
  catch
    _X:_Y ->
      {error, <<"signature authentiacation failed">>}
  end.

%% @doc this will poll the status of a transaction
%% it wil expect a success call back , failure call back and archiving call back function (for logging)
%% @end
-spec(confirmation_poll(#payment{})->tuple()).
confirmation_poll(Payment = #payment{phone_number = _PhoneNumber, archive = Archive, type = Type, start_after = StartAfter, poll_interval = Interval, max = Max}) ->
  StartPoll = periodic_sup:start_periodic(
    #periodic_state{
      task = fun poll/1,
      data = Payment,
      type = Type,
      start_after = StartAfter,
      interval = Interval,
      max = Max
    }
  ),

  %% attempt to start the asynchronous process
  case StartPoll of
    {ok, Pid, Name} ->
      %% attempt to run the asynchronous process
      Archive(<<"async process polling started">>, {Pid, Name}),
      {ok, Pid};
    Error1 ->
      Archive(<<"async process polling failed to start">>, Error1),
      {error, Error1}
  end.

%% @doc
%% this will poll the status of a transaction
%% it wil expect a success call back , failure call back and archiving call back function (for logging)
%% type parameter can be used for tests
%% the confirmation callback should be function with one parameter, that parameter passed will be the receipt/token
%% the failure callback should be a function with one parameter, that parameter passed will be the error
%% the archive call back should be a function with one parameter, that parameter passed will be the status
%% @end
poll(PeriodicState = #periodic_state{type = test, number_of_calls = N}) ->
  if
    N < 3 -> poll_internal(fun check_transaction_test_pending/1, PeriodicState);
    true -> poll_internal(fun check_transaction_test/1, PeriodicState)
  end;
poll(PeriodicState = #periodic_state{type = test_failed_poll}) ->
  poll_internal(fun check_transaction_test_failed/1, PeriodicState);
poll(PeriodicState) ->
  poll_internal(fun check_transaction_status/1, PeriodicState).
poll_internal(CheckStatusFunction, PeriodicState = #periodic_state{data = Payment}) ->
  Archive = Payment#payment.archive,
  try
    Archive(<<"Status Poll">>, PeriodicState)
  catch
     _ : _ -> nothing
  end,
  ConfirmCallback = Payment#payment.on_confirm_callback,
  OnFailureCallback = Payment#payment.on_indeterminate_callback,
  case CheckStatusFunction(Payment#payment.transaction_id) of
    {ok, {_Description, ReceiptRaw}, {_Body, BodyDecoded}} ->
      try
        Archive(<<"transaction SUCCEEDED">>, BodyDecoded),
        Receipt = case {Payment#payment.type, BodyDecoded#get_status_response.recharge_pin} of
                    {_, undefined} when is_binary(ReceiptRaw) -> ReceiptRaw;
                    {<<"prepaid_umeme">>, R} when is_binary(ReceiptRaw) ->
                      erlang:iolist_to_binary([<<"token: ">>, R, <<" receipt: ">>, ReceiptRaw]);
                    {_, R2} when is_binary(ReceiptRaw) -> erlang:iolist_to_binary([R2, <<" ">>, ReceiptRaw]);
                    _ -> <<" ">>
                  end,
        ConfirmCallback([{<<"receipt">>, Receipt},{<<"raw_receipt">>,BodyDecoded#get_status_response.receipt}])
      catch
        X:Y ->
          Trace = io_lib:format("error has occurred of type: ~w , message: ~w trace ~w  \n", [X, Y, erlang:get_stacktrace()]),
          Archive(<<"error in confirmation">>, [X, Y,Trace])
      end,
      PeriodicState#periodic_state{stop = true};
    {pending, _, Body} ->
      Archive(<<"still pending">>, Body),
      PeriodicState;
    {error, Body, "1000"} ->
      Archive(<<"checking status">>, Body),
      PeriodicState;
    {error, Message, {BodyX, "100"}} ->
      try
        Archive(<<"transaction FAILED">>, BodyX),
        OnFailureCallback([{<<"error_message">>, Message}])
      catch
        X10:Y10 -> Archive(<<"error in failure cleanup">>, [X10, Y10])
      end,

      PeriodicState#periodic_state{stop = true};
    {error, Messagex, {error,timeout}} ->
      Archive(<<"timeout checking status">>, Messagex),
      PeriodicState;
    {error, Message1, {BodyXY, _Code}} ->
      try
        Archive(<<"transaction FAILED">>, BodyXY),
        OnFailureCallback([{<<"error_message">>, Message1}])
      catch
        X12:Y12 -> Archive(<<"error in failure cleanup">>, [X12, Y12])
      end,
      PeriodicState#periodic_state{stop = true};
    {error, Message2, "100"} ->
      try
        Archive(<<"transaction FAILED">>, Message2),
        OnFailureCallback([{<<"error_message">>, <<" ">>}])
      catch
        X1:Y1 -> Archive(<<"error in failure cleanup">>, [X1, Y1])
      end,
      PeriodicState#periodic_state{stop = true};
    {error, Messagex, X} ->
      Archive(<<"Error occured, still checking">>,X, Messagex),
      PeriodicState
%%      try
%%        Archive(<<"transaction ERROR">>, Messagex),
%%        OnFailureCallback([{<<"error_message">>, Messagex}])
%%      catch
%%        X2:Y2 ->
%%          Archive(<<"error in failure cleanup">>, [X2, Y2])
%%      end,
%%      PeriodicState#periodic_state{stop = true}

  end.

test()->
  application:start(asn1),
  application:start(crypto),
  application:start(public_key),
  application:start(ssl),application:start(ibrowse),
  application:start(fast_xml),
  TransactionId = number_manipulator:get_guid_long(),
  get_details(#payment{customer_id = <<"2167527">>, type = <<"nswc_kampala">>, transaction_id = TransactionId}).

test(AccountNumber,Id)->
  application:start(asn1),
  application:start(crypto),
  application:start(public_key),
  application:start(ssl),application:start(ibrowse),
  application:start(fast_xml),
  TransactionId = number_manipulator:get_guid_long(),

  {ok, {StatusDescription, CustomerName}, Body}
    = pegasus: get_details(#payment{customer_id =AccountNumber, type = Id, transaction_id = TransactionId}),

  io:format("StatusDescription ~w CustomerName ~w Body ~w ~n",[StatusDescription,CustomerName,Body]),
  CustomerDetails = [{<<"CustomerName">>, CustomerName}],
  Payment2 = #payment{
    email = <<"ajames@chapchap.co">>,
    amount = 1000,
    customer_id = AccountNumber,
    customer_details = CustomerDetails,
    type = Id,
    transaction_id = TransactionId,
    phone_number = <<"256756719888">>,
    start_after = 1000,
    max = 3,
    poll_interval = 1000,
    on_confirm_callback = fun(_)-> io:format("on confirm XXXXXXXXXXXXXXXX~n") end,
    on_indeterminate_callback = fun(_)-> io:format("on failed XXXXXXXXXXXXXXXX~n") end,
    archive = fun(_,_)-> io:format("archive XXXXXXXXXXXXXXXX~n") end
  },
  io:format("Email ~w ~n ",[Payment2#payment.email]),
  pegasus:pay_bill(Payment2).