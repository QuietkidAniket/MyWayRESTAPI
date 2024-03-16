from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.exceptions import ValidationError
from django.utils import timezone

class User(AbstractUser):
    pass

Category_choices = [
    (Medical := "Medical","Medical"),
    (Physical_wellbeing := "Physical Well Being", "Physical Well Being"),
    (Mental_wellbeing := "Mental Well Being", "Mental Well Being")
]


class Condition(models.Model):
    """ Conditions:
    name = models.CharField(max_length = 20)
    \ncategory =  models.CharField(max_length=50, choices=Category_choices, null=False)
    \ndescription = models.CharField(max_length = 1000)
    """
    name = models.CharField(max_length = 20)
    category =  models.CharField(max_length=50, choices=Category_choices, null=False)
    description = models.CharField(max_length = 1000)

    def __str__(self):
        return f"Condition name : {self.name}, Category : {self.category} Description : {self.description}"


class Community(models.Model):
    owner = models.ForeignKey(User, on_delete=models.CASCADE, related_name = "communities_owned")
    related_condition = models.ForeignKey(Condition, on_delete= models.CASCADE, related_name = "communities_related_to_condition")
    description = models.CharField(max_length = 1000)

class Moderators(models.Model):
    mod = models.ForeignKey(User, on_delete= models.CASCADE, related_name = "community_moderated")
    community = models.ForeignKey(Community, on_delete = models.CASCADE, related_name = "moderators")

class Hobby(models.Model):
    """Hobbies :
    name = models.CharField(max_length = 20)
    \ncategory = models.CharField(max_length=50, choices=Category_choices, null=False)
    \ndescription = models.CharField(max_length = 100)
    """
    name = models.CharField(max_length = 20)
    category = models.CharField(max_length=50, choices=Category_choices, null=False)
    description = models.CharField(max_length = 100)

    def __str__(self):
        return f"Hobby name : {self.name}, Category : {self.category} Description : {self.description}"


class Badge(models.Model):
    """ Badges : 
        name = models.CharField(max_length = 30)
        \ndescription = models.CharField(max_length = 200)
    """
    name = models.CharField(max_length = 30)
    description = models.CharField(max_length = 200)


class Location(models.Model):
    """ Location :
        region = models.CharField(max_length = 50)
        \ncountry = models.CharField(max_length = 56)
        \nlatitude = models.FloatField()
        \nlongitude = models.FloatField()
    """
    region = models.CharField(max_length = 50)
    country = models.CharField(max_length = 56)
    latitude = models.FloatField()
    longitude = models.FloatField()

    def __str__(self):
        return self.region[0:50]


class UserStats(models.Model):
    """ User Statistics:
        \nuser = models.ForeignKey(User, on_delete=models.CASCADE, related_name="stats")
        \nconditions = models.ForeignKey(Condition, on_delete = models.PROTECT, null= True, related_name="people_with_similar_conditions")
        \nhobbies = models.ForeignKey(Hobby, null=True, on_delete=models.PROTECT, related_name = "people_with_similar_hobbies")
        \nlocation = models.ForeignKey(Location, on_delete = models.PROTECT, related_name = "people_within_same_region")
        \nstatus = models.CharField( max_length = 50, null=True)
        \nisverified = models.BooleanField(default=True)
        \nispractitioner = models.BooleanField(default=False)
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="stats")    
    conditions = models.ForeignKey(Condition, on_delete = models.PROTECT, null= True, blank=True,related_name="people_with_similar_conditions")
    hobbies = models.ForeignKey(Hobby, null=True, on_delete=models.PROTECT, blank = True, related_name = "people_with_similar_hobbies")
    location = models.ForeignKey(Location, on_delete = models.PROTECT, blank = True, null= True, related_name = "people_within_same_region")
    status = models.CharField( max_length = 50, null=True)
    isverified = models.BooleanField(default=False)
    badge = models.ForeignKey(Badge, on_delete = models.PROTECT, null = True, blank = True, related_name = "people_with_similar_badges")

    def __str__(self):
        return f"{self.user.username}'s data "


class Post(models.Model):
    """ Posts by users:
        \nuser = models.ForeignKey(User, on_delete= models.CASCADE, related_name = "posts")
        \ncontent = models.CharField(max_length=500)
        \ndate = models.DateField(default = timezone.now)    
    """
    user = models.ForeignKey(User, on_delete= models.CASCADE, related_name = "posts")
    community = models.ForeignKey(Community, blank = True, null = True, on_delete = models.PROTECT ,related_name = "posts_related_to_group")
    content = models.CharField(max_length=500)
    date = models.DateField(default = timezone.now)
    views = models.IntegerField(default = 0)
    upvotes = models.IntegerField(default = 0)

    def __str__(self):
        return f"Post created by {self.user.username} on {self.date}"


class Comment(models.Model):
    """ Comments by users : 
        user = models.ForeignKey(User, on_delete = models.CASCADE, related_name="comments")
        \ncontent = models.CharField(max_length=500)
        \ncreated = models.DateField(auto_now_add = True)
        \nupdated = models.DateField(auto_now = True)
    """
    user = models.ForeignKey(User, on_delete = models.CASCADE, related_name="comments")
    community = models.ForeignKey(Community, blank = True, null= True,on_delete = models.PROTECT, related_name = "comments_related_to_group")
    post = models.ForeignKey(Post, on_delete = models.CASCADE, related_name = "post_comments")
    content = models.CharField(max_length=500)
    created = models.DateField(auto_now_add = True)
    updated = models.DateField(auto_now = True)
    upvotes = models.IntegerField(default = 0)

    def __str__(self):
        return self.content[0:50]


class Message(models.Model):
    """ Messages by users
        user = models.ForeignKey(User, on_delete = models.CASCADE, related_name="messages")
        \ncontent = models.CharField(max_length=500)
        \ncreated = models.DateField(auto_now_add = True)
        \nisedited = models.BooleanField(default= False)
        \nupdated = models.DateField(null= True)
    """
    user = models.ForeignKey(User, on_delete = models.CASCADE, related_name="messages")
    community = models.ForeignKey(Community, blank = True, null = True, on_delete = models.PROTECT, related_name = "messages_related_to_group")
    content = models.CharField(max_length=500)
    created = models.DateField(auto_now_add = True)
    isedited = models.BooleanField(default= False)
    updated = models.DateField(null= True)
    
    def __str__(self):
        return f"{self.user} created this message on {self.created}, is edited : {self.isedited}"


class Follow(models.Model):
    """ Follow relationships between two users :
        user = models.ForeignKey(User, on_delete = models.CASCADE, related_name="following_list")
        \nfollowing = models.ForeignKey(User, blank = True, on_delete = models.CASCADE, related_name = "followers_list")
    """
    user = models.ForeignKey(User, on_delete = models.CASCADE, related_name="following_list")
    following = models.ForeignKey(User, blank = True, on_delete = models.CASCADE, related_name = "followers_list")

    def __str__(self):
        return f"{self.user.username} follows {self.following.username}"


class Like(models.Model):
    """ Likes by users
        user = models.ForeignKey(User, on_delete = models.CASCADE, related_name = "likes_by_user")
        \npost = models.ForeignKey(Post, blank = True, related_name = "posts_liked")
        \ncomment = models.ForeignKey(Post, blank = True, related_name ="comments_liked")
    """
    user = models.ForeignKey(User, on_delete = models.CASCADE, related_name = "likes_by_user")
    post = models.ForeignKey(Post, blank = True, null = True, on_delete = models.PROTECT, related_name = "posts_liked")
    comment = models.ForeignKey(Post, blank = True, null =  True, on_delete = models.PROTECT, related_name ="comments_liked")

    def __str__(self):
        return f"Like by {self.user.username} "
    

    
