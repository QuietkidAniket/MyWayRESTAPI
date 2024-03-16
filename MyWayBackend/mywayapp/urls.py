from django.urls import include, path
from rest_framework import routers
from . import views

router = routers.DefaultRouter()
router.register(r'groups', views.GroupViewSet)
router.register(r'users', views.UserViewSet)
router.register(r'userstats', views.UserStatsViewSet)
router.register(r'post', views.PostViewSet)
router.register(r'comment', views.CommentViewSet)
router.register(r'message', views.MessageViewSet)
router.register(r'location', views.LocationViewSet)
router.register(r'follow', views.FollowViewSet)
router.register(r'condition', views.ConditionViewSet)
router.register(r'hobby', views.HobbyViewSet)
router.register(r'community', views.CommunityViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path("", views.api_root, name= "apiroot"),
    path("user/<str:username>/", views.userprofile, name="profile"),
    path("follow/<str:username>/", views.follow, name="follow"),
    path("feed/", views.getfeed, name="getfeed"),
    path("localusers/<str:username>", views.LocalUsers, name="localusers"),
    path("similarconditions/<str:username>", views.UsersWithSimilarCondition, name="similar_conditions" ),
    path("similarhobbies/<str:username>", views.UsersWithSimilarCondition, name="similar_hobbies" ),
    path("invalid/",views.invalid,name="invalid"),
    path("post/<str:pk>/get/", views.getpost),
    path("post/create/", views.putpost),
    path("post/<str:pk>/update/", views.updatepost),
    path("login/", views.login_view, name="login"),
    path("logout/", views.logout_view, name="logout"),
    path("register/", views.register, name="register"),
    path('api-auth/', include('rest_framework.urls' , namespace='rest_framework'))
]

urlpatterns += router.urls