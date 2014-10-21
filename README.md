Open Todo API Description
======================
This project adds an external API to a todo app forked from [open-todo](https://github.com/Bloc/open-todo)

Made with my mentor at Bloc.


Setup Instructions
----------------------
Clone this repository. 

Setup postgres

Create a postgres test user and a postgres development user.

Then copy `config/application.example.yml` to `config/application.yml` and add database information. 

Run `bundle install` to install all relevant gems.

Run `rspec` to test the application.


Usage Instructions
----------------------
First start the app and make an account by going to the web app, http://0.0.0.0:3000/

Then visit the user's account page to get an access token. Access tokens must be passed in as a custom header called X-ACCESS-TOKEN

Once you have a token, you can use the following endpoints and json formats to create additional users, lists, and items. Lists and items can also be changed or deleted. Users must be deleted via the web app.

## Endpoints ##

GET /api/v1/users/
Returns json for a list of user ids and usernames

GET /api/v1/users/{user_id}/lists
Returns a list of all open and viewable lists and their items for a user. If you are the user, you will also see your private lists.

POST /api/v1/users/  {user: {username: 'testuser', password: 'testpass'}}
Creates a new user and returns json for the new user's id and username. Username must be unique

GET /api/v1/lists/
Returns json for all open and viewable lists and their items

GET /api/v1/lists/{list_id}
Returns json for a single list and it's items

POST /api/v1/lists/ {user_id: @user.id, list: {name: 'test_list', permissions: 'open'}}
Creates a new list, user_id, name, and permissions are all required. List names must be unique and Permissions can only be set to open, viewable or private.

PATCH /api/v1/lists/{list_id} {user_id: @user.id, list: {name: "new_name", permissions: 'private'}}
Updates a list with a new name or permission if you own the list or if the list is open.

DELETE /api/v1/lists/{list_id}
Deletes a list

POST /api/v1/lists/{list_id}/items {item: {description: 'test_item'}}
Creates a new item if you own the list or if the list is open. Description is required.

PATCH /api/v1/lists/{list_id}/items/{item_id} {user_id: @user.id, list: {name: "new_name", permissions: 'private'}}
Updates an item with a description if you own the list or if the list is open.

DELETE /api/v1/items/{item_id}
Deleting an item marks it as complete and hides it from the list. You have permission to do so if you own the list or the list is open
