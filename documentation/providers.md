# Search Providers

Providers query their respective services and return a standardized response between all providers.

## ProviderIndex

Manifest of all providers.

<b>#providers</b> - list each provider's key identifier

<b>#self.PROVIDER_NAME</b> - provide any keys or header information required for api requests for each specific provider and creates and instance of the provider object.

## SearchProvider

Parent class to all providers.

<b>#get_json</b> - requires a url, makes a http request and parses the json response.


## Providers

Each provider is responsible for making API calls and returning collections of Restaurant records (non-persisted).
