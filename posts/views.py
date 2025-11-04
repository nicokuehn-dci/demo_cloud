from rest_framework.viewsets import ModelViewSet
from .models import Story
from .serializers import StorySerializer


class StoryView(ModelViewSet):
    queryset = Story.objects.all()

    serializer_class = StorySerializer
