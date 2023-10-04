from rest_framework import serializers
from core.models import User, Price, Subscription, Category, Article, Comment, LikeDislike, SavedArticle


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"


class PriceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Price
        fields = "__all__"


class SubscriptionSerializer(serializers.ModelSerializer):
    plan = serializers.PrimaryKeyRelatedField(queryset=Price.objects.all())

    class Meta:
        model = Subscription
        fields = "__all__"


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = "__all__"

class ArticleSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    categories = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all())

    class Meta:
        model = Article
        fields = "__all__"


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = "__all__"


class LikeDislikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = LikeDislike
        fields = "__all__"


class SavedArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = SavedArticle
        fields = "__all__"

