[![Build Status](https://travis-ci.org/postazure/OrderNow-API.svg?branch=master)](https://travis-ci.org/postazure/OrderNow-API)

# Restaurant Delivery API


## Models
### Restaurant Methods

<b>diff</b>
```ruby
my_restaurant.diff(new_restaurant)

#=> ['name', 'phone', ...]
#=> nil
```
Note: Does not compare record id's, created_at, updated_at.

Returns an array of the attributes that are different between the existing record and the new record.

<b>diff?</b>
```ruby
my_restaurant.diff?(new_restaurant)

#=> true
#=> false
```
Note: Does not compare record id's, created_at, updated_at.

Returns true if the records are different, or false if the records are the same.
