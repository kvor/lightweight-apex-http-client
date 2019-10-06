public class BasicHttpRequest {

    private HttpRequest httpRequest;


    public BasicHttpRequest(HttpRequest request) {
        this.httpRequest = request;
    }

    public BasicHttpRequest(String httpMethod, String url) {
        this.httpRequest = new HttpRequest();
        this.httpRequest.setEndpoint(url);
        this.httpRequest.setMethod(httpMethod);
    }

    public BasicHttpRequest timeout(Integer timeout) {
        if (timeout < 1 || timeout > 120){
            throw new LaHttpClientException('The timeout can be any value between 1 and 120 seconds.');
        }
        this.httpRequest.setTimeout(timeout*1000);
        return this;
    }

    public BasicHttpRequest header(String key, String value) {
        this.httpRequest.setHeader(key, value);
        return this;
    }

    public BasicHttpRequest headers(Map<String, String> headers) {
        if (headers != null) {
            for (String key : headers.keySet()) {
                header(key, headers.get(key));
            }
        }
        return this;
    }

    public BasicHttpRequest body(String body) {
        this.httpRequest.setBody(body);
        return this;
    }

    public BasicHttpRequest bodyToJson(Object body) {
        String bodyStr = JSON.serialize(body, true);
        this.httpRequest.setBody(bodyStr);
        return this;
    }

    public BasicHttpRequest bodyToJson(Object body, Boolean suppressNulls) {
        String bodyStr = JSON.serialize(body, suppressNulls);
        this.httpRequest.setBody(bodyStr);
        return this;
    }

    public BasicHttpRequest body(Blob body) {
        this.httpRequest.setBodyAsBlob(body);
        return this;
    }

    public BasicHttpRequest xwwwFormUrlEncodedBody(Map<String, String> params) {

        if (params != null && params.size() > 0) {
            String body = '';

            for (String key : params.keySet()) {
                body += key.trim() + '=' + EncodingUtil.urlEncode(params.get(key), HttptHeaders.UTF_8) + '&';
            }

            body = body.removeEnd('&');
            this.httpRequest.setBody(body);
        }

        return this;
    }

    public BasicHttpRequest queryParam(String name, String value) {
        if (String.isBlank(name) || String.isBlank(value)) {
            return this;
        }

        String queryString = '';

        if (this.getUrl().contains('?')) {
            queryString += '&';
        } else {
            queryString += ('?');
        }

        queryString += EncodingUtil.urlEncode(name, HttptHeaders.UTF_8) + '=' + EncodingUtil.urlEncode(value, HttptHeaders.UTF_8);

        this.setUrl(this.getUrl() + queryString);
        return this;
    }

    public BasicHttpRequest queryParam(String name, Boolean value) {
        if (value != null) {
            return queryParam(name, String.valueOf(value));
        }

        return this;
    }

    public BasicHttpRequest queryParam(String name, Integer value) {
        if (value != null) {
            return queryParam(name, String.valueOf(value));
        }

        return this;
    }

    public String getUrl() {
        return this.httpRequest.getEndpoint();
    }

    public void setUrl(String url) {
        this.httpRequest.setEndpoint(url);
    }

    public String getBody() {
        return this.httpRequest.getBody();
    }

    public String getHttpMethod() {
        return this.httpRequest.getMethod();
    }

    public HttpRequest getHttpRequest() {
        return this.httpRequest;
    }

    public HttpResponse getResponse() {
        return new Http().send(this.httpRequest);
    }

}