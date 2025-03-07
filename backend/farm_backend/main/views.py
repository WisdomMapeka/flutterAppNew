from django.shortcuts import get_list_or_404, get_object_or_404
from drf_yasg.utils import swagger_auto_schema
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import FarmerData, ConfigOption
from django.contrib.auth.models import User
from .serializers import UserSerializer, FarmerDataSerializer, ConfigOptionSerializer

@swagger_auto_schema(
    method='post',
    request_body=UserSerializer,
    responses={200: 'User role returned', 404: 'User not found'},
    operation_description="Authenticate a user and return their role."
)
@api_view(['POST'])
def login(request):
    username = request.data.get('username')
    password = request.data.get('password')
    user = get_object_or_404(User, username=username, password=password)
    return Response({'role': user.role})

@swagger_auto_schema(
    method='post',
    request_body=FarmerDataSerializer,
    responses={200: 'Data submitted successfully', 400: 'Invalid data'},
    operation_description="Submit farmer data to the backend."
)
@api_view(['POST'])
def submit_data(request):
    serializer = FarmerDataSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({'message': 'Data submitted successfully'})
    return Response(serializer.errors, status=400)

@swagger_auto_schema(
    method='get',
    responses={200: ConfigOptionSerializer(many=True)},
    operation_description="Get configuration options for the app."
)
@api_view(['GET'])
def get_config(request):
    config_options = ConfigOption.objects.all()
    serializer = ConfigOptionSerializer(config_options, many=True)
    return Response(serializer.data)

@swagger_auto_schema(
    method='post',
    request_body=FarmerDataSerializer(many=True),
    responses={200: 'Data synced successfully', 400: 'Invalid data'},
    operation_description="Sync locally stored data with the backend."
)
@api_view(['POST'])
def sync_data(request):
    for item in request.data:
        serializer = FarmerDataSerializer(data=item)
        if serializer.is_valid():
            serializer.save()
    return Response({'message': 'Data synced successfully'})