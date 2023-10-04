from PIL import Image
from io import BytesIO
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.text import slugify

# User Types
USER_TYPES = (
    ('regular', 'Regular'),
    ('admin', 'Admin'),
    ('author', 'Author'),
)

SUBSCRIPTION_STATUS = (
    ('active', 'Active'),
    ('expired', 'Expired'),
)


class User(AbstractUser):
    phone_number = models.CharField(max_length=10, null=True)
    user_type = models.CharField(max_length=10, choices=USER_TYPES, null=False)

    profile_picture = models.ImageField(
        upload_to='profile_pictures/', blank=True, null=True)

    is_premium = models.BooleanField(default=False)

    def __str__(self):
        return self.username


class Price(models.Model):
    title = models.CharField(max_length=255)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    interval = models.IntegerField()

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    is_active = models.BooleanField(default=True)

    def __str__(self):
        return self.title


class Subscription(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    status = models.CharField(
        max_length=10, choices=SUBSCRIPTION_STATUS, null=False)
    subscription_plan = models.ForeignKey(Price, on_delete=models.CASCADE)
    
    created_at = models.DateTimeField(auto_now_add=True)
    expired_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.user.username


class Category(models.Model):
    name = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(unique=True)
    image = models.ImageField(
        upload_to='category_images/', blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    is_active = models.BooleanField(default=True)

    class Meta:
        verbose_name_plural = "Categories"

    def save(self, *args, **kwargs):
        if self.image:
            image = Image.open(self.image)
            webp_io = BytesIO()
            image.save(webp_io, format='webp', quality=80)
            webp_file = InMemoryUploadedFile(
                webp_io,
                None,
                f"{self.image.name.split('.')[0]}.webp",
                'image/webp',
                webp_io.tell,
                None,
            )
            self.image = webp_file
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class Article(models.Model):
    title = models.CharField(max_length=200)
    content = models.TextField()
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    categories = models.ForeignKey(Category, on_delete=models.CASCADE)
    publication_date = models.DateTimeField(auto_now_add=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    image = models.ImageField(
        upload_to='article_images/', blank=True, null=True)
    url = models.URLField(max_length=300, blank=True)

    is_active = models.BooleanField(default=True)
    is_featured = models.BooleanField(default=False)
    is_trending = models.BooleanField(default=False)
    is_breaking = models.BooleanField(default=False)

    views_count = models.PositiveIntegerField(default=0)

    class Meta:
        ordering = ['-publication_date']

    def __str__(self):
        return self.title

    def save(self, *args, **kwargs):
        if self.image:
            image = Image.open(self.image)
            webp_io = BytesIO()
            image.save(webp_io, format='webp', quality=80)
            webp_file = InMemoryUploadedFile(
                webp_io,
                None,
                f"{self.image.name.split('.')[0]}.webp",
                'image/webp',
                webp_io.tell,
                None,
            )
            self.image = webp_file

        self.url = f"/articles/{slugify(self.title)}"
        super().save(*args, **kwargs)


class Comment(models.Model):
    article = models.ForeignKey(Article, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    is_hidden = models.BooleanField(default=False)

    def __str__(self):
        return f"Comment by {self.user.username} on {self.article.title}"


class LikeDislike(models.Model):
    article = models.ForeignKey(
        Article, on_delete=models.CASCADE, related_name='likes_dislikes')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    is_like = models.BooleanField(default=False)

    class Meta:
        unique_together = ('article', 'user')

    def __str__(self):
        return f"{self.user.username} {'liked' if self.is_like else 'disliked'} {self.article.title}"


class SavedArticle(models.Model):
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='saved_articles')
    article = models.ForeignKey(Article, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user.username} saved {self.article.title}"
