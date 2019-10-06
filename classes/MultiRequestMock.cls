/*
* Utility class to create multiple fake responses. User should inject the constructor with a Map of
* SingleRequestMock.
*
* @author Sandeep Bhanot
* @link https://developer.salesforce.com/blogs/developer-relations/2013/03/testing-apex-callouts-using-httpcalloutmock.html
*
*/
@isTest
public class MultiRequestMock implements HttpCalloutMock  {
    Map<String, HttpCalloutMock> requests;

	public MultiRequestMock(Map<String, HttpCalloutMock> requests) {
		this.requests = requests;
	}

	public HTTPResponse respond(HTTPRequest req) {
		HttpCalloutMock mock = requests.get(req.getEndpoint());
		if (mock != null) {
			return mock.respond(req);
		} else {
    			throw new LaHttpClientException('HTTP callout not supported for test methods');
		}
	}

	public void addRequestMock(String url, HttpCalloutMock mock) {
		requests.put(url, mock);
	}
}