
# My Way app


# Back end :

``` MyWayBackend ```

## to run the server : 

> ``` python manage.py makemigrations mywayapp ```

> ``` python manage.py migrate ``` 

> ``` python manage.py runserver ```


# How to add local host to ALLowed HOST : 

> Navigate to settings.py inside MyWayBackend/MyWay

> Notice there is a python list named : ```ALLOWED HOST```

> ADD the IP Address of your device (not the port number) inside quotes " " to the list 

##  ================   API   ======================

>``` user/<str:username>/ ``` | user/<username_of_user_to_be_followed>

>``` follow/<str:username>/ ``` | follow/<username_of_user_to_be_followed>

>``` feed/ ```  | simple API call

>``` localusers/<str:username> ``` | localusers/<username_of_user_to_be_followed>

>``` similarconditions/<str:username> ``` | similarconditions/_username_of_user_to_be_followed_

>``` similarhobbies/<str:username> ``` | similarhobbies/ _username of user to be followed_

>``` invalid/ ``` | No explicit API call needed, shows 404 error (both HTTPresponse and JSONresponse)

>``` post/<str:pk>/get/ ``` | json GET format := post/<_id of post_/get/

>``` post/create/ ``` | json POST /PUT format := {"content" : "_content_"}

>```  post<str:pk>/update/ ``` | json PUT format := {"content" : "_content_"}

>``` login/ ```   | json request format  := {"username" : "_name_" , "password" : "_password_"}

>``` logout/ ``` | Simple API request

>``` register/ ``` | json request format  := {"username" : "_name_" , "email" : "_email_", "password" : "_password_", "confirmation" : "_re nter the password_"}

     

