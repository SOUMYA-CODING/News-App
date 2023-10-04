from django.contrib import admin
from .models import User, Price, Subscription, Category, Article, Comment, LikeDislike, SavedArticle


@admin.register(User)
class CustomUser(admin.ModelAdmin):
    list_display = ('username', 'email', 'user_type', 'is_premium')
    list_filter = ('user_type', 'is_premium')
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        ('Personal Info', {'fields': ('first_name',
         'last_name', 'email', 'phone_number')}),
        ('Permissions', {'fields': ('is_active', 'is_staff',
         'is_superuser', 'groups', 'user_permissions')}),
        ('Important Dates', {'fields': ('last_login', 'date_joined')}),
        ('Custom Fields', {
         'fields': ('user_type', 'is_premium', 'profile_picture')}),
    )


@admin.register(Price)
class Price(admin.ModelAdmin):
    list_display = ('title', 'amount', 'interval', 'is_active')


@admin.register(Subscription)
class Subscription(admin.ModelAdmin):
    list_display = ('user', 'status', 'subscription_plan',
                    'created_at', 'expired_at')


@admin.register(Category)
class Category(admin.ModelAdmin):
    list_display = ('name', 'slug', 'created_at', 'updated_at', 'is_active')


@admin.register(Article)
class Article(admin.ModelAdmin):
    list_display = ('title', 'user', 'publication_date', 'is_active',
                    'is_featured', 'is_trending', 'is_breaking', 'views_count')
    list_filter = ('categories', 'user', 'publication_date',
                   'is_active', 'is_featured', 'is_trending', 'is_breaking')
    search_fields = ('title', 'content')


@admin.register(Comment)
class Comment(admin.ModelAdmin):
    list_display = ('article', 'user', 'message', 'is_hidden', 'created_at')


@admin.register(LikeDislike)
class LikeDislike(admin.ModelAdmin):
    list_display = ('article', 'user', 'is_like')


@admin.register(SavedArticle)
class SavedArticle(admin.ModelAdmin):
    list_display = ('user', 'article')
