from django.contrib import admin
from .models import *

admin.site.register([User, Condition, Hobby, UserStats, Post, Comment, Message, Follow, Location ])