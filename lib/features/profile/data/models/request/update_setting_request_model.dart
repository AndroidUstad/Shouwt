// ignore_for_file: public_member_api_docs, sort_constructors_first

class UpdateSettingsRequestModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? aboutYou;
  final String? website;
  final String? gender;
  final String? username;
  final String? countryId;

  UpdateSettingsRequestModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.aboutYou,
      this.website,
      this.gender,
      this.username,
      this.countryId});

  Map<String, dynamic> toJson() => {
        // "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        // "is_verified": isVerified == null ? null : isVerified,
        "website": website == null ? null : website,
        "about": aboutYou == null ? null : aboutYou,
        "gender": gender == null ? null : gender,
        "country_id": countryId == null ? null : countryId,
      };

  factory UpdateSettingsRequestModel.fromMap(Map<String, dynamic> map) {
    return UpdateSettingsRequestModel(
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      aboutYou: map['about'] != null ? map['about'] as String : null,
      website: map['website'] != null ? map['website'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      countryId: map['country_id'] != null ? map['country_id'] as String : null,
    );
  }
}
