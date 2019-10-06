public class LaHttp {
    private AuthenticationProvider provider;

    public LaHttp() {
    }

    public LaHttp(AuthenticationProvider provider) {
        this.provider = provider;
    }

    public BasicHttpRequest get(String url) {
        return new BasicHttpRequest(HttpMethod.GET, url);
    }

    public BasicHttpRequest options(String url) {
        return new BasicHttpRequest(HttpMethod.OPTIONS, url);
    }

    public BasicHttpRequest post(String url) {
        return new BasicHttpRequest(HttpMethod.POST, url);
    }

    public BasicHttpRequest del(String url) {
        return new BasicHttpRequest(HttpMethod.DEL, url);
    }

    public BasicHttpRequest patch(String url) {
        return new BasicHttpRequest(HttpMethod.PATCH, url);
    }

    public BasicHttpRequest put(String url) {
        return new BasicHttpRequest(HttpMethod.PUT, url);
    }

    private String createUrl(String url) {
        if (provider != null && provider instanceof NamedCredentials) {
            return provider.generate() + (url.startsWith('/') ? url : '/' + url);
        }
        return url;
    }

    private BasicHttpRequest prepareRequest(String method, String url) {
        BasicHttpRequest request = new BasicHttpRequest(method, url);

        if (provider != null && provider instanceof BasicAuthentication) {
            request.header(HttptHeaders.HEADER_AUTHORIZATION, provider.generate());
        }

        return request;
    }

    public HttpResponse call(HttpRequest request) {
        return new BasicHttpRequest(request).getResponse();
    }

}