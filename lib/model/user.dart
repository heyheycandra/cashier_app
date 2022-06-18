class User {
  String? nama;
  String? username;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? deviceName;

  String? token;

  int? id;
  String? name;
  String? emailVerifiedAt;
  String? role;
  String? salt;
  String? paper;
  String? currentTeamId;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  User({
    this.nama,
    this.username,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.deviceName,
    this.id,
    this.name,
    this.emailVerifiedAt,
    this.role,
    this.salt,
    this.paper,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
    this.token,
  });

  User.map(Map<String, dynamic> json) {
    nama = json['nama'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    deviceName = json['device_name'];
    id = json['id'];
    name = json['name'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    salt = json['salt'];
    paper = json['paper'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['nama'] = nama;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['device_name'] = deviceName;
    data['id'] = id;
    data['name'] = name;
    data['email_verified_at'] = emailVerifiedAt;
    data['role'] = role;
    data['salt'] = salt;
    data['paper'] = paper;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_photo_url'] = profilePhotoUrl;
    data['token'] = token;
    return data;
  }

  Map<String, String> toRegister() {
    final Map<String, String> data = {};
    data['nama'] = nama ?? "";
    data['username'] = username ?? "";
    data['email'] = email ?? "";
    data['password'] = password ?? "";
    data['password_confirmation'] = passwordConfirmation ?? "";
    return data;
  }

  Map<String, String> toLogin() {
    final Map<String, String> data = {};
    data['email'] = email ?? "";
    data['password'] = password ?? "";
    data['device_name'] = deviceName ?? "DN_MOBILE";
    return data;
  }

  Map<String, String> toUpdateProfile() {
    final Map<String, String> data = {};
    data['user_id'] = (id ?? "").toString();
    data['nama'] = name ?? "";
    data['email'] = email ?? "";
    return data;
  }

  Map<String, dynamic> toChangePass() {
    final Map<String, String> data = {};
    data['user_id'] = (id ?? "").toString();
    data['password'] = password ?? "";
    data['password_confirmation'] = passwordConfirmation ?? "";
    return data;
  }
}
