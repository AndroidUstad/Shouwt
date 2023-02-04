import 'package:equatable/equatable.dart';
import '../../../../config/strings.dart';

import 'profile_entity.dart';

class SettingEntity extends Equatable {
  final String userName;
  final String? firstName;
  final String? lastName;
  final String name;
  final String? email;
  final String? website;
  final String? about;
  final String gender;
  final String? displayLanguage;
  final String? country;
  final bool? isVerified;
  final bool socialLogin;

  SettingEntity._({
    required this.userName,
    required this.email,
    required this.website,
    required this.about,
    required this.gender,
    required this.displayLanguage,
    required this.country,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    this.socialLogin = false,
  });

  factory SettingEntity.fromSettingResponse(ProfileEntity user) =>
      SettingEntity._(
        userName: user.userName,
        email: user.email,
        website: user.website != null && user.website!.isNotEmpty
            ? user.website
            : Strings.emptyWebsite,
        about: user.about != null && user.about!.isNotEmpty
            ? user.about
            : Strings.emptyAbout,
        gender: user.gender,
        displayLanguage: user.language,
        country: user.country,
        name: user.fullName,
        firstName: user.firstName,
        lastName: user.lastName,
        isVerified: user.isVerified,
      );

  SettingEntity copyWith({
    bool? didSocialLogin,
    String? updatedGender,
    String? country,
    String? displayLang,
  }) =>
      SettingEntity._(
          userName: userName,
          email: email,
          website: website != null && website!.isNotEmpty
              ? website
              : "You have not yet determined the URL of your site",
          about: about != null && about!.isNotEmpty
              ? about
              : "The field with information about you is still empty",
          gender: updatedGender ?? gender,
          displayLanguage: displayLang ?? this.displayLanguage,
          country: country ?? this.country,
          name: name,
          firstName: firstName,
          lastName: lastName,
          socialLogin: didSocialLogin ?? socialLogin,
          isVerified: isVerified);

  @override
  List<Object?> get props => [
        this.userName,
        this.email,
        this.website,
        this.about,
        this.gender,
        this.displayLanguage,
        this.country,
        this.name,
        this.firstName,
        this.lastName,
        this.isVerified,
        this.socialLogin,
      ];
}
