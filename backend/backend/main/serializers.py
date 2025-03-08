from rest_framework import serializers
from .models import FarmType, FarmerData, CropType, Profile

class FarmTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = FarmType
        fields = '__all__'

class FarmerDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = FarmerData
        fields = '__all__'

class CropTypeOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CropType
        fields = '__all__'

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__'