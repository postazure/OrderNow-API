## Restaurant
### Validations

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

### Attributes
(Core)          name

(Core)          phone_number

(Core)          source_name

(Core)          source_url

(Core)          logo_url

(Core)          yelp_url

(Core)          delivery_hours_start

(Core)          delivery_hours_end

(Timestamps)    created_at

(Timestamps)    updated_at

(Historic)      redis_key

(Historic)      interval_rank


<b>Core</b>

Information Displayed to the user or used to filter results. Required for normal functionality.

<b>Timestamps</b>

Timestamps related to creation or alteration of restaurant record.

<b>Historic</b>  

Information used to create predictions about current delivery times.
