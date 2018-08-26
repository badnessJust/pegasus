
%% generated by soap from: /home/james/Development/pegasus/PegPay.wsdl
%% for service "PegPay" and port "PegPaySoap"
%% using options: [{service,"PegPay"},{port,"PegPaySoap"},{generate,client},{namespaces,[{"http://PegPayPaymentsApi/",undefined}]},{generate_tests,client},{http_client,soap_client_ibrowse},{client_name,"PegPay_client"},{strict,true}]

%%% This file contains record and type decarations that are used by the WSDL.
%%%
%%% It also contains a macro 'INTERFACE' that is used to make information
%%% about the WSDL available to the SOAP implementation.
%%%
%%% It is possible (and in some cases necessary) to change the name of the
%%% record fields.
%%%
%%% It is possible to add default values, but be aware that these will only
%%% be used when *writing* an xml document.

%%% Records used to represent fault response messages:

-record(faultdetail, {uri :: string(),
  tag :: string(),
  text :: string()}).

-record(faultcode, {uri :: string(),
  code :: string(),
  subcode :: #faultcode{} % only v. 1.2
}).

-record(faultreason, {text :: string(),
  language :: string()}).

-record(soap_fault_1_1, {faultcode :: #faultcode{},
  faultstring :: string(),
  faultactor :: string(),
  detail :: [#faultdetail{}]}).

-record(soap_fault_1_2, {code :: #faultcode{},
  reason :: [#faultreason{}],
  role :: string(),
  detail :: [#faultdetail{}]}).

%% xsd:QName values are translated to #qname{} records.
-record(qname, {uri :: string(),
  localPart :: string(),
  prefix :: string(),
  mappedPrefix :: string()}).



-record('PrepaidVendorPostTransactionResponse', {
  'PrepaidVendorPostTransactionResult' :: 'Response'() | undefined}).

-type 'PrepaidVendorPostTransactionResponse'() :: #'PrepaidVendorPostTransactionResponse'{}.


-record('PrepaidVendorPostTransaction', {
  trans :: 'TransactionRequest'() | undefined}).

-type 'PrepaidVendorPostTransaction'() :: #'PrepaidVendorPostTransaction'{}.


-record('ReactivatePayTvCardResponse', {
  'ReactivatePayTvCardResult' :: 'Response'() | undefined}).

-type 'ReactivatePayTvCardResponse'() :: #'ReactivatePayTvCardResponse'{}.


-record('ReactivatePayTvCard', {
  query :: 'QueryRequest'() | undefined}).

-type 'ReactivatePayTvCard'() :: #'ReactivatePayTvCard'{}.


-record('ReversePrepaidTransactionResponse', {
  'ReversePrepaidTransactionResult' :: 'Response'() | undefined}).

-type 'ReversePrepaidTransactionResponse'() :: #'ReversePrepaidTransactionResponse'{}.


-record('ReversePrepaidTransaction', {
  trans :: 'TransactionRequest'() | undefined}).

-type 'ReversePrepaidTransaction'() :: #'ReversePrepaidTransaction'{}.


-record('BouquetDetails', {
  'BouquetCode' :: string() | undefined,
  'BouquetName' :: string() | undefined,
  'BouquetPrice' :: string() | undefined,
  'BouquetDescription' :: string() | undefined,
  'PayTvCode' :: string() | undefined,
  'StatusCode' :: string() | undefined,
  'StatusDescription' :: string() | undefined}).

-type 'BouquetDetails'() :: #'BouquetDetails'{}.


-record('ArrayOfBouquetDetails', {
  'BouquetDetails' :: ['BouquetDetails'() | {nil, 'BouquetDetails'()}] | undefined}).

-type 'ArrayOfBouquetDetails'() :: #'ArrayOfBouquetDetails'{}.


-record('GetPayTVBouquetDetailsResponse', {
  'GetPayTVBouquetDetailsResult' :: 'ArrayOfBouquetDetails'() | undefined}).

-type 'GetPayTVBouquetDetailsResponse'() :: #'GetPayTVBouquetDetailsResponse'{}.


-record('GetPayTVBouquetDetails', {
  query :: 'QueryRequest'() | undefined}).

-type 'GetPayTVBouquetDetails'() :: #'GetPayTVBouquetDetails'{}.


-record('PostTransactionResponse', {
  'PostTransactionResult' :: 'Response'() | undefined}).

-type 'PostTransactionResponse'() :: #'PostTransactionResponse'{}.


-record('PostTransaction', {
  trans :: 'TransactionRequest'() | undefined}).

-type 'PostTransaction'() :: #'PostTransaction'{}.


-record('PostSchoolsTransactionResponse', {
  'PostSchoolsTransactionResult' :: 'Response'() | undefined}).

-type 'PostSchoolsTransactionResponse'() :: #'PostSchoolsTransactionResponse'{}.


-record('TransactionRequest', {
  'PostField1' :: string() | undefined,
  'PostField2' :: string() | undefined,
  'PostField3' :: string() | undefined,
  'PostField4' :: string() | undefined,
  'PostField5' :: string() | undefined,
  'PostField6' :: string() | undefined,
  'PostField7' :: string() | undefined,
  'PostField8' :: string() | undefined,
  'PostField9' :: string() | undefined,
  'PostField10' :: string() | undefined,
  'PostField11' :: string() | undefined,
  'PostField12' :: string() | undefined,
  'PostField13' :: string() | undefined,
  'PostField14' :: string() | undefined,
  'PostField15' :: string() | undefined,
  'PostField16' :: string() | undefined,
  'PostField17' :: string() | undefined,
  'PostField18' :: string() | undefined,
  'PostField19' :: string() | undefined,
  'PostField20' :: string() | undefined,
  'PostField21' :: string() | undefined,
  'PostField22' :: string() | undefined,
  'PostField23' :: string() | undefined,
  'PostField24' :: string() | undefined,
  'PostField25' :: string() | undefined,
  'PostField26' :: string() | undefined,
  'PostField27' :: string() | undefined,
  'PostField28' :: string() | undefined,
  'PostField29' :: string() | undefined,
  'PostField30' :: string() | undefined,
  'PostField31' :: string() | undefined,
  'PostField32' :: string() | undefined,
  'PostField33' :: string() | undefined,
  'PostField34' :: string() | undefined}).

-type 'TransactionRequest'() :: #'TransactionRequest'{}.


-record('PostSchoolsTransaction', {
  trans :: 'TransactionRequest'() | undefined}).

-type 'PostSchoolsTransaction'() :: #'PostSchoolsTransaction'{}.


-record('QuerySchoolDetailsResponse', {
  'QuerySchoolDetailsResult' :: 'Response'() | undefined}).

-type 'QuerySchoolDetailsResponse'() :: #'QuerySchoolDetailsResponse'{}.


-record('QuerySchoolDetails', {
  query :: 'QueryRequest'() | undefined}).

-type 'QuerySchoolDetails'() :: #'QuerySchoolDetails'{}.


-record('QueryCustomerDetailsResponse', {
  'QueryCustomerDetailsResult' :: 'Response'() | undefined}).

-type 'QueryCustomerDetailsResponse'() :: #'QueryCustomerDetailsResponse'{}.


-record('QueryCustomerDetails', {
  query :: 'QueryRequest'() | undefined}).

-type 'QueryCustomerDetails'() :: #'QueryCustomerDetails'{}.


-record('GetPrepaidVendorDetailsResponse', {
  'GetPrepaidVendorDetailsResult' :: 'Response'() | undefined}).

-type 'GetPrepaidVendorDetailsResponse'() :: #'GetPrepaidVendorDetailsResponse'{}.


-record('GetPrepaidVendorDetails', {
  query :: 'QueryRequest'() | undefined}).

-type 'GetPrepaidVendorDetails'() :: #'GetPrepaidVendorDetails'{}.


-record('Response', {
  'ResponseField1' :: string() | undefined,
  'ResponseField2' :: string() | undefined,
  'ResponseField3' :: string() | undefined,
  'ResponseField4' :: string() | undefined,
  'ResponseField5' :: string() | undefined,
  'ResponseField6' :: string() | undefined,
  'ResponseField7' :: string() | undefined,
  'ResponseField8' :: string() | undefined,
  'ResponseField9' :: string() | undefined,
  'ResponseField10' :: string() | undefined,
  'ResponseField11' :: string() | undefined,
  'ResponseField12' :: string() | undefined,
  'ResponseField13' :: string() | undefined,
  'ResponseField14' :: string() | undefined,
  'ResponseField15' :: string() | undefined,
  'ResponseField16' :: string() | undefined,
  'ResponseField17' :: string() | undefined,
  'ResponseField18' :: string() | undefined,
  'ResponseField19' :: string() | undefined,
  'ResponseField20' :: string() | undefined,
  'ResponseField21' :: string() | undefined,
  'ResponseField22' :: string() | undefined,
  'ResponseField23' :: string() | undefined}

).

-type 'Response'() :: #'Response'{}.


-record('GetTransactionDetailsResponse', {
  'GetTransactionDetailsResult' :: 'Response'() | undefined}).

-type 'GetTransactionDetailsResponse'() :: #'GetTransactionDetailsResponse'{}.


-record('QueryRequest', {
  'QueryField1' :: string() | undefined,
  'QueryField2' :: string() | undefined,
  'QueryField3' :: string() | undefined,
  'QueryField4' :: string() | undefined,
  'QueryField5' :: string() | undefined,
  'QueryField6' :: string() | undefined,
  'QueryField7' :: string() | undefined,
  'QueryField8' :: string() | undefined,
  'QueryField9' :: string() | undefined,
  'QueryField10' :: string() | undefined}).

-type 'QueryRequest'() :: #'QueryRequest'{}.


-record('GetTransactionDetails', {
  query :: 'QueryRequest'() | undefined}).

-type 'GetTransactionDetails'() :: #'GetTransactionDetails'{}.


-record('GetServerStatusResponse', {
  'GetServerStatusResult' :: string() | undefined}).

-type 'GetServerStatusResponse'() :: #'GetServerStatusResponse'{}.


-record('GetServerStatus', {}).

-type 'GetServerStatus'() :: #'GetServerStatus'{}.
-define(INTERFACE, {interface,"PegPay",'PegPay','1.1',soap_client_ibrowse,
  soap_server_cowboy_1,undefined,'PegPay_client',[],
  "http://PegPayPaymentsApi/",
  "http://schemas.xmlsoap.org/soap/envelope/",undefined,
  undefined,
  "https://pegasus.co.ug:8896/LivePegPayApi/PegPay.asmx",
  "PegPaySoap","PegPaySoap","PegPaySoap",
  [{op,"GetServerStatus",'GetServerStatus',
    "http://PegPayPaymentsApi/GetServerStatus",undefined,
    request_response,'GetServerStatus',
    'GetServerStatusResponse',undefined},
    {op,"GetTransactionDetails",'GetTransactionDetails',
      "http://PegPayPaymentsApi/GetTransactionDetails",
      undefined,request_response,'GetTransactionDetails',
      'GetTransactionDetailsResponse',undefined},
    {op,"GetPrepaidVendorDetails",'GetPrepaidVendorDetails',
      "http://PegPayPaymentsApi/GetPrepaidVendorDetails",
      undefined,request_response,'GetPrepaidVendorDetails',
      'GetPrepaidVendorDetailsResponse',undefined},
    {op,"QueryCustomerDetails",'QueryCustomerDetails',
      "http://PegPayPaymentsApi/QueryCustomerDetails",
      undefined,request_response,'QueryCustomerDetails',
      'QueryCustomerDetailsResponse',undefined},
    {op,"QuerySchoolDetails",'QuerySchoolDetails',
      "http://PegPayPaymentsApi/QuerySchoolDetails",undefined,
      request_response,'QuerySchoolDetails',
      'QuerySchoolDetailsResponse',undefined},
    {op,"PostSchoolsTransaction",'PostSchoolsTransaction',
      "http://PegPayPaymentsApi/PostSchoolsTransaction",
      undefined,request_response,'PostSchoolsTransaction',
      'PostSchoolsTransactionResponse',undefined},
    {op,"PostTransaction",'PostTransaction',
      "http://PegPayPaymentsApi/PostTransaction",undefined,
      request_response,'PostTransaction',
      'PostTransactionResponse',undefined},
    {op,"GetPayTVBouquetDetails",'GetPayTVBouquetDetails',
      "http://PegPayPaymentsApi/GetPayTVBouquetDetails",
      undefined,request_response,'GetPayTVBouquetDetails',
      'GetPayTVBouquetDetailsResponse',undefined},
    {op,"ReversePrepaidTransaction",
      'ReversePrepaidTransaction',
      "http://PegPayPaymentsApi/ReversePrepaidTransaction",
      undefined,request_response,'ReversePrepaidTransaction',
      'ReversePrepaidTransactionResponse',undefined},
    {op,"ReactivatePayTvCard",'ReactivatePayTvCard',
      "http://PegPayPaymentsApi/ReactivatePayTvCard",
      undefined,request_response,'ReactivatePayTvCard',
      'ReactivatePayTvCardResponse',undefined},
    {op,"PrepaidVendorPostTransaction",
      'PrepaidVendorPostTransaction',
      "http://PegPayPaymentsApi/PrepaidVendorPostTransaction",
      undefined,request_response,
      'PrepaidVendorPostTransaction',
      'PrepaidVendorPostTransactionResponse',undefined}],
  {model,
    [{type,'_document',sequence,
      [{el,
        [{alt,'GetServerStatus','GetServerStatus',[],1,1,
          true,undefined},
          {alt,'GetServerStatusResponse',
            'GetServerStatusResponse',[],1,1,true,undefined},
          {alt,'GetTransactionDetails',
            'GetTransactionDetails',[],1,1,true,undefined},
          {alt,'GetTransactionDetailsResponse',
            'GetTransactionDetailsResponse',[],1,1,true,
            undefined},
          {alt,'GetPrepaidVendorDetails',
            'GetPrepaidVendorDetails',[],1,1,true,undefined},
          {alt,'GetPrepaidVendorDetailsResponse',
            'GetPrepaidVendorDetailsResponse',[],1,1,true,
            undefined},
          {alt,'QueryCustomerDetails','QueryCustomerDetails',
            [],1,1,true,undefined},
          {alt,'QueryCustomerDetailsResponse',
            'QueryCustomerDetailsResponse',[],1,1,true,
            undefined},
          {alt,'QuerySchoolDetails','QuerySchoolDetails',[],
            1,1,true,undefined},
          {alt,'QuerySchoolDetailsResponse',
            'QuerySchoolDetailsResponse',[],1,1,true,undefined},
          {alt,'PostSchoolsTransaction',
            'PostSchoolsTransaction',[],1,1,true,undefined},
          {alt,'PostSchoolsTransactionResponse',
            'PostSchoolsTransactionResponse',[],1,1,true,
            undefined},
          {alt,'PostTransaction','PostTransaction',[],1,1,
            true,undefined},
          {alt,'PostTransactionResponse',
            'PostTransactionResponse',[],1,1,true,undefined},
          {alt,'GetPayTVBouquetDetails',
            'GetPayTVBouquetDetails',[],1,1,true,undefined},
          {alt,'GetPayTVBouquetDetailsResponse',
            'GetPayTVBouquetDetailsResponse',[],1,1,true,
            undefined},
          {alt,'ReversePrepaidTransaction',
            'ReversePrepaidTransaction',[],1,1,true,undefined},
          {alt,'ReversePrepaidTransactionResponse',
            'ReversePrepaidTransactionResponse',[],1,1,true,
            undefined},
          {alt,'ReactivatePayTvCard','ReactivatePayTvCard',
            [],1,1,true,undefined},
          {alt,'ReactivatePayTvCardResponse',
            'ReactivatePayTvCardResponse',[],1,1,true,
            undefined},
          {alt,'PrepaidVendorPostTransaction',
            'PrepaidVendorPostTransaction',[],1,1,true,
            undefined},
          {alt,'PrepaidVendorPostTransactionResponse',
            'PrepaidVendorPostTransactionResponse',[],1,1,true,
            undefined}],
        1,1,undefined,2}],
      [],undefined,undefined,1,1,1,false,undefined},
      {type,'PrepaidVendorPostTransactionResponse',sequence,
        [{el,
          [{alt,'PrepaidVendorPostTransactionResult',
            'Response',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'PrepaidVendorPostTransaction',sequence,
        [{el,
          [{alt,trans,'TransactionRequest',[],1,1,true,
            undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'ReactivatePayTvCardResponse',sequence,
        [{el,
          [{alt,'ReactivatePayTvCardResult','Response',[],1,1,
            true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'ReactivatePayTvCard',sequence,
        [{el,
          [{alt,query,'QueryRequest',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'ReversePrepaidTransactionResponse',sequence,
        [{el,
          [{alt,'ReversePrepaidTransactionResult','Response',
            [],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'ReversePrepaidTransaction',sequence,
        [{el,
          [{alt,trans,'TransactionRequest',[],1,1,true,
            undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'BouquetDetails',sequence,
        [{el,
          [{alt,'BouquetCode',
            {'#PCDATA',char},
            [],1,1,true,undefined}],
          0,1,undefined,2},
          {el,
            [{alt,'BouquetName',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,3},
          {el,
            [{alt,'BouquetPrice',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,4},
          {el,
            [{alt,'BouquetDescription',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,5},
          {el,
            [{alt,'PayTvCode',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,6},
          {el,
            [{alt,'StatusCode',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,7},
          {el,
            [{alt,'StatusDescription',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,8}],
        [],undefined,undefined,8,1,1,undefined,undefined},
      {type,'ArrayOfBouquetDetails',sequence,
        [{el,
          [{alt,'BouquetDetails','BouquetDetails',[],1,1,true,
            undefined}],
          0,unbound,true,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'GetPayTVBouquetDetailsResponse',sequence,
        [{el,
          [{alt,'GetPayTVBouquetDetailsResult',
            'ArrayOfBouquetDetails',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'GetPayTVBouquetDetails',sequence,
        [{el,
          [{alt,query,'QueryRequest',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'PostTransactionResponse',sequence,
        [{el,
          [{alt,'PostTransactionResult','Response',[],1,1,
            true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'PostTransaction',sequence,
        [{el,
          [{alt,trans,'TransactionRequest',[],1,1,true,
            undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'PostSchoolsTransactionResponse',sequence,
        [{el,
          [{alt,'PostSchoolsTransactionResult','Response',[],
            1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'TransactionRequest',sequence,
        [{el,
          [{alt,'PostField1',
            {'#PCDATA',char},
            [],1,1,true,undefined}],
          0,1,undefined,2},
          {el,
            [{alt,'PostField2',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,3},
          {el,
            [{alt,'PostField3',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,4},
          {el,
            [{alt,'PostField4',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,5},
          {el,
            [{alt,'PostField5',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,6},
          {el,
            [{alt,'PostField6',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,7},
          {el,
            [{alt,'PostField7',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,8},
          {el,
            [{alt,'PostField8',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,9},
          {el,
            [{alt,'PostField9',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,10},
          {el,
            [{alt,'PostField10',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,11},
          {el,
            [{alt,'PostField11',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,12},
          {el,
            [{alt,'PostField12',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,13},
          {el,
            [{alt,'PostField13',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,14},
          {el,
            [{alt,'PostField14',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,15},
          {el,
            [{alt,'PostField15',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,16},
          {el,
            [{alt,'PostField16',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,17},
          {el,
            [{alt,'PostField17',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,18},
          {el,
            [{alt,'PostField18',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,19},
          {el,
            [{alt,'PostField19',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,20},
          {el,
            [{alt,'PostField20',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,21},
          {el,
            [{alt,'PostField21',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,22},
          {el,
            [{alt,'PostField22',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,23},
          {el,
            [{alt,'PostField23',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,24},
          {el,
            [{alt,'PostField24',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,25},
          {el,
            [{alt,'PostField25',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,26},
          {el,
            [{alt,'PostField26',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,27},
          {el,
            [{alt,'PostField27',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,28},
          {el,
            [{alt,'PostField28',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,29},
          {el,
            [{alt,'PostField29',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,30},
          {el,
            [{alt,'PostField30',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,31},
          {el,
            [{alt,'PostField31',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,32},
          {el,
            [{alt,'PostField32',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,33},
          {el,
            [{alt,'PostField33',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,34},
          {el,
            [{alt,'PostField34',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,35}],
        [],undefined,undefined,35,1,1,undefined,undefined},
      {type,'PostSchoolsTransaction',sequence,
        [{el,
          [{alt,trans,'TransactionRequest',[],1,1,true,
            undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'QuerySchoolDetailsResponse',sequence,
        [{el,
          [{alt,'QuerySchoolDetailsResult','Response',[],1,1,
            true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'QuerySchoolDetails',sequence,
        [{el,
          [{alt,query,'QueryRequest',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'QueryCustomerDetailsResponse',sequence,
        [{el,
          [{alt,'QueryCustomerDetailsResult','Response',[],1,
            1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'QueryCustomerDetails',sequence,
        [{el,
          [{alt,query,'QueryRequest',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'GetPrepaidVendorDetailsResponse',sequence,
        [{el,
          [{alt,'GetPrepaidVendorDetailsResult','Response',[],
            1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'GetPrepaidVendorDetails',sequence,
        [{el,
          [{alt,query,'QueryRequest',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'Response',sequence,
        [{el,
          [{alt,'ResponseField1',
            {'#PCDATA',char},
            [],1,1,true,undefined}],
          0,1,undefined,2},
          {el,
            [{alt,'ResponseField2',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,3},
          {el,
            [{alt,'ResponseField3',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,4},
          {el,
            [{alt,'ResponseField4',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,5},
          {el,
            [{alt,'ResponseField5',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,6},
          {el,
            [{alt,'ResponseField6',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,7},
          {el,
            [{alt,'ResponseField7',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,8},
          {el,
            [{alt,'ResponseField8',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,9},
          {el,
            [{alt,'ResponseField9',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,10},
          {el,
            [{alt,'ResponseField10',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,11},
          {el,
            [{alt,'ResponseField11',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,12},
          {el,
            [{alt,'ResponseField12',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,13},
          {el,
            [{alt,'ResponseField13',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,14},
          {el,
            [{alt,'ResponseField14',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,15},
          {el,
            [{alt,'ResponseField15',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,16},
          {el,
            [{alt,'ResponseField16',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,17},
          {el,
            [{alt,'ResponseField17',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,18},
          {el,
            [{alt,'ResponseField18',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,19},
          {el,
            [{alt,'ResponseField19',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,20},
          {el,
            [{alt,'ResponseField20',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,21},
          {el,
            [{alt,'ResponseField21',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,22},{el,
          [{alt,'ResponseField22',
            {'#PCDATA',char},
            [],1,1,true,undefined}],
          0,1,undefined,23},
          {el,
            [{alt,'ResponseField23',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,24}],
        [],undefined,undefined,14,1,1,undefined,undefined},
      {type,'GetTransactionDetailsResponse',sequence,
        [{el,
          [{alt,'GetTransactionDetailsResult','Response',[],1,
            1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'QueryRequest',sequence,
        [{el,
          [{alt,'QueryField1',
            {'#PCDATA',char},
            [],1,1,true,undefined}],
          0,1,undefined,2},
          {el,
            [{alt,'QueryField2',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,3},
          {el,
            [{alt,'QueryField3',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,4},
          {el,
            [{alt,'QueryField4',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,5},
          {el,
            [{alt,'QueryField5',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,6},
          {el,
            [{alt,'QueryField6',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,7},
          {el,
            [{alt,'QueryField7',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,8},
          {el,
            [{alt,'QueryField8',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,9},
          {el,
            [{alt,'QueryField9',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,10},
          {el,
            [{alt,'QueryField10',
              {'#PCDATA',char},
              [],1,1,true,undefined}],
            0,1,undefined,11}],
        [],undefined,undefined,11,1,1,undefined,undefined},
      {type,'GetTransactionDetails',sequence,
        [{el,
          [{alt,query,'QueryRequest',[],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'GetServerStatusResponse',sequence,
        [{el,
          [{alt,'GetServerStatusResult',
            {'#PCDATA',char},
            [],1,1,true,undefined}],
          0,1,undefined,2}],
        [],undefined,undefined,2,1,1,undefined,undefined},
      {type,'GetServerStatus',sequence,[],[],undefined,
        undefined,1,1,1,undefined,undefined}],
    [{ns,"http://PegPayPaymentsApi/",undefined,qualified},
      {ns,"http://www.w3.org/2001/XMLSchema","xsd",qualified}],
    "http://PegPayPaymentsApi/",[],false,skip},
  1,undefined,
  [{"http://PegPayPaymentsApi/",undefined}]}).
