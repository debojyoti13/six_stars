// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserDetails {

  String userId = '';
  String username = '';
  String phone = '';
  String email = '';
  String password = '';
  int status = 1;

  // UserDetails({
  //   required this.userId,
  //   required this.username,
  //   required this.phone,
  //   required this.email,
  //   required this.password,
  //   required this.status,
  // });

  get getUserId => this.userId;
  set setUserId(userId) => this.userId = userId;

  get getUsername => this.username;
  set setUsername(username) => this.username = username;

  get getPhone => this.phone;
  set setPhone(phone) => this.phone = phone;

  get getEmail => this.email;
  set setEmail(email) => this.email = email;

  get getPassword => this.password;
  set setPassword(password) => this.password = password;

  get getStatus => this.status;
  set setStatus(status) => this.status = status;


  
}
