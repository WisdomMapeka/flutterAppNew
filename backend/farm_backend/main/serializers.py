from rest_framework import serializers
from .models import FarmerData, ConfigOption

from rest_framework import serializers
from django.contrib.auth.models import User
from .auth_models import Profile

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'password', 'email']
        extra_kwargs = {
            'password': {'write_only': True},  # Ensure password is not returned in responses
        }

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
        )
        return user

class ProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Profile
        fields = ['user', 'role']

    def create(self, validated_data):
        user_data = validated_data.pop('user')
        user = UserSerializer.create(UserSerializer(), validated_data=user_data)
        profile = Profile.objects.create(user=user, **validated_data)
        return profile

class FarmerDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = FarmerData
        fields = ['farmer_name', 'nation_id', 'farm_type', 'crop', 'location']

class ConfigOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = ConfigOption
        fields = ['key', 'value']