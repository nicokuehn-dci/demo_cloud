from django.urls import path, include
from .views import StoryView
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register("stories", StoryView, basename="story")

urlpatterns = [
    # path('stories/', StoryView.as_view()),
    path("", include(router.urls))
]
