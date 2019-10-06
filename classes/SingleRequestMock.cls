/*
* Utility class to fake responses when testing http callouts. This class can be injected to MultiRequestMock class in the
* case where multiple callouts need to be tested.
*
* @author Sandeep Bhanot
* @link https://developer.salesforce.com/blogs/developer-relations/2013/03/testing-apex-callouts-using-httpcalloutmock.html
*
*/

@isTest
public class SingleRequestMock implements HttpCalloutMock {
   		protected Integer code;
		protected String status;
		protected String bodyAsString;
		protected Blob bodyAsBlob;
		protected Map<String, String> responseHeaders;

        public SingleRequestMock(Integer code, String status, String body,
                                         Map<String, String> responseHeaders) {
			this.code = code;
			this.status = status;
			this.bodyAsString = body;
			this.bodyAsBlob = null;
			this.responseHeaders = responseHeaders;
		}

        public SingleRequestMock(Integer code, String status, Blob body,
                                         Map<String, String> responseHeaders) {
			this.code = code;
			this.status = status;
			this.bodyAsBlob = body;
			this.bodyAsString = null;
			this.responseHeaders = responseHeaders;
		}

        public HTTPResponse respond(HTTPRequest req) {
	        HttpResponse resp = new HttpResponse();
			resp.setStatusCode(code);
			resp.setStatus(status);
			if (bodyAsBlob == null) {
                resp.setBody(bodyAsString);
			} else {
				resp.setBodyAsBlob(bodyAsBlob);
			}

			if (responseHeaders != null) {
			     for (String key : responseHeaders.keySet()) {
				    resp.setHeader(key, responseHeaders.get(key));
			     }
			}
			return resp;
	    }
}