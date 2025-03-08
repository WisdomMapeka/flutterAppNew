from rest_framework import viewsets
from .models import FarmType, FarmerData, ConfigOption, Profile
from .serializers import FarmTypeSerializer, FarmerDataSerializer, ConfigOptionSerializer, ProfileSerializer

class FarmTypeViewSet(viewsets.ModelViewSet):
    queryset = FarmType.objects.all()
    serializer_class = FarmTypeSerializer

class FarmerDataViewSet(viewsets.ModelViewSet):
    queryset = FarmerData.objects.all()
    serializer_class = FarmerDataSerializer

class ConfigOptionViewSet(viewsets.ModelViewSet):
    queryset = ConfigOption.objects.all()
    serializer_class = ConfigOptionSerializer

class ProfileViewSet(viewsets.ModelViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer

