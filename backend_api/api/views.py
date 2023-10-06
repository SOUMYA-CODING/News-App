from django.contrib.auth import authenticate, login
from django.db import IntegrityError
from django.db.models import Q
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import IsAuthenticated
from core.models import User, Price, Subscription, Category, Article, Comment, LikeDislike, SavedArticle
from .serializer import (
    UserSerializer, PriceSerializer, SubscriptionSerializer, CategorySerializer,
    ArticleSerializer, CommentSerializer, LikeDislikeSerializer, SavedArticleSerializer, SendPasswordResetEmailSerializer, UpdatePasswordSerializer,
)
from django.utils.encoding import smart_str, force_bytes, DjangoUnicodeDecodeError
from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from . utils import Util

# ----------------------------------------- AUTH -----------------------------------------


# USER LOGIN
@api_view(['POST'])
def user_login(request):
    username = request.data.get('username')
    password = request.data.get('password')

    if not User.objects.filter(username=username).exists():
        return Response({'message': 'User does not exist.'}, status=status.HTTP_404_NOT_FOUND)

    user = authenticate(request, username=username, password=password)

    if user is not None:
        login(request, user)
        refresh = RefreshToken.for_user(user)
        access_token = str(refresh.access_token)

        serializer = UserSerializer(user)
        return Response({'message': 'Login successfully.', 'access_token': access_token, 'data': serializer.data, }, status=status.HTTP_200_OK)
    else:
        return Response({'message': 'Invalid username or password.'}, status=status.HTTP_401_UNAUTHORIZED)


# USER REGISTRATION
@api_view(['POST'])
def user_registration(request):
    first_name = request.data.get('first_name')
    last_name = request.data.get('last_name')
    email = request.data.get('email')
    phone_number = request.data.get('phone_number')
    user_type = request.data.get('user_type')
    profile_picture = request.data.get('profile_picture')

    username = request.data.get('username')
    password = request.data.get('password')

    if User.objects.filter(email=email).exists() or User.objects.filter(username=username).exists():
        return Response({'message': 'User with this email or username already exists.'}, status=status.HTTP_400_BAD_REQUEST)

    try:
        user = User.objects.create_user(first_name=first_name, last_name=last_name, email=email, phone_number=phone_number,
                                        user_type=user_type, profile_picture=profile_picture, username=username, password=password)
        user.save()

        refresh = RefreshToken.for_user(user)
        access_token = str(refresh.access_token)

        serializer = UserSerializer(user)

        return Response({'message': 'Registration successfully.', 'access_token': access_token, 'data': serializer.data, }, status=status.HTTP_201_CREATED)
    except IntegrityError:
        return Response({'message': 'Please fill all the fileds'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


# USER PASSWORD RESET LINK
@api_view(['POST'])
def send_password_reset_email(request):
    serializer = SendPasswordResetEmailSerializer(data=request.data)
    if serializer.is_valid():
        email = serializer.validated_data.get('email')

        if User.objects.filter(email=email).exists():
            user = User.objects.get(email=email)
            uid = urlsafe_base64_encode(force_bytes(user.id))
            token = PasswordResetTokenGenerator().make_token(user)
            link = 'https://news-backend-api.onrender.com/api/user/reset/'+uid+'/'+token

            body = "Click on the link : "+link
            data = {
                "subject": "Reset your password",
                "body": body,
                "to_email": user.email,
            }

            Util.send_email(data)

            return Response({'message': 'Password reset link sent. Please check your email'}, status=status.HTTP_200_OK)
        else:
            return Response({'message': 'Your are not a user'}, status=status.HTTP_404_NOT_FOUND)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# USER PASSWORD RESET
@api_view(['POST'])
def update_user_password(request, uid, token):
    try:
        user_id = urlsafe_base64_decode(uid).decode()
        user = User.objects.get(id=user_id)

        if not PasswordResetTokenGenerator().check_token(user, token):
            return Response({'message': 'Invalid or expired token.'}, status=status.HTTP_401_UNAUTHORIZED)

        serializer = UpdatePasswordSerializer(data=request.data)
        if serializer.is_valid():
            password = serializer.validated_data.get('password')
            user.set_password(password)
            user.save()
            return Response({'message': 'Password updated successfully.'}, status=status.HTTP_200_OK)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    except DjangoUnicodeDecodeError:
        return Response({'message': 'Invalid UID.'}, status=status.HTTP_400_BAD_REQUEST)
    except User.DoesNotExist:
        return Response({'message': 'User not found.'}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'message': 'An error occurred while updating the password.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


# ----------------------------------------- USER -----------------------------------------


def get_user_or_404(user_id):
    try:
        return User.objects.get(pk=user_id)
    except User.DoesNotExist:
        return None


# USERS LIST
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def user_list(request):
    users = User.objects.all()
    serializer = UserSerializer(
        users, many=True, context={'request': request})
    return Response({'message': 'User list retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# USER DETAILS
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def user_details(request, user_id):
    user = get_user_or_404(user_id)
    if user is None:
        return Response({'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = UserSerializer(user, context={'request': request})
    return Response({'message': 'User details retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CREATE USER
@api_view(['POST'])
def create_user(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid:
        serializer.save()
        return Response({'message': 'User created successfully', 'data': serializer.data}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# UPDATE USER
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_user(request, user_id):
    user = get_user_or_404(user_id)
    if user is None:
        return Response({'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = UserSerializer(user, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'User updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# DELETE USER
@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_user(request, user_id):
    user = get_user_or_404(user_id)
    if user is None:
        return Response({'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)

    user.delete()
    return Response({'message': 'User deleted successfully'}, status=status.HTTP_204_NO_CONTENT)

# ----------------------------------------- PRICE -----------------------------------------


def get_price_or_404(price_id):
    try:
        return Price.objects.get(pk=price_id)
    except Price.DoesNotExist:
        return None


# PRICE LIST
@api_view(['GET'])
def price_list(request):
    prices = Price.objects.all()
    serializer = PriceSerializer(prices, many=True)
    return Response({'message': 'Price list retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# PRICE DETAILS
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def price_details(request, price_id):
    price = get_price_or_404(price_id)
    if price is None:
        return Response({'message': 'Price not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = Price(price)
    return Response({'message': 'Price details retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CREATE PRICE
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_price(request):
    serializer = PriceSerializer(data=request.data)
    if serializer.is_valid:
        serializer.save()
        return Response({'message': 'Price created successfully', 'data': serializer.data}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# UPDATE PRICE
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_price(request, price_id):
    price = get_price_or_404(price_id)
    if price is None:
        return Response({'message': 'Price not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = PriceSerializer(price, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Price updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# DELETE PRICE
@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_price(request, price_id):
    price = get_price_or_404(price_id)
    if price is None:
        return Response({'message': 'Price not found'}, status=status.HTTP_404_NOT_FOUND)

    price.delete()
    return Response({'message': 'Price deleted successfully'}, status=status.HTTP_204_NO_CONTENT)


# ----------------------------------------- SUBSCRIPTION -----------------------------------------


def get_subscription_or_404(subscription_id):
    try:
        return Subscription.objects.get(pk=subscription_id)
    except Subscription.DoesNotExist:
        return None


# SUBSCRIPTION LIST
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def subscription_list(request):
    subscriptions = Subscription.objects.all()
    serializer = SubscriptionSerializer(subscriptions, many=True)
    return Response({'message': 'Subscription list retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# SUBSCRIPTION DETAILS
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def subscription_details(request, subscription_id):
    subscription = get_subscription_or_404(subscription_id)
    if subscription is None:
        return Response({'message': 'Subscription not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = Subscription(subscription)
    return Response({'message': 'Subscription details retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CREATE SUBSCRIPTION
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_subscription(request):
    serializer = SubscriptionSerializer(data=request.data)
    if serializer.is_valid:
        serializer.save()
        return Response({'message': 'Subscription created successfully', 'data': serializer.data}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# UPDATE SUBSCRIPTION
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_subscription(request, subscription_id):
    subscription = get_subscription_or_404(subscription_id)
    if subscription is None:
        return Response({'message': 'Subscription not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = SubscriptionSerializer(subscription, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Subscription updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# DELETE SUBSCRIPTION
@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_subscription(request, subscription_id):
    subscription = get_subscription_or_404(subscription_id)
    if subscription is None:
        return Response({'message': 'Subscription not found'}, status=status.HTTP_404_NOT_FOUND)

    subscription.delete()
    return Response({'message': 'Subscription deleted successfully'}, status=status.HTTP_204_NO_CONTENT)


# ----------------------------------------- CATEGORY -----------------------------------------


def get_category_or_404(category_id):
    try:
        return Category.objects.get(pk=category_id)
    except Category.DoesNotExist:
        return None


# CATEGORY LIST
@api_view(['GET'])
def category_list(request):
    categories = Category.objects.all()
    serializer = CategorySerializer(
        categories, many=True, context={'request': request})
    return Response({'message': 'Category list retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CATEGORY DETAILS
@api_view(['GET'])
def category_details(request, category_id):
    category = get_category_or_404(category_id)
    if category is None:
        return Response({'message': 'Category not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = CategorySerializer(category, context={'request': request})
    return Response({'message': 'Category details retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CREATE CATEGORY
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_category(request):
    serializer = CategorySerializer(data=request.data)
    if serializer.is_valid:
        serializer.save()
        return Response({'message': 'Category created successfully', 'data': serializer.data}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# UPDATE CATEGORY
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_category(request, category_id):
    category = get_category_or_404(category_id)
    if category is None:
        return Response({'message': 'Category not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = CategorySerializer(category, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Category updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# DELETE CATEGORY
@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_category(request, category_id):
    category = get_category_or_404(category_id)
    if category is None:
        return Response({'message': 'Category not found'}, status=status.HTTP_404_NOT_FOUND)

    category.delete()
    return Response({'message': 'Category deleted successfully'}, status=status.HTTP_204_NO_CONTENT)


# ----------------------------------------- ARTICLE -----------------------------------------


def get_article_or_404(article_id):
    try:
        return Article.objects.get(pk=article_id)
    except Article.DoesNotExist:
        return None


class ArticlePagination(PageNumberPagination):
    page_size = 5
    page_size_query_param = 'page_size'
    max_page_size = 100


# ARTICLE LIST
@api_view(['GET'])
def article_list(request):
    articles = Article.objects.all()
    paginator = ArticlePagination()
    result_page = paginator.paginate_queryset(articles, request)
    serializer = ArticleSerializer(
        result_page, many=True, context={'request': request})
    return paginator.get_paginated_response({'message': 'Article list retrieved successfully', 'data': serializer.data})


# ARTICLE DETAILS
@api_view(['GET'])
def article_details(request, article_id):
    article = get_article_or_404(article_id)
    if article is None:
        return Response({'message': 'Article not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = ArticleSerializer(article, context={'request': request})
    return Response({'message': 'Article details retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CREATE ARTICLE
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_article(request):
    serializer = ArticleSerializer(data=request.data)
    if serializer.is_valid:
        serializer.save()
        return Response({'message': 'Article created successfully', 'data': serializer.data}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# UPDATE ARTICLE
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_article(request, article_id):
    article = get_article_or_404(article_id)
    if article is None:
        return Response({'message': 'Article not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = ArticleSerializer(article, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Article updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# DELETE ARTICLE
@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_article(request, article_id):
    article = get_article_or_404(article_id)
    if article is None:
        return Response({'message': 'Article not found'}, status=status.HTTP_404_NOT_FOUND)

    article.delete()
    return Response({'message': 'Article deleted successfully'}, status=status.HTTP_204_NO_CONTENT)


# ARTICLE VIEWS INCREMENT
@api_view(['POST'])
def article_views_increment(request, article_id):
    article = get_article_or_404(article_id)
    if article is None:
        return Response({'message': 'Article not found'}, status=status.HTTP_404_NOT_FOUND)

    # VIEW COUNT INCREMENT
    article.views_count += 1
    article.save()

    return Response({'message': 'Article views incremented successfully', 'data': {'views_count': article.views_count}}, status=status.HTTP_200_OK)


# SEARCH ARTICLE
@api_view(['GET'])
def search_article(request):
    query = request.query_params.get('query', '')

    # Filter articles that contain the search query in their title or content
    articles = Article.objects.filter(
        Q(title__icontains=query) | Q(content__icontains=query))

    serializer = ArticleSerializer(
        articles, many=True, context={'request': request})
    return Response({'message': 'Articles matching the search query retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# ----------------------------------------- COMMENT -----------------------------------------


def get_comment_or_404(comment_id, article_id):
    try:
        return Comment.objects.get(pk=comment_id, article=article_id)
    except Comment.DoesNotExist:
        return None


# COMMENT LIST FOR SPECIFIC ARTICLE
@api_view(['GET'])
def comment_list(request, article_id):
    comments = Comment.objects.filter(article=article_id)
    serializer = CommentSerializer(comments, many=True)
    return Response({'message': 'Comment list retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CREATE COMMENT
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_comment(request, article_id):
    serializer = CommentSerializer(data=request.data)
    if serializer.is_valid:
        serializer.save(article=article_id)
        return Response({'message': 'Comment created successfully', 'data': serializer.data}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# UPDATE COMMENT
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_comment(request, article_id, comment_id):
    comment = get_comment_or_404(article_id, comment_id)
    if comment is None:
        return Response({'message': 'Comment not found'}, status=status.HTTP_404_NOT_FOUND)

    serializer = CommentSerializer(comment, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Comment updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# DELETE COMMENT
@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_comment(request, article_id, comment_id):
    comment = get_comment_or_404(article_id, comment_id)
    if comment is None:
        return Response({'message': 'Comment not found'}, status=status.HTTP_404_NOT_FOUND)

    comment.delete()
    return Response({'message': 'Comment deleted successfully'}, status=status.HTTP_204_NO_CONTENT)


# ----------------------------------------- LIKE OR DISLIKE -----------------------------------------


# LIKE OR DISLIKE GET THE TOTAL COUNT OF LIKES AND DISLIKES FROM A SPECIFIC ARTICLE
@api_view(['GET'])
def like_or_dislike_count(request, article_id):
    likes = LikeDislike.objects.filter(
        article=article_id, is_like=True).count()
    dislikes = LikeDislike.objects.filter(
        article=article_id, is_like=False).count()
    return Response({'likes': likes, 'dislikes': dislikes}, status=status.HTTP_200_OK)


# UPDATE LIKE OR DISLIKE OF AN ARTICLE
@api_view(['PUT'])
def update_like_or_dislike(request, article_id):
    user = request.user
    like_dislike, created = LikeDislike.objects.get_or_create(
        article=article_id, user=user)
    serializer = LikeDislikeSerializer(like_dislike, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Like/Dislike updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# ----------------------------------------- SAVED ARTICLES -----------------------------------------


# LIST SAVED ARTICLE LIST BY USER
@api_view(['GET'])
def list_saved_articles(request):
    user = request.user
    saved_articles = SavedArticle.objects.filter(user=user)
    serializer = SavedArticleSerializer(saved_articles, many=True)
    return Response({'message': 'List retrived successfully', 'data': serializer.data}, status=status.HTTP_200_OK)


# CREATE SAVED ARTICLES
@api_view(['POST'])
def create_saved_articles(request, article_id):
    user = request.user
    if SavedArticle.objects.filter(user=user, article=article_id).exists():
        return Response({'message': 'Article is already saved by the user'}, status=status.HTTP_400_BAD_REQUEST)

    saved_article = SavedArticle(user=user, article=article_id)
    saved_article.save()
    return Response({'message': 'Article saved successfully'}, status=status.HTTP_201_CREATED)


# DELETE SAVED ARTICLES
@api_view(['POST'])
def delete_saved_articles(request, article_id):
    user = request.user
    try:
        saved_article = SavedArticle.objects.get(user=user, article=article_id)
    except SavedArticle.DoesNotExist:
        return Response({'message': 'Saved article not found'}, status=status.HTTP_404_NOT_FOUND)

    saved_article.delete()
    return Response({'message': 'Article removed from saved articles'}, status=status.HTTP_204_NO_CONTENT)
