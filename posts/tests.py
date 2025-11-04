from django.test import TestCase
from .models import Story


class StoryModelTest(TestCase):
	def test_create_story(self):
		s = Story.objects.create(title="Test", content="Body")
		self.assertEqual(Story.objects.count(), 1)
