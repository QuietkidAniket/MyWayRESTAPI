
# My Way app


# Back end :

``` MyWayBackend ```

## to run the server : 

> Navigate to  [/MyWayBackend](https://github.com/QuietkidAniket/MyWayRESTAPI/edit/main/MyWayBackend) file path

    > ``` python manage.py makemigrations mywayapp ```


    > ``` python manage.py migrate ``` 


    > ``` python manage.py runserver _<ip address of your local host/ device where you want to host >:<port number>_ ```


    > for eg. ``` python manage.py runserver 172.16.40.240:8080```


# How to add local host to ALLowed HOST : 

> Navigate to settings.py inside [MyWayBackend/MyWay](https://github.com/QuietkidAniket/MyWayRESTAPI/blob/main/MyWayBackend/MyWay/settings.py)

> Notice there is a python list named : ```ALLOWED HOST``` 

> ADD the IP Address of your device (not the port number) inside quotes " " to the list 

##  ================   API   ======================

>``` user/<str:username>/ ``` &emsp;&emsp; -> user/ _username of user to be followed_

>``` follow/<str:username>/ ``` &emsp;&emsp; -> follow/ _username of user to be followed_

>``` feed/ ```  -> simple API call

>``` localusers/<str:username> ``` &emsp;&emsp; -> localusers/ _username of user to be followed_

>``` similarconditions/<str:username> ``` &emsp;&emsp; -> similarconditions/ _username of user to be followed_

>``` similarhobbies/<str:username> ``` &emsp;&emsp;   -> similarhobbies/ _username of user to be followed_
 
>``` invalid/ ```  &emsp;&emsp; -> No explicit API call needed, shows 404 error (both HTTPresponse and JSONresponse)

>``` post/<str:pk>/get/ ``` &emsp;&emsp; -> json GET request format := post/<_id of post_/get/

>``` post/create/ ``` &emsp;&emsp; -> json POST /PUT request format := {"content" : "_content_"}

>```  post<str:pk>/update/ ``` &emsp;&emsp; -> json PUT request format := {"content" : "_content_"}

>``` login/ ```  &emsp;&emsp;  -> json POST request format  := {"username" : "_name_" , "password" : "_password_"}

>``` logout/ ```  &emsp;&emsp; -> Simple API request

>``` register/ ```  &emsp;&emsp; -> json POST request format  := {"username" : "_name_" , "email" : "_email_", "password" : "_password_", "confirmation" : "_re nter the password_"}

## General API call type for GET, POST/PUT, and DELETE for models

<strong> Type - 1 : </strong>
> _name of the model_/    &emsp;&emsp; -> GET request for fetching information of all the available instances of the model


<strong> Type - 2 : </strong>
> _name of the model_/_id_/    &emsp;&emsp; ->   GET request for fetching information of model instance with that id

<strong> Type - 3 : </strong>
> _name of the model_/_id_/   &emsp;&emsp; ->   PUT/POST/DELETE request for posting or deleting information of model instance with that id

### Models and an example of their respective general GET JSON Response formats : 
> ### NOTE see above under "General API calls" for reference to API call type 1 and type 2. Also you can hint the PUT/POST and DELETE request formats from the above.


### users
* <strong>list of objects (API call type 1): </strong>
    
    {

         "count": 3,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 3,
                "url": "http://192.168.144.243:8080/users/3/",
                "username": "User2",
                "email": "user2@gmail.com",
                "groups": []
            },
            {
                "id": 2,
                "url": "http://192.168.144.243:8080/users/2/",
                "username": "Aniket",
                "email": "aniketkundu12072004@gmail.com",
                "groups": []
            },
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/users/1/",
                "username": "Admin",
                "email": "aniketkundu12072004@gmail.com",
                "groups": []
            }
        ]
    }


*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/users/1/",
        "username": "Admin",
        "email": "adminmail123@gmail.com",
        "groups": []
    }

### groups   &emsp;&emsp;&emsp;&emsp;  

* <strong>list of objects (API call type 1): </strong>

    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/groups/1/",
                "name": "Group1"
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/groups/1/",
        "name": "Group1"
    }



### userstats
* <strong>list of objects (API call type 1): </strong>
    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "status": "Living",
                "isverified": false,
                "user": 2,
                "conditions": null,
                "hobbies": null,
                "location": 1,
                "badge": null
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>
    {

        "id": 1,
        "status": "Living",
        "isverified": false,
        "user": 2,
        "conditions": null,
        "hobbies": null,
        "location": 1,
        "badge": null
    }


### post
* <strong>list of objects (API call type 1): </strong>       
    {

        "count": 2,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "content": "First post",
                "date": "2024-03-15",
                "views": 0,
                "upvotes": 0,
                "user": 1,
                "community": null
            },
            {
                "id": 2,
                "content": "HEHEEEEHEHHE",
                "date": "2024-03-16",
                "views": 0,
                "upvotes": 0,
                "user": 1,
                "community": null
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "content": "First post",
        "date": "2024-03-15",
        "views": 0,
        "upvotes": 0,
        "user": 1,
        "community": null
    }

### comment
* <strong>list of objects (API call type 1): </strong>
    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "content": "Really innovative",
                "created": "2024-03-15",
                "updated": "2024-03-15",
                "upvotes": 0,
                "user": 1,
                "community": null,
                "post": 1
            }
        ]
    }


*  <strong>specific object (API call type 2): </strong>
    {

        "id": 1,
        "content": "Really innovative",
        "created": "2024-03-15",
        "updated": "2024-03-15",
        "upvotes": 0,
        "user": 1,
        "community": null,
        "post": 1
    }

### message
* <strong>list of objects (API call type 1): </strong>

    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/groups/1/",
                "name": "Group1"
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/groups/1/",
        "name": "Group1"
    }

### location
* <strong>list of objects (API call type 1): </strong>

    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/groups/1/",
                "name": "Group1"
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/groups/1/",
        "name": "Group1"
    }

### follow
* <strong>list of objects (API call type 1): </strong>

    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/groups/1/",
                "name": "Group1"
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/groups/1/",
        "name": "Group1"
    }

### condition
* <strong>list of objects (API call type 1): </strong>

    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/groups/1/",
                "name": "Group1"
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/groups/1/",
        "name": "Group1"
    }

### hobby
* <strong>list of objects (API call type 1): </strong>

    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/groups/1/",
                "name": "Group1"
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/groups/1/",
        "name": "Group1"
    }

### community
* <strong>list of objects (API call type 1): </strong>

    {

        "count": 1,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 1,
                "url": "http://192.168.144.243:8080/groups/1/",
                "name": "Group1"
            }
        ]
    }



*  <strong>specific object (API call type 2): </strong>

    {

        "id": 1,
        "url": "http://192.168.144.243:8080/groups/1/",
        "name": "Group1"
    }




     

