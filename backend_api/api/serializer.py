from rest_framework import serializers
from core.models import User, Price, Subscription, Category, Article, Comment, LikeDislike, SavedArticle
from rest_framework_simplejwt.tokens import RefreshToken


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'first_name',
            'last_name',
            'email',
            'phone_number',
            'username',
            'password',
            'user_type',
            'profile_picture',
            'is_premium',
        ]


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


class UserLoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)


class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = [
            'id',
            'first_name',
            'last_name',
            'email',
            'phone_number',
            'username',
            'password',
            'user_type',
        ]

    def create(self, validated_data):
        password = validated_data.pop('password')
        user = User(**validated_data)
        user.set_password(password)
        user.save()
        return user
    

class SendPasswordResetEmailSerializer(serializers.Serializer):
    email = serializers.EmailField(max_length=255)
    class Meta:
        fields = ['email']


class UpdatePasswordSerializer(serializers.Serializer):
    password = serializers.CharField(required=True)
    password2 = serializers.CharField(required=True)

    def validate(self, data):
        password = data.get('password')
        password2 = data.get('password2')

        # Check if both passwords match
        if password != password2:
            raise serializers.ValidationError("Passwords do not match")

        return data


class UserLogoutSerializer(serializers.Serializer):
    refresh_token = serializers.CharField(write_only=True)

    def validate(self, attrs):
        refresh_token = attrs.get('refresh_token')

        if refresh_token:
            try:
                RefreshToken(refresh_token).blacklist()
            except Exception as e:
                raise serializers.ValidationError({'error': 'Unable to blacklist token.'})

            return attrs
        else:
            raise serializers.ValidationError({'refresh_token': 'This field is required.'})