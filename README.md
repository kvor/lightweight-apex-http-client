# laHttp
A lightweight Apex http client


## Usage

### get

```apex
LaHttp client = new LaHttp();
HttpResponse response = client.get('https://mydomaim.com/api/v1/users').timeout(60).getResponse();
```


### post

```apex
Map<String, String> headers = new Map<String, String> ();
headers.put('Content-Type','application/json');

List<SampleUser__c> objList = getUsers();

LaHttp client = new LaHttp();
HttpResponse = client.post('https://mydomaim.com/api/v1/users').headers(headers).bodyToJson(objList).getResponse();
```

### put

```apex
NamedCredentials namedCredential = new NamedCredentials('MyNamedCredential'); 

SampleUser__c user = new SampleUser__c(Name='John Doe', PlaceOfBirth__c='New York');

LaHttp client = new LaHttp(namedCredential);
client.put('https://mydomaim.com/api/v1/users').header('Content-Type','application/json').bodyToJson(user).getResponse();
```


## http methods

method | signature | example 
--- | --- | --- 
get | get(String url) | `client.get('https://mydomaim.com/api/v1/users')`
post | post(String url) | `client.post('https://mydomaim.com/api/v1/users')` 
put | put(String url) | `client.put('https://mydomaim.com/api/v1/users')` 
patch | patch(String url) | `client.patch('https://mydomaim.com/api/v1/users')` 
del | del(String url) | `client.del('https://mydomaim.com/api/v1/users')` 
options | options(String url) | `client.options('https://mydomaim.com/api/v1/users')` 

## methods
signature| description | example 
--- | --- | --- 
`timeout(Integer timeout)` | Sets the timeout in milliseconds for the request. | `client.get('url').timeout(10);`
`header(String key, String value)` | Adds the contents of the request header. | `client.get('url').header('Content-Type', 'application/json');`
`header(Map<String, String> headers)` | Adds multiples headers to the request. | `client.get('url').header(new Map<String, String> {'Content-Type' => 'application/json')});`
`body(String body)` | Sets the contents of the body for this request | `client.get('url').body('{"userId":"1"}');`
`bodyToJson(Object body, Boolean suppressNulls)` | Serializes an object and sets it to the contents of the body for this request. | `client.get('url').bodyToJson(new Person__c(Name='John'), false);`
`body(Object body)` | Same as bodyToJson(Object body, Boolean suppressNulls) and suppresses null attributes | `client.get('url').body(new Person__c(Name='John'))`
`body(Blob body)` | Sets a Blob as the contents of the body for this request. | `client.get('url').body(Blob.valueOf('{"userId":"1"}'))`


## Sponsor
[IPfolio](https://www.ipfolio.com)

## License
MIT [Kostas Vorilas](mailto:kvorilas@gmail.com)
