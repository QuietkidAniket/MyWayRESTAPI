from django.http import HttpResponse, HttpResponseRedirect, JsonResponse, HttpResponseBadRequest
from .models import *
import operator
from django.db.models.query import QuerySet
from .serializers import *
from django.contrib.auth import authenticate, login, logout
from django.db import IntegrityError
from django.contrib.auth.models import Group
from rest_framework import permissions, viewsets
from rest_framework.reverse import reverse
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator


@api_view(['GET'])
def api_root(request):
    return HttpResponseRedirect('feed/')


@api_view(['GET', 'PUT', 'POST', 'DELETE'])
def invalid(request):
    return HttpResponse("Invalid Request", 404)

@login_required
@api_view(['GET'])
def userprofile(request, username):
    queryset= UserStats.objects.get(user = username)
    serializer_class = UserStatsSerializer(queryset, many = False)
    return JsonResponse(serializer_class.data, safe = False)


@login_required
@api_view(['GET'])
def LocalUsers(request, username):
    """
    API endpoint that allows notes to be viewed or edited.
    """
    try:
        user = User.objects.get(username = username)
    except: 
        return HttpResponse("Invalid Request", 404)
    location = UserStats.objects.get(user= user).location
    queryset = location.people_within_same_region
    serializer_class = UserStatsSerializer(queryset, many = True, context={'request': request})
    return JsonResponse(serializer_class.data, safe = False)


@login_required
@api_view(['GET'])
def UsersWithSimilarCondition(request, username):
    """
    API endpoint that allows notes to be viewed or edited.
    """
    try:
        user = User.objects.get(username = username)
    except: 
        return HttpResponse("Invalid Request", 404)
    condition = UserStats.objects.get(user= user).conditions
    queryset = condition.people_with_similar_conditions
    serializer_class = UserStatsSerializer(queryset, many = True, context={'request': request})
    return JsonResponse(serializer_class.data, safe =False)


@login_required
@api_view(['GET'])
def UsersWithSimilarHobby(request, username):
    """
    API endpoint that allows notes to be viewed or edited.
    """
    try:
        user = User.objects.get(username = username)
    except: 
        return HttpResponse("Invalid Request", 404)
    location = UserStats.objects.get(user= user).hobbies
    queryset = location.people_with_similar_hobbies
    serializer_class = UserStatsSerializer(queryset, many = True, context={'request': request})
    return JsonResponse(serializer_class.data, safe = False)

@login_required
@api_view(['GET'])
def getfeed(request):
    user = request.user

    following_objects = user.following_list.all()
    try:
        following_posts = following_objects[0].following.posts.order_by('-date')[:10]
    except:
        return JsonResponse({"content" : "empty"})
    for x in following_objects:
        following_posts |=  x.following.posts.order_by('-date')[:10]
    serializer_class = PostSerializer(following_posts, many = True, context= {'request' : request })
    return JsonResponse(serializer_class.data, safe = False)

    

@login_required
@api_view(['GET'])
def getpost(request, pk):
    queryset = Post.objects.get(id = pk)
    serializer_class = PostSerializer(queryset, many = False, context={'request': request})
    return JsonResponse(serializer_class.data, safe = False)


@api_view(['PUT', 'POST'])
def putpost(request):
    """ 
     API endpoint that creates new posts
    """
    post = Post.objects.create(
    user = request.user,
    content = request.data['body']
    )
    serializer_class = PostSerializer(post, many = False, context={'request': request})
    if(serializer_class.is_valid()):
        serializer_class.save()
    return Response(serializer_class.data)
    
@api_view(['PUT'])
def updatepost(request, pk):
    post = Post.objects.get(id= pk)
    serializer_class = PostSerializer(post, data = request.data)
    if(serializer_class.is_valid()):
        serializer_class.save()
    return JsonResponse(serializer_class.data, safe = False)


@api_view(['GET'])
def follow(request, username):
    user =  User.objects.get(username = username)
    try:
        obj = Follow.objects.get(user = request.user, following = user)
        obj.delete()
        return JsonResponse({"content"  : "unfollowed"})
    except:
        follow_obj = Follow(user = request.user, following = user)
        follow_obj.save() 
        return JsonResponse({"content" : "followed"})    
    


""" 
    All functions after this comment are for
    Admin only views + standard login, logout and register function 
"""


class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]


class GroupViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = Group.objects.all()
    serializer_class = GroupSerializer
    permission_classes = [permissions.IsAuthenticated]

class CommunityViewSet(viewsets.ModelViewSet):
    """
        API endpoint that allows Communities to be viewed or edited.
    """
    queryset = Community.objects.all()
    serializer_class= CommunitySerializer
    permission_classes = [permissions.IsAuthenticated]
class UserStatsViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset =  UserStats.objects.all()
    serializer_class = UserStatsSerializer
    permission_classes = [permissions.IsAuthenticated]

class PostViewSet(viewsets.ModelViewSet):
    queryset= Post.objects.all()
    serializer_class = PostSerializer
    permission_classes = [permissions.IsAuthenticated]

class CommentViewSet(viewsets.ModelViewSet):
    queryset= Comment.objects.all()
    serializer_class = CommentSerializer
    permission_classes = [permissions.IsAuthenticated]

class MessageViewSet(viewsets.ModelViewSet):
    queryset= Message.objects.all()
    serializer_class = MessageSerializer
    permission_classes = [permissions.IsAuthenticated]

class ConditionViewSet(viewsets.ModelViewSet):
    queryset= Condition.objects.all()
    serializer_class = ConditionSerializer
    permission_classes = [permissions.IsAuthenticated]

class HobbyViewSet(viewsets.ModelViewSet):
    queryset= Hobby.objects.all()
    serializer_class = HobbySerializer
    permission_classes = [permissions.IsAuthenticated]

class FollowViewSet(viewsets.ModelViewSet):
    queryset= Follow.objects.all()
    serializer_class = FollowSerializer
    permission_classes = [permissions.IsAuthenticated]

class LocationViewSet(viewsets.ModelViewSet):
    queryset= Location.objects.all()
    serializer_class = LocationSerializer
    permission_classes = [permissions.IsAuthenticated]

@api_view(['POST'])
def login_view(request):
    if request.method == "POST":
        # Attempt to sign user in
        username = request.data["username"]
        password = request.data["password"]
        user = authenticate(request, username=username, password=password)

        # Check if authentication successful
        if user is not None:
            login(request, user)
            return HttpResponseRedirect("/post/")
        else:
            return JsonResponse({
                "message": "Invalid username and/or password."
            })
    else:
        return HttpResponse("Invalid request to login, need a POST request with username and password fields for logging in")

@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def logout_view(request):
    logout(request)
    return HttpResponse("Successfully logged out!")

@api_view(['POST'])
def register(request):
    if request.method == "POST":
        username = request.data["username"]
        email = request.data["email"]

        # Ensure password matches confirmation
        password = request.data["password"]
        confirmation = request.data["confirmation"]
        if password != confirmation:
            return JsonResponse({
                "message": "Passwords must match."
            })

        # Attempt to create new user
        try:
            user = User.objects.create_user(username = username, email=  email, password = password)
            user.save()
        except IntegrityError:
            return JsonResponse({
                "message": "Username already taken."
            })
        login(request, user)
        return HttpResponse("Successfully registered and logged in!")
    else:
        return HttpResponse("Invalid request to login, need a POST request with username and password fields for logging in")