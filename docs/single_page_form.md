# Single Page Form

## Introducing Turbo-Frames

> Turbo Frames are independent pieces of a web page that can be appended, prepended, replaced, or removed without a complete page refresh and without writing a single line of JavaScript

Another way of looking at it:

Turbo Frames provide either:
- A location that needs to be updated on your `current page`
- Or the content from the `response page` that updates that location

### Applying this to Property creation

Currently, clicking on `New Property` takes you to a different page. Let's use Turbo to render the form in place instead.


#### 1. Tagging the location on the current page

We want to render the `New Property` form on top of our Index page. Let's mark that location with a turbo frame:

```erbruby
<%# app/views/properties/index.html.erb %>

<main class="container">
  <%= turbo_frame_tag "first_turbo_frame" do %>
    <div class="header">
      <h1>Properties</h1>
      <%= link_to "New Property", new_property_path, class: "btn btn--primary" %>
    </div>
  <% end %>

  <%= render @properties %>
</main>
```
---
>### Rule 1
> 
> When clicking on a link within a Turbo Frame, Turbo expects a frame of the same id on the response page.
>
> It will then replace the Frame's content on the current page with the Frame's content on the response page.
---


Refresh the page and click on  the `New Property` button: the header disappears!

Also, your browser console outputs:

```
Response has no matching <turbo-frame id="first_turbo_frame"> element
```


This is because we provided the current page a location to update, but no matching turbo frame content in the response.

#### 2. Tagging the content in the response

When you click on your 'New property' link, the response is rendered by the `properties/new.html.erb` view.
Let's put the content we want to render in a Turbo Frame:

```erbruby
<%# app/views/properties/new.html.erb %>

<main class="container">
  <%= link_to sanitize("&larr; Back to properties"), properties_path %>

  <div class="header">
    <h1>New Property</h1>
  </div>

  <%= turbo_frame_tag "first_turbo_frame" do %>
    <%= render "form", property: @property %>
  <% end %>
</main>
```
Now if you try again, Turbo renders the response `first_turbo_frame` frame in the current page `first_turbo_frame` frame.

### Learnings
> When clicking on a link within a Turbo Frame, if there is a frame with the same id on the response page, Turbo will replace the content of the Turbo Frame of the current page with the content of the Turbo Frame of the response page.


#### Rule 3
