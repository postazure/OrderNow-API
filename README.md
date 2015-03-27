# Restaurant Delivery API v2.0
[![Build Status](https://travis-ci.org/postazure/OrderNow-API.svg?branch=master)](https://travis-ci.org/postazure/OrderNow-API)

###<u>[Documentation](https://github.com/postazure/OrderNow-API/tree/master/documentation)</u>

* [Controller Methods & Actions](https://github.com/postazure/OrderNow-API/tree/master/documentation/controllers)

* [Helper Methods](https://github.com/postazure/OrderNow-API/tree/master/documentation/helpers)

* [Models](https://github.com/postazure/OrderNow-API/tree/master/documentation/models)

* [Tasks](https://github.com/postazure/OrderNow-API/tree/master/documentation/tasks)

<hr>

###<u>Change Log</u>
<u>v2.0.0</u>
* Complete Redesign of Codebase - Reduced load time by more than 6 seconds.
* Removal of UI - Now a [Separate Project](https://github.com/postazure/OrderNow-FrontEnd)
* Added Yelp Information
* Improved Search Functionality
* Predictive Delivery Times - Incorporated Redis
* Task Scheduling

#### Planned Improvements
* Additional Providers
* Improved Delivery Time Predictions
* User Feedback for Delivery Service Predictions
* Business Advertisement
* Individual Catering Service Advertisement
* Delivery Service Advertisement

<hr>
###<u>About This Project</u>
The first version of the code simply took a zip code and a category of food and then forwarded those requests to different delivery services. The results were then returned and converted to objects. These objects were then displayed to the user. As an MVP this was acceptable. However, because the request was made on an external server and the volume of data could be very large the wait time was often greater than six seconds. The pages were all server rendered with no JavaScript which ment that nothing was presented to the user until the call from the search providers was complete. This was very bad from a ux perspective.

For the second version my goal was to immediately present something to the user, and provide some additional information that seems important when ordering food. Like yelp reviews, review count, etc. I rewrote the entire code base. Now my server would collect restaurant data, and yelp data at night. Then when the user made a query, I could display that data to the user immediately. As that was added to the page, the client side application would begin making Ajax calls to retrieve the actual estimated delivery time. The results would then be ordered by their wait time. In order to reduce the reordering and to present the restaurants in their most likely order given the actual times I decided to store the information.

Restaurant delivery times fluctuate on a minute to minute basis. So recording them is a matter of storing the day of the week and the time of the day. One hour intervals seemed appropriate. This meant that my database would need tables for days of week columns for hours. The amount of space that I needed to carve out for the database would be very large, and the qty of data occupying that space oils be very small. I decided that the relational data was best left in my Postgres database and that I would need a second database to store some of the more sporadic data. Redis seemed to be a good choice. The moving average and the count of occurrences would be stored under hour of the day, under day of the week, under the restaurant's ID from the Postgres database.

To reduce the number or calls to the external APIs and to have the most accurate data at the times the app is most used the moving average data is collected when the users' client retrieves it from the delivery services.
<hr>
