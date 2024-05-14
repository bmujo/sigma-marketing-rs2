// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'influencer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Influencer _$InfluencerFromJson(Map<String, dynamic> json) => Influencer(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      status: BaseStatus.fromJson(json['status']),
      currentEarningSigma: json['currentEarningSigma'] as int,
      currentEarningCash: (json['currentEarningCash'] as num).toDouble(),
      achievements: (json['achievements'] as List<dynamic>)
          .map(AchievementPoint.fromJson)
          .toList(),
    );

Map<String, dynamic> _$InfluencerToJson(Influencer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'status': instance.status,
      'currentEarningSigma': instance.currentEarningSigma,
      'currentEarningCash': instance.currentEarningCash,
      'achievements': instance.achievements,
    };
