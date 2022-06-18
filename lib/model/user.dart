class User {
  String? refreshToken;
  int? id;
  String? username;
  String? password;
  String? email;
  List<String>? roles;
  String? accessToken;
  String? tokenType;

  User({this.refreshToken, this.password, this.id, this.username, this.email, this.roles, this.accessToken, this.tokenType});

  User.map(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    id = json['id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    roles = (json['roles'] is List) ? (json['roles'] as List).cast<String>() : null;
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['refreshToken'] = refreshToken;
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['roles'] = roles;
    data['accessToken'] = accessToken;
    data['tokenType'] = tokenType;
    return data;
  }

  Map<String, dynamic> toLogin() {
    final Map<String, dynamic> data = {};
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  Map<String, dynamic> toRegister() {
    final Map<String, dynamic> data = {};
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['roles'] = roles;
    return data;
  }
}
