@IsTest
private class LaHttpTest {
    @IsTest
    static void testProvider() {
        NamedCredentials named = new NamedCredentials('LocalApi');
        System.assertEquals('callout:LocalApi', named.generate(), 'Named credential url does not match');

        BasicAuthentication auth = new BasicAuthentication('myusername', 'mypassword');
        System.assertEquals('Basic ' + EncodingUtil.base64Encode(Blob.valueof('myusername:mypassword')), auth.generate(), 'Basic authentication failed');
    }

    @IsTest
    static void testGet() {
        SingleRequestMock reqMock = new SingleRequestMock(200,
                'OK',
                createGetResponse(),responseHeaders());

        Map<String, HttpCalloutMock> multiResp = new Map<String, HttpCalloutMock>();
        multiResp.put('https://www.local.com/api/v1/fruits', reqMock);

        HttpCalloutMock multiCalloutMock = new MultiRequestMock(multiResp);

        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        LaHttp client = new LaHttp();

        Test.startTest();
        HttpResponse response = client.get('https://www.local.com/api/v1/fruits').timeout(60).getResponse();
        Test.stopTest();

        System.assertEquals(200, response.getStatusCode(), 'Status code is wrong.');
        String body = response.getBody();
        System.assert(body!=null);
        List<String> returnList = (List<String>) JSON.deserialize(body, List<String>.class);
        System.assertEquals(3, returnList.size());
        System.assert(returnList.contains('banana'));

    }

    @IsTest
    static void testWrongArguments() {
        Boolean correctExceptionThrown = false;

        try {
            NamedCredentials cred = new NamedCredentials(null);
        } catch (LaHttpClientException ex) {
            if (ex.getMessage().contains('Blank name is not allowed')){
                correctExceptionThrown = true;
            }
        }
        System.assert(correctExceptionThrown, 'Wrong or no exception was thrown.');

        LaHttp client = new LaHttp();

        Integer timeoutException = 0;
        try {
            client.get('https://www.local.com/api/v1/fruits').timeout(0);
        } catch (LaHttpClientException ex) {
            if (ex.getMessage()== 'The timeout can be any value between 1 and 120 seconds.'){
                timeoutException++;
            }
        }

        try {
            client.get('https://www.local.com/api/v1/fruits').timeout(121);
        } catch (LaHttpClientException ex) {
            if (ex.getMessage()== 'The timeout can be any value between 1 and 120 seconds.'){
                timeoutException++;
            }
        }

        try {
            client.get('https://www.local.com/api/v1/fruits').timeout(1);
        } catch (LaHttpClientException ex) {
            if (ex.getMessage()== 'The timeout can be any value between 1 and 120 seconds.'){
                timeoutException++;
            }
        }

        System.assertEquals(2, timeoutException, 'Testing timeouts failed');
    }



    private static String createGetResponse() {
        return '["banana", "apple", "orange"]';
    }

    private static Map<String, String> responseHeaders() {
        Map<String, String> responseHeaders = new Map<String, String>{
                HttptHeaders.HEADER_CONTENT_TYPE => HttptHeaders.APPLICATION_TYPE_JSON_UTF8
        };
        return responseHeaders;
    }
}