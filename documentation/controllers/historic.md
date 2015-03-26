# Historic (app/controllers/restaurants_controller.rb)

Historical data is used to order the JSON of results provided by this API. The results are based on the predicted current delivery time. The shortest times appear at the top.

Historical data is saved in the Redis Database as follows:

```
<restaurant_id> : {
  <day_of_week> : {
    <hour_of_day> :{
      count: X,
      avg: X
    }
  }
}
```
Example
`123 : Tuesday : 14 : {avg: 23, count: 40}`

The average is a moving average, and the count is the number of times the average was reported.

Moving Average Formula: `new_avg = (new_delivery_time + (db_count * db_avg))/new_count`
