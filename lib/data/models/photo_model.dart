import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class PhotoModel {
  @HiveField(0)
  final int id;
  
  @HiveField(1)
  final int width;
  
  @HiveField(2)
  final int height;
  
  @HiveField(3)
  final String url;
  
  @HiveField(4)
  final String photographer;
  
  @HiveField(5)
  @JsonKey(name: 'photographer_url')
  final String photographerUrl;
  
  @HiveField(6)
  @JsonKey(name: 'photographer_id')
  final int photographerId;
  
  @HiveField(7)
  @JsonKey(name: 'avg_color')
  final String avgColor;
  
  @HiveField(8)
  final PhotoSrcModel src;
  
  @HiveField(9)
  final bool liked;
  
  @HiveField(10)
  final String alt;

  const PhotoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
    required this.alt,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 1)
class PhotoSrcModel {
  @HiveField(0)
  final String original;
  
  @HiveField(1)
  final String large2x;
  
  @HiveField(2)
  final String large;
  
  @HiveField(3)
  final String medium;
  
  @HiveField(4)
  final String small;
  
  @HiveField(5)
  final String portrait;
  
  @HiveField(6)
  final String landscape;
  
  @HiveField(7)
  final String tiny;

  const PhotoSrcModel({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory PhotoSrcModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoSrcModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoSrcModelToJson(this);
}

@JsonSerializable()
class PhotosResponseModel {
  final int page;
  
  @JsonKey(name: 'per_page')
  final int perPage;
  
  final List<PhotoModel> photos;
  
  @JsonKey(name: 'total_results')
  final int totalResults;
  
  @JsonKey(name: 'next_page')
  final String? nextPage;

  const PhotosResponseModel({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    this.nextPage,
  });

  factory PhotosResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PhotosResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosResponseModelToJson(this);
}