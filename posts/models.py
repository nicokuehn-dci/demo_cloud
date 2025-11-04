from django.db import models


class Story(models.Model):
    title = models.CharField(max_length=255, help_text="A catchy title for our story")
    content = models.TextField(help_text="Body of the story")
