
class ResetPasswordRequest{

  String phone;
  String otp;
  String type;
  String password;
  String password_confirmation;

  ResetPasswordRequest(this.phone,this.otp,this.type,this.password,this.password_confirmation);

}