
import 'dart:io';

class CreateOrUpdateEmployee{
  String name;
  String email;
  String phone;
  String password;
  String password_confirmation;
  String experiance;
  String ssd_num;
  String start_time;
  String end_time;
  String status;
  String employeeId;
  File? image;

  CreateOrUpdateEmployee(
      this.name,
      this.email,
      this.phone,
      this.password,
      this.password_confirmation,
      this.experiance,
      this.ssd_num,
      this.start_time,
      this.end_time,
      this.status,
      this.employeeId,
      this.image
  );
}