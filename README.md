## NUA MESSAGING APP

Hello people at Nua,

Welcome to your brand new messaging service.

A few notes:

### SETUP

- clone the repo
- run `bundle install`
- run `rails db:create db:migrate db:seed`
- run `rails s`
- go to `localhost:3000` to see it in action

### HOW IT WORKS

- Login from the home screen by picking your username from the dropdown list
- This will take you to the Inbox of the chosen user
- The user can write a new message by clicking on the `+ New message` button. This button is only visible in the inbox section
- When sending a message, the outbox of the sender is updated, and so is the inbox of the receiver.
- If there are unread messages in the receiver's inbox (not in outbox), the number of unread messages is written in the left column

- Only a patient can request a new prescription if he loses one.
- Requesting a new prescription will:
  - create a message in the patient's outbox
  - create an unread message in the Admin's inbox
  - create a payment in the system
  - call the API

### NEXT STEPS (not for now, I'm afraid)

- Proper error handling
- User authentication
- Extend the Message model so that it can have self-referring replies that can be shown in a thread
- Probably a lot of things to make this production proof :-)

LOGIN
![](https://raw.githubusercontent.com/MegEdnazednav/nua-messaging/master/app/assets/images/login-screen.png)


INBOX
![](https://raw.githubusercontent.com/MegEdnazednav/nua-messaging/master/app/assets/images/inbox.png)


OUTBOX
![](https://raw.githubusercontent.com/MegEdnazednav/nua-messaging/master/app/assets/images/outbox.png)


VIEW MESSAGE
![](https://raw.githubusercontent.com/MegEdnazednav/nua-messaging/master/app/assets/images/view-message.png)


REPLY MESSAGE
![](https://raw.githubusercontent.com/MegEdnazednav/nua-messaging/master/app/assets/images/reply-message.png)



