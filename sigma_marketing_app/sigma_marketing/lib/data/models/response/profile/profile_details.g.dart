// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetails _$ProfileDetailsFromJson(Map<String, dynamic> json) =>
    ProfileDetails(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      instagram: json['instagram'] as String,
      tikTok: json['tikTok'] as String,
      facebook: json['facebook'] as String,
      linkedIn: json['linkedIn'] as String,
      bio: json['bio'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
    );

Map<String, dynamic> _$ProfileDetailsToJson(ProfileDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'instagram': instance.instagram,
      'tikTok': instance.tikTok,
      'facebook': instance.facebook,
      'linkedIn': instance.linkedIn,
      'bio': instance.bio,
      'profileImageUrl': instance.profileImageUrl,
    };
