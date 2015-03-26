# Index
The index results returns JSON based on the query string. The query string is parsed for keywords and the SQL database preforms a "indifferent like" search for both tags and names of restaurants.

The index provides a limited amount of information about each restaurant to reduce the load time.

## Serialized
Due to the relational nature of the data, customized serializers create side-loaded JSON. The JSON captures the many-to-many relationships between tags and restaurants.
