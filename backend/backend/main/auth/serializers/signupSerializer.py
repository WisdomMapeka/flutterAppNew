from django.contrib.auth.models import User
from rest_framework import serializers
from ...models import Profile

class UserRegistrationSerializer(serializers.ModelSerializer):
    role = serializers.ChoiceField(choices=[('clerk', 'Clerk'), ('admin', 'Admin')])

    class Meta:
        model = User
        fields = ['username', 'password', 'email', 'role']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        role = validated_data.pop('role')
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        
        # Create the Profile instance
        Profile.objects.create(user=user, role=role)
        
        return user