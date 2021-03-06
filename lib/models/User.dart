import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier{
  String uid = '';
  String get getuid => uid ;
  String firstName = '';
  String get getfirstName => firstName ;
  String lastName = '';
  String get getlastName => lastName ;
  DateTime dateOfBirth = DateTime.now().subtract(Duration(days: 4380));
  DateTime get getdateOfBirth => dateOfBirth;
  String emailId = '';
  String get getemailId => emailId;
  String phoneNumber = '';
  String get getphoneNumber => phoneNumber ;
  String gender = 'Female';
  String get getgender => gender ;
  String profession = '';
  String get getprofession => profession ;
  String placeOfWork = '';
  String get getplaceOfWork => placeOfWork ;
  String nearestCenter = 'Chembur';
  String get getnearestCenter => nearestCenter ;
  String interestInMembership = 'Yes';
  String get getinterestInMembership => interestInMembership ;
  String memberRole = '';
  String get getmemberRole => memberRole;
  String address = '';
  String get getaddress => address;

  //
  // updateName(fName){
  // firstName = fName;
  // notifyListeners();
  // }

  updateAfterAuth(uuid,fName, lName, dob, email, phone, genderchoice, prof, pow, center, interest, role, add){
    uid =uuid;
    firstName = fName;
    lastName = lName;
    dateOfBirth = dob;
    emailId = email;
    phoneNumber = phone;
    gender = genderchoice;
    profession = prof;
    placeOfWork = pow;
    nearestCenter = center;
    interestInMembership = interest;
    memberRole = role;
    address = add;
    notifyListeners();
  }

}
