%%%-------------------------------------------------------------------
%%% @author mb-spare
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Jul 2016 7:00 AM
%%%-------------------------------------------------------------------
-module(xml_response).
-author("mb-spare").
-include("../include/response.hrl").
-include("../include/response_not_shared.hrl").

%% API
-export([get_details_response/1, get_post_transaction_response/1, get_status_response/1]).

get_details_response(Raw) ->
  ParmsList = core_util:decode_xml_params(Raw),
  Body = get_body(ParmsList),
  QueryCustomerDetailsResponse = getValue(<<"QueryCustomerDetailsResponse">>, Body),
  QueryCustomerDetailsResult = getValue(<<"QueryCustomerDetailsResult">>, QueryCustomerDetailsResponse),
  #query_details_response{
    customer_ref = getValue(<<"ResponseField1">>, QueryCustomerDetailsResult),
    customer_name = getValue(<<"ResponseField2">>, QueryCustomerDetailsResult),
    'Area/BouquetCode' = getValue(<<"ResponseField3">>, QueryCustomerDetailsResult),
    outstanding_balance = getValue(<<"ResponseField4">>, QueryCustomerDetailsResult),
    customer_type = getValue(<<"ResponseField5">>, QueryCustomerDetailsResult),
    status_code = getValue(<<"ResponseField6">>, QueryCustomerDetailsResult),
    status_description = getValue(<<"ResponseField7">>, QueryCustomerDetailsResult)

  }

.

get_status_response(Raw) ->
  ParmsList = core_util:decode_xml_params(Raw),
  Body = get_body(ParmsList),
  GetTransactionDetailsResponse = getValue(<<"GetTransactionDetailsResponse">>, Body),
  GetTransactionDetailsResult = getValue(<<"GetTransactionDetailsResponse">>, GetTransactionDetailsResponse),
  #get_status_response{
    status_code = getValue(<<"ResponseField6">>, GetTransactionDetailsResult),
    status_description = getValue(<<"ResponseField7">>, GetTransactionDetailsResult),
    receipt = getValue(<<"ResponseField8">>, GetTransactionDetailsResult)
  }

.


get_post_transaction_response(Raw) ->
  ParmsList = core_util:decode_xml_params(Raw),
  Body = get_body(ParmsList),
  PostTransactionResponse = getValue(<<"PostTransactionResponse">>, Body),
  PostTransactionResult = getValue(<<"PostTransactionResult">>, PostTransactionResponse),
  #post_transaction_response{
    status_code = getValue(<<"ResponseField6">>, PostTransactionResult),
    status_description = getValue(<<"ResponseField7">>, PostTransactionResult),
    peg_pay_id = getValue(<<"ResponseField8">>, PostTransactionResult)
  }.


getValue(Key, ParameterList) ->

  case lists:keyfind(Key, 1, ParameterList) of
    {Key, Value} -> Value;
    _ -> undefined
  end.

get_envelope(Raw) ->
  getValue(<<"soap:Envelope">>, Raw).

get_body(Raw) ->
  Envelop = get_envelope(Raw),
  getValue(<<"soap:Body">>, Envelop).