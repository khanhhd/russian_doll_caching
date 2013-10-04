## Fragment caching
This totorial for using fragment caching rails 4 

## Setup
```sh
$ git clone https://github.com/khanhhd/russian_doll_caching.git
$ cd russian_doll_caching
$ bundle install
$ rake db:migrate
```

## Usage
```sh
1. $ rails s
2. Open web brower and access to http://localhost:3000
```
## Russian Doll Caching
1. config envirement development.rb
```sh
   config.action_controller.perform_caching = true
```
2. In views 

```sh
   <% @customers.each do |customer| %>
      <%= render "customers/customer", customer: customer %>
    <% end %>
```
* cache cutomer 

```sh
  <% cache customer do %>
  <tr>
    <td><%= customer.name %></td>
    <td><%= customer.address %></td>
    <td>
      <table>
        <tr>
          <th> product name </th>
        </tr>
  <% customer.products.each do |prod| %>
    <%= render "customers/product", prod: prod %>
  <% end %>
      </table>
    </td>
  </tr>
  <% end %>
```

```sh
  <% customer.products.each do |prod| %>
    <%= render "customers/product", prod: prod %>
  <% end %>
```
* cache product

```sh
  <% cache prod do %>
    <tr>
      <td><%= prod.pro_name %></td>
    </tr>
<% end %>
```

## Result
* The first times : create new customer and go to index page, you can see like 

```sh
Started GET "/customers" for 127.0.0.1 at 2013-10-04 18:25:24 +0700
Processing by CustomersController#index as HTML
  Customer Load (0.6ms)  SELECT "customers".* FROM "customers"
Cache digest for customers/product.html: c5fb55246a3129b956535ab434389e0d
Cache digest for customers/_customer.html: fbdda3154e8c043835599ee5c90b684e
Read fragment views/customers/1-20131004104943753806000/fbdda3154e8c043835599ee5c90b684e (0.2ms)
  Rendered customers/_customer.html.erb (4.8ms)
Read fragment views/customers/2-20131004102544448583000/fbdda3154e8c043835599ee5c90b684e (0.1ms)
  Rendered customers/_customer.html.erb (0.5ms)
Read fragment views/customers/3-20131004112520652109000/fbdda3154e8c043835599ee5c90b684e (0.1ms)
  Product Load (0.1ms)  SELECT "products".* FROM "products" WHERE "products"."customer_id" = ?  [["customer_id", 3]]
Write fragment views/customers/3-20131004112520652109000/fbdda3154e8c043835599ee5c90b684e (0.6ms)
  Rendered customers/_customer.html.erb (17.7ms)
  Rendered customers/index.html.erb within layouts/application (29.5ms)
Completed 200 OK in 36ms (Views: 33.5ms | ActiveRecord: 1.3ms)

```

* The second times: reload! index page of customer you can see the difference

```sh
  Started GET "/customers" for 127.0.0.1 at 2013-10-04 18:28:55 +0700
Processing by CustomersController#index as HTML
  Customer Load (0.2ms)  SELECT "customers".* FROM "customers"
Read fragment views/customers/1-20131004104943753806000/fbdda3154e8c043835599ee5c90b684e (0.2ms)
  Rendered customers/_customer.html.erb (0.9ms)
Read fragment views/customers/2-20131004102544448583000/fbdda3154e8c043835599ee5c90b684e (0.8ms)
  Rendered customers/_customer.html.erb (1.9ms)
Read fragment views/customers/3-20131004112520652109000/fbdda3154e8c043835599ee5c90b684e (0.1ms)
  Rendered customers/_customer.html.erb (0.5ms)
  Rendered customers/index.html.erb within layouts/application (8.1ms)
Completed 200 OK in 13ms (Views: 11.9ms | ActiveRecord: 0.2ms)

```
=> Read from fragment instead of write fragment. that is faters

## Opertion require
ruby 2.0 and rails 4

## Reference
http://edgeguides.rubyonrails.org/caching_with_rails.html#fragment-caching <br>
http://blog.remarkablelabs.com/2012/12/russian-doll-caching-cache-digests-rails-4-countdown-to-2013
