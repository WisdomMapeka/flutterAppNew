from django.db import models
from django.contrib.auth.models import User

class FarmType(models.Model):
    farm_type = models.CharField(max_length=80, blank=True, null=True)

    def __str__(self):
        if self.farm_type:
            return self.farm_type
        else:
            return "None"

class FarmerData(models.Model):
    farmer_name = models.CharField(max_length=80, blank=True, null=True)
    nation_id = models.CharField(max_length=20, blank=True, null=True)
    farm_type = models.ForeignKey(FarmType, on_delete=models.CASCADE, null=True, blank=True)
    crop = models.CharField(max_length=50, blank=True, null=True)
    location = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        if self.farmer_name:
            return self.farmer_name
        else:
            return "None"

class ConfigOption(models.Model):
    key = models.CharField(max_length=50, blank=True, null=True)
    value = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        if self.key:
            return f"{self.key}: {self.value}"
        else:
            return "None"
    

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    role = models.CharField(max_length=20, choices=[('clerk', 'Clerk'), ('admin', 'Admin')])

    def __str__(self):
        if self.user.username:
            return f"{self.user.username} - {self.role}"
        else:
            return "None"