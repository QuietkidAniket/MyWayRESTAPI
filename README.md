
# My Way app


# Back end :

``` MyWayBackend ```

## to run the server : 

> ``` python manage.py makemigrations mywayapp ```

> ``` python manage.py migrate ``` 

> ``` python manage.py runserver _<ip address of your local host/ device where you want to host >:<port number>_ ```

> for eg. ``` python manage.py runserver 172.16.40.240:8080```


# How to add local host to ALLowed HOST : 

> Navigate to settings.py inside MyWayBackend/MyWay

> Notice there is a python list named : ```ALLOWED HOST```

> ADD the IP Address of your device (not the port number) inside quotes " " to the list 

##  ================   API   ======================

>``` user/<str:username>/ ``` &emsp;&emsp; | user/ _username of user to be followed_

>``` follow/<str:username>/ ``` &emsp;&emsp;| follow/ _username of user to be followed_

>``` feed/ ```  | simple API call

>``` localusers/<str:username> ``` &emsp;&emsp;| localusers/ _username of user to be followed_

>``` similarconditions/<str:username> ``` &emsp;&emsp; | similarconditions/ _username of user to be followed_

>``` similarhobbies/<str:username> ``` &emsp;&emsp;| similarhobbies/ _username of user to be followed_
 
>``` invalid/ ```  &emsp;&emsp; | No explicit API call needed, shows 404 error (both HTTPresponse and JSONresponse)

>``` post/<str:pk>/get/ ``` &emsp;&emsp; | json GET format := post/<_id of post_/get/

>``` post/create/ ``` &emsp;&emsp; | json POST /PUT format := {"content" : "_content_"}

>```  post<str:pk>/update/ ``` &emsp;&emsp; | json PUT format := {"content" : "_content_"}

>``` login/ ```  &emsp;&emsp;  | json request format  := {"username" : "_name_" , "password" : "_password_"}

>``` logout/ ```  &emsp;&emsp; | Simple API request

>``` register/ ```  &emsp;&emsp; | json request format  := {"username" : "_name_" , "email" : "_email_", "password" : "_password_", "confirmation" : "_re nter the password_"}

     

