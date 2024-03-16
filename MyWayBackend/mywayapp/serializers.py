from rest_framework import serializers, permissions
from .models import *
from django.contrib.auth.models import Group



class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow owners of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the owner of the snippet.
        return obj == request.user



class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ['id','url', 'name']

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [ 'id','url', 'username', 'email', 'groups']

class CommunitySerializer(serializers.HyperlinkedModelSerializer):
    
    class Meta:
        model = Community
        fields=  "__all__"

class UserStatsSerializer(serializers.ModelSerializer):
    condition = serializers.HyperlinkedRelatedField(view_name="condition-details", many = True, read_only=True)
    hobby = serializers.HyperlinkedRelatedField(view_name="hobby-details", many = True, read_only=True)

    posts = serializers.HyperlinkedRelatedField(many=True,  view_name="post-detail", read_only=True)
    comments = serializers.HyperlinkedRelatedField(many=True,  view_name="comment-detail", read_only=True)
    followings = serializers.HyperlinkedRelatedField(many=True,  view_name="comment-detail", read_only=True)
    followers = serializers.HyperlinkedRelatedField(many=True,  view_name="follower-detail", read_only=True)
    locations = serializers.HyperlinkedRelatedField(many=True,  view_name="location-detail", read_only=True)
    messages = serializers.HyperlinkedRelatedField(many=True,  view_name="message-detail", read_only=True)
    class Meta:
        model = UserStats
        fields = "__all__";

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = "__all__";

class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = "__all__";


class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = "__all__";

class FollowSerializer(serializers.ModelSerializer):
    class Meta:
        model = Follow
        fields = "__all__";

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = "__all__";

class ConditionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Condition
        fields = "__all__"

class HobbySerializer(serializers.ModelSerializer):
    class Meta:
        model = Hobby
        fields = "__all__"