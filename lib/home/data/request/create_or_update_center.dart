
import 'dart:io';

class CreateOrUpdateCenter{
  String centerName;
  String centerId;
  String address;
  String phone;
  File? image;
  String serviceIds;
  String employeeId;
  String openTime;
  String closedTime;
  String status;

CreateOrUpdateCenter(
      this.centerName,
      this.centerId,
      this.address,
      this.phone,
      this.image,
      this.serviceIds,
      this.employeeId,
      this.openTime,
      this.closedTime,
      this.status,
  );
}