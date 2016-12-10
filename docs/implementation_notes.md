# Implementation Notes

## Core Application

## Requirements

1. The main page of the app should show a list of all contacts
2. The user should be able to click on a single contact to access the details for that contact
  * Details should include:
    * Name
    * Email address
    * Phone Number
    * Postal Address
3. A user should be able to update a contact
4. A user should be able to delete a contact
5. A user should be able to add a new contact

## Implementation

1. Create a YAML file of contact data
2. Load the YAML file in a before block as a hash
3. In the `index.erb` file, output the contents of the contact hash
4. Add a link to each entry that takes the user to the page for that contact
5. Create an 'update' contact link on the contact view which returns a form where the contact data can be updated
6. Create a `POST` route that, when the update form is submitted, the YAML file is updated
7. Add a 'Delete' button to the contact view which when clicked, sends a `POST` request to a delete route
8. Create a `POST` route that, when the delete form is submitted, deletes the appropriate contact from the YAML file
9. Add a 'New Contact' button to the index view which, when clicked, takes the user to a new contact form
10. Create a new contact view form which, when submitted, sends a `POST` request to a create route
11. Create a `POST` route that, when the new contact from is submitted, adds a contact to the YAML file (generating an id that is currently unused)