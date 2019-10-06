public class BasicAuthentication implements AuthenticationProvider {
    private String username;
    private String password;

    public BasicAuthentication(String username, String password){
        this.username = username;
        this.password = password;
    }

    public String generate() {
        return 'Basic ' + EncodingUtil.base64Encode(Blob.valueof(username + ':' + password));
    }
}