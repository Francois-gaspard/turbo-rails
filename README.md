# README

This barebones app is the starting point of a small introduction to Turbo-Rails.
It's based on the https://www.hotrails.dev/ Turbo-Rails tutorial, with a number of shortcuts
to make it fit in a time-boxed interactive workshop that focuses on Turbo-Rails.

## Setup
Run the following to set it up:
```
bin/setup
yarn install
```

Seed your database:
```
bin/rails db:seed
```

## Running it
```
bin/dev
```

Then navigate to https://localhost:3000/properties


## Observations

### Turbo is on by default
Turbo handles all links and forms automatically. When navigating from page to page, only the page body is changed and headers are kept.

You can observe Turbo doing its job by editing your `properties/index.html.erb` file. 

1. Make a copy of the existing `index` link.
2. Add `, data: { turbo: false }` to it:
  ```erbruby
    <%= link_to "Regular index",
                properties_path,
                class: "btn btn--primary", 
                data: { turbo: false } %>
  ```
3. Navigate to https://localhost:3000/properties
4. Open your browser developer tools to the `Network` tab and observe the difference when you click on one or the other.

### What if headers need to be updated?

By default, asset tags have the `"data-turbo-track": "reload"` attribute:
```erbruby 
   <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
   <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
```
This tells Turbo to compare the cached assets fingerprint to the server's.
If a change is detected, the whole page is refreshed.

Next: [Single-page form](docs/single_page_form.md)
