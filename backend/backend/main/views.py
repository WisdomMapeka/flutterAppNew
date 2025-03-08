from rest_framework import viewsets
from .models import FarmType, FarmerData, CropType, Profile
from .serializers import FarmTypeSerializer, FarmerDataSerializer, CropTypeOptionSerializer, ProfileSerializer

class FarmTypeViewSet(viewsets.ModelViewSet):
    queryset = FarmType.objects.all()
    serializer_class = FarmTypeSerializer

class FarmerDataViewSet(viewsets.ModelViewSet):
    queryset = FarmerData.objects.all()
    serializer_class = FarmerDataSerializer

class CropTypeOptionViewSet(viewsets.ModelViewSet):
    queryset = CropType.objects.all()
    serializer_class = CropTypeOptionSerializer

class ProfileViewSet(viewsets.ModelViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer

