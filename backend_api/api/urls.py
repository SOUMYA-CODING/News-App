from django.urls import path, include
from . import views
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

# AUTH
auth_patterns = [
    path('login/', views.user_login, name='auth-login'),
    path('registration/', views.user_registration, name='auth-registration'),
    path('logout/', views.user_logout, name='auth-logout'),
    path('reset-password-link/', views.send_password_reset_email,
         name='auth-reset-password-link'),
    path('update-user-password/<uid>/<token>/',
         views.update_user_password, name='auth-update-user-password'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]

# USER
user_patterns = [
    path('', views.user_list, name='user-list'),
    path('<int:user_id>/', views.user_details, name='user-details'),
    path('create/', views.create_user, name='create-user'),
    path('update/<int:user_id>/', views.update_user, name='update-user'),
    path('delete/<int:user_id>/', views.delete_user, name='delete-user'),
]

# PRICE
price_patterns = [
    path('', views.price_list, name='price-list'),
    path('<int:price_id>/', views.price_details, name='price-details'),
    path('create/', views.create_price, name='create-price'),
    path('update/<int:price_id>/', views.update_price, name='update-price'),
    path('delete/<int:price_id>/', views.delete_price, name='delete-price'),
]

# SUBSCRIPTION
subscription_patterns = [
    path('', views.subscription_list, name='subscription-list'),
    path('<int:subscription_id>/', views.subscription_details,
         name='subscription-details'),
    path('create/', views.create_subscription, name='create-subscription'),
    path('update/<int:subscription_id>/',
         views.update_subscription, name='update-subscription'),
    path('delete/<int:subscription_id>/',
         views.delete_subscription, name='delete-subscription'),
]

# CATEGORY
category_patterns = [
    path('', views.category_list, name='category-list'),
    path('<int:category_id>/', views.category_details, name='category-details'),
    path('create/', views.create_category, name='create-category'),
    path('update/<int:category_id>/',
         views.update_category, name='update-category'),
    path('delete/<int:category_id>/',
         views.delete_category, name='delete-category'),
]

# ARTICLE
article_patterns = [
    path('', views.article_list, name='article-list'),
    path('<int:article_id>/', views.article_details, name='article-details'),
    path('create/', views.create_article, name='create-article'),
    path('update/<int:article_id>/', views.update_article, name='update-article'),
    path('delete/<int:article_id>/', views.delete_article, name='delete-article'),
    path('increment-views/<int:article_id>/',
         views.article_views_increment, name='article-views-increment'),
    path('search/', views.search_article, name='search-article'),
]

# COMMENTS
comment_patterns = [
    path('<int:article_id>/', views.comment_list, name='comment-list'),
    path('create/<int:article_id>/', views.create_comment, name='create-comment'),
    path('update/<int:article_id>/<int:comment_id>/',
         views.update_comment, name='update-comment'),
    path('delete/<int:article_id>/<int:comment_id>/',
         views.delete_comment, name='delete-comment'),
]

# LIKE OR DISLIKE
like_dislike_patterns = [
    path('<int:article_id>/', views.update_like_or_dislike,
         name='update-like-dislike'),
    path('count/<int:article_id>/', views.like_or_dislike_count,
         name='like-dislike-count'),
]

# SAVED ARTICLE
saved_articles_patterns = [
    path('', views.list_saved_articles, name='list-saved-articles'),
    path('<int:article_id>/', views.create_saved_articles,
         name='create-saved-article'),
    path('delete/<int:article_id>/', views.delete_saved_articles,
         name='delete-saved-article'),
]

urlpatterns = [
    path('auth/', include(auth_patterns)),
    path('users/', include(user_patterns)),
    path('prices/', include(price_patterns)),
    path('subscriptions/', include(subscription_patterns)),
    path('category/', include(category_patterns)),
    path('articles/', include(article_patterns)),
    path('comments/', include(comment_patterns)),
    path('like-or-dislike/', include(like_dislike_patterns)),
    path('saved-articles/', include(saved_articles_patterns)),
]
