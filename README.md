
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

>``` user/<str:username>/ ```

>``` follow/<str:username>/ ```

>``` feed/ ```

>``` localusers/<str:username> ```

>``` similarconditions/<str:username> ```

>``` similarhobbies/<str:username> ```

>``` invalid/ ```

>``` post/<str:pk>/get/ ```

>``` post/create/ ```

>``` post<str:pk>/update/ ```

>``` login/ ```

>``` logout/ ```

>``` register/ ```

     

