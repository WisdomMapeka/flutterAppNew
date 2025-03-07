from django.db import models

class FarmerData(models.Model):
    farmer_name = models.CharField(max_length=80)
    nation_id = models.CharField(max_length=20)
    farm_type = models.CharField(max_length=50)
    crop = models.CharField(max_length=50)
    location = models.CharField(max_length=100)

    def __str__(self):
        return self.farmer_name

class ConfigOption(models.Model):
    key = models.CharField(max_length=50)
    value = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.key}: {self.value}"