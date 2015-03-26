# Search Providers

Each provider should return a collection of <b>restaurant</b> active records. These records are not yet saved to the database.

Each provider is responsible for making API calls and returning collections of Restaurant records (non-persisted).

<b>#to_restaurants</b> - Returns an Array of Restaurant records. Note: The records have not been saved to the database.

<i>Search Providers are built in a modular way so that additional ones can be added.</i>

## ProviderIndex  (lib/search_providers/provider_index.rb)

Provider Index is an abstract class with a manifest of all the search providers. It also holds the code to execute each provider's search function.

<b>#providers</b> - list each provider's key identifier

<b>#PROVIDER_NAME</b> - provide any keys or header information required for api requests for each specific provider and creates and instance of the provider object.

# Providers

## SearchProvider (lib/search_providers/search_provider.rb)

Parent class to all providers.

<b>#get_json</b> - requires a url, makes a http request and parses the json response.

## OrderAheadProvider (lib/search_providers/order_ahead_provider.rb)

Makes an API call to the order ahead api and returns restaurants' core data.
