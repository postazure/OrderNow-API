# Harvesters
Harvesters scrape or make API calls to gather additional information for each restaurant.

## Harvester Index (lib/harvesters/harvester_index.rb)
Maintains a manifest of all harvesters.

Provides methods to call and save data from each harvester in the manifest.

## Yelp Harvester (lib/harvesters/yelp_harvester.rb)
Queries Yelp's API to retrieve additional information about each restaurant in the database.

Tags, or categories are used to help better identify restaurants during search.

Additional information is currently only used as display elements for the user.
