from rest_framework import viewsets
from .models import FarmType, FarmerData, CropType, Profile
from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.views import APIView
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



class CombinedCropFarmTypeSaveView(APIView):
    def post(self, request):
        farmer_data_serializer = FarmTypeSerializer(data=request.data.get('farm_data'))
        crop_type_serializer = CropTypeOptionSerializer(data=request.data.get('crop_type'))
       
        if farmer_data_serializer.is_valid() and crop_type_serializer.is_valid():
            farmer_data = farmer_data_serializer.save()
            crop_type = crop_type_serializer.save()

            print(farmer_data_serializer.errors)
            print(crop_type_serializer.errors)

            return Response({
                'farmer_data': farmer_data_serializer.data,
                'crop_type': crop_type_serializer.data
            }, status=status.HTTP_201_CREATED)

        return Response({"errors":"Failed To Save"}, status=status.HTTP_400_BAD_REQUEST)