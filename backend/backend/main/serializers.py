from rest_framework import serializers
from .models import FarmType, FarmerData, ConfigOption, Profile

class FarmTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = FarmType
        fields = '__all__'

class FarmerDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = FarmerData
        fields = '__all__'

class ConfigOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = ConfigOption
        fields = '__all__'

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__'