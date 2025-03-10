class FarmerData {
  final int id;
  final String farmerName;
  final String nationId;
  final String crop;
  final String location;
  final int farmType;
  final int cropType;

  FarmerData({
    required this.id,
    required this.farmerName,
    required this.nationId,
    required this.crop,
    required this.location,
    required this.farmType,
    required this.cropType,
  });

  // Factory constructor to create a FarmerData instance from JSON
  factory FarmerData.fromJson(Map<String, dynamic> json) {
    return FarmerData(
      id: json['id'],
      farmerName: json['farmer_name'],
      nationId: json['nation_id'],
      crop: json['crop'],
      location: json['location'],
      farmType: json['farm_type'],
      cropType: json['crop_type'],
    );
  }

  // Method to convert FarmerData instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmer_name': farmerName,
      'nation_id': nationId,
      'crop': crop,
      'location': location,
      'farm_type': farmType,
      'crop_type': cropType,
    };
  }
}


class FarmType {
  final int id;
  final String farmType;

  FarmType({required this.id, required this.farmType});

  // Factory constructor to create a FarmType instance from JSON
  factory FarmType.fromJson(Map<String, dynamic> json) {
    return FarmType(
      id: json['id'],
      farmType: json['farm_type'],
    );
  }

  // Method to convert FarmType instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farm_type': farmType,
    };
  }
}

class CropTypeOption {
  final int id;
  final String cropType;

  CropTypeOption({required this.id, required this.cropType});

  // Factory constructor to create a CropTypeOption instance from JSON
  factory CropTypeOption.fromJson(Map<String, dynamic> json) {
    return CropTypeOption(
      id: json['id'],
      cropType: json['crop_type'],
    );
  }

  // Method to convert CropTypeOption instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'crop_type': cropType,
    };
  }
}
