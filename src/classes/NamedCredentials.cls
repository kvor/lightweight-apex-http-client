public class NamedCredentials implements AuthenticationProvider {

    private String name;

    public NamedCredentials(String name) {
        this.name = name;
        if (String.isBlank(name)) {
            throw new LaHttpClientException('Named Credentials:: Blank name is not allowed.');
        }
    }

    public String generate() {
        return 'callout:' + name;
    }

}