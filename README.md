# laHttp
A lightweight http client for Apex


## Usage

### http get

```apex
LaHttp client = new LaHttp();
HttpRespons response = client.get('https://mydomaim.com/api/v1/users').timeout(60).getResponse();
```


### http post

```apex
Map<String, String> headers = new Map<String, String> ();
headers.put('Content-Type','application/json');

List<SampleUser__c> objList = getUsers();

LaHttp client = new LaHttp();
HttpRespons = client.post('https://mydomaim.com/api/v1/users')
.headers(headers)
.bodyToJson(objList).getResponse();
```

### http put

```apex
NamedCredentials namedCredential = new NamedCredentials('MyNamedCredential'); 

SampleUser__c user = new SampleUser__c(Name='John Doe', PlaceOfBirth__c='New York');

LaHttp client = new LaHttp(namedCredential);
client.put('https://www.local.com/api/v1/fruits')
.header('Content-Type','application/json')
.bodyToJson(user).getResponse();
```

## Contributing
Please contact author.

## Sponsor
[IPfolio](https://www.ipfolio.com)

## License
MIT [Kostas Vorilas](mailto:kvorilas@gmail.com)
