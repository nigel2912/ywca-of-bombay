import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:ywcaofbombay/screens/admin/user_profiles/search_user.dart';
import '../../../../widgets/blue_bubble_design.dart';
import '../../../../widgets/constants.dart';
import '../../../../widgets/gradient_button.dart';

// ignore: must_be_immutable
class EditUserProfile extends StatefulWidget {
  String uid,
      firstName,
      lastName,
      phoneNumber,
      emailId,
      address,
      userRole,
      gender,
      nearestCenter,
      placeOfWork,
      profession,
      interestInMembership;
  DateTime dateOfBirth;

  EditUserProfile({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailId,
    required this.address,
    required this.dateOfBirth,
    required this.userRole,
    required this.gender,
    required this.nearestCenter,
    required this.placeOfWork,
    required this.profession,
    required this.interestInMembership,
  });
  @override
  _EditUserProfileState createState() => _EditUserProfileState(
        uid,
        firstName,
        lastName,
        phoneNumber,
        emailId,
        address,
        userRole,
        gender,
        nearestCenter,
        placeOfWork,
        profession,
        interestInMembership,
        dateOfBirth,
      );
}

class _EditUserProfileState extends State<EditUserProfile> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String userRole = '';
  String gender = "";
  late DateTime dateOfBirth;
  String profession = '';
  String placeOfWork = '';
  String nearestCenter = "Chembur";
  String interestInMembership = "Yes";
  String uid = '';
  var userInfo;
  String address = "";

  _EditUserProfileState(
    this.uid,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
    this.userRole,
    this.gender,
    this.nearestCenter,
    this.placeOfWork,
    this.profession,
    this.interestInMembership,
    this.dateOfBirth,
  );

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // scaffold key for snack bar

  // MemberChoices _selectedMembershipInterest = MemberChoices.yes;
  // GenderChoices selectedGender = GenderChoices.female;

  // female-0, male-1, decline to state-2
  int _genderRadioValue = 0;
  void _handleGenderRadioValueChange(int? value) {
    setState(() {
      _genderRadioValue = value!;
      if (_genderRadioValue == 0) {
        gender = "Female";
      } else if (_genderRadioValue == 1) {
        gender = "Male";
      } else {
        gender = "Decline to state";
      }
      print("gender selected: $gender");
    });
  }

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  Future _selectDate(context) async {
    initializeDateFormatting();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(Duration(days: 4380)),
      helpText: 'Select Date of Event',
      fieldLabelText: 'Enter date of Event',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF49dee8),
            accentColor: const Color(0xFF49dee8),
            colorScheme: ColorScheme.light(primary: const Color(0xFF49dee8)),
            dialogBackgroundColor: Colors.white, // calendar bg color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: secondaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
        // print(eventDate);
      });
    }
  }

  // Future<bool> _onBackPressed() {
  _onBackPressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to exit without saving changes?'),
          content: Text('Press the SAVE button if you wish to save changes'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> savePressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Your request to change information has been successfully sent!'),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    String gender = widget.gender;
    if (gender == "Male") {
      _genderRadioValue = 1;
    } else if (gender == "Female") {
      _genderRadioValue = 0;
    } else {
      _genderRadioValue = 2;
    }

    super.initState();
  }

  final int height = 1;
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    dateController.text = DateFormat('dd-MM-yyyy').format(dateOfBirth);
    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: Scaffold(
        key: _scaffoldKey,
        // body:WillPopScope(
        //   onWillPop: _onBackPressed,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // circle design and Title
                  Stack(
                    children: <Widget>[
                      MainPageBlueBubbleDesign(),
                      Positioned(
                        child: AppBar(
                          centerTitle: true,
                          title: Text(
                            "YWCA OF BOMBAY",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: Colors.black87,
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              _onBackPressed();
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: _height * 0.095),
                            child: Text(
                              'EDIT PROFILE',
                              style: TextStyle(
                                fontSize: 35,
                                // color: Color(0xff333333),
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RacingSansOne',
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 3.0),
                                    blurRadius: 3.0,
                                    color: Color(0xff333333),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Form
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: _height * 0.02,
                      horizontal: _width * 0.04,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: firstName,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                firstName = value!;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'First name is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: secondaryColor,
                              ),
                              labelText: 'First Name',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            initialValue: lastName,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                lastName = value!;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Last name is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: secondaryColor,
                              ),
                              labelText: 'Last Name',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            readOnly: true,
                            // initialValue: DateFormat('yyyy-MM-dd').format(Provider.of<UserData>(context, listen:false).getdateOfBirth).toString(),
                            // keyboardType: TextInputType.datetime,
                            onChanged: (value) {
                              setState(() {
                                // dateOfBirth = DateTime.parse(value);
                                // dateOfBirth\ = value;
                              });
                            },
                            controller: dateController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: secondaryColor,
                              ),
                              labelText: 'Date of Birth',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await _selectDate(context);
                              dateController.text =
                                  "${dateOfBirth.toLocal()}".split(' ')[0];
                            },
                          ),
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            // initialValue: emailId,
                            initialValue: email,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              setState(() {
                                email = value!;
                              });
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Email is required';
                            //   }
                            //   if (!RegExp(
                            //           "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                            //       .hasMatch(value)) {
                            //     return 'Enter a valid email address';
                            //   }
                            //   // return null coz validator has to return something
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: secondaryColor,
                              ),
                              labelText: 'Email Address',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            initialValue: address,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                address = value!;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: secondaryColor,
                              ),
                              labelText: 'Address',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          Text(
                            'User Role',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              // left: _width * 0.262,
                              // right: _width * 0.262,
                              left: _width * 0.24,
                              right: _width * 0.24,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: formFieldFillColor,
                              // border: Border.all(),
                            ),
                            child: DropdownButton<String>(
                              value: userRole,
                              icon: Icon(Icons.arrow_drop_down_rounded),
                              elevation: 16,
                              underline: Container(),
                              onChanged: (String? value) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  userRole = value!;
                                  print(userRole);
                                });
                              },
                              items: <String>[
                                'Admin',
                                'Staff',
                                'Member',
                                'NonMember',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontSize: 16,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Radio(
                                value: 0,
                                groupValue: _genderRadioValue,
                                onChanged: _handleGenderRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _genderRadioValue = 0;
                                      _handleGenderRadioValueChange(
                                          _genderRadioValue);
                                    });
                                  },
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Radio(
                                value: 1,
                                groupValue: _genderRadioValue,
                                onChanged: _handleGenderRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _genderRadioValue = 1;
                                      _handleGenderRadioValueChange(
                                          _genderRadioValue);
                                    });
                                  },
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Radio(
                                value: 2,
                                groupValue: _genderRadioValue,
                                onChanged: _handleGenderRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _genderRadioValue = 2;
                                      _handleGenderRadioValueChange(
                                          _genderRadioValue);
                                    });
                                  },
                                  child: Text(
                                    'Decline to state',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: profession,
                            keyboardType: TextInputType.text,
                            onSaved: (String? value) {
                              setState(() {
                                profession = value!;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: secondaryColor,
                              ),
                              labelText: 'Profession',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: Text(
                                    '(Leave blank if retired)',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 2.5,
                                    bottom: 2.5,
                                    right: 3,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            initialValue: placeOfWork,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                if (value == '') {
                                  placeOfWork = 'Retired';
                                } else {
                                  placeOfWork = value!;
                                }
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: secondaryColor,
                              ),
                              labelText: 'Place of work/school/college',
                              filled: true,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: Text(
                                    '(Leave blank if retired)',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 2.5,
                                    bottom: 2.5,
                                    right: 3,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Nearest YWCA Center',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              // left: _width * 0.262,
                              // right: _width * 0.262,
                              left: _width * 0.245,
                              right: _width * 0.245,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: formFieldFillColor,
                              // border: Border.all(),
                            ),
                            child: DropdownButton<String>(
                              value: nearestCenter,
                              icon: Icon(Icons.arrow_drop_down_rounded),
                              elevation: 16,
                              underline: Container(),
                              onChanged: (String? value) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  nearestCenter = value!;
                                  print(nearestCenter);
                                });
                              },
                              items: <String>[
                                'Andheri',
                                'Bandra',
                                'Belapur',
                                'Borivali',
                                'Byculla',
                                'Chembur',
                                'Fort',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontSize: 16,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(height: _height * 0.005),
                          GradientButton(
                            buttonText: 'Update Profile',
                            screenHeight: _height,
                            onPressedFunction: () async {
                              // TODO: validate function not working, hence the code after it does not execute
                              if (_formKey.currentState!.validate() != true) {
                                Vibration.vibrate(duration: 100);
                                return;
                              }
                              _formKey.currentState!.save();
                              // _formKey.currentState?.save();

                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(uid)
                                  .update({
                                "address": address,
                                "firstName": firstName,
                                "lastName": lastName,
                                "dateOfBirth": dateOfBirth,
                                "emailId": email,
                                "gender": gender,
                                "profession": profession,
                                "placeOfWork": placeOfWork,
                                "nearestCenter": nearestCenter,
                                "interestInMembership": interestInMembership,
                                "uid": uid,
                                "memberRole": userRole,
                              }).then((value) async {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchUser()),
                                    (route) => false);
                              }).catchError(
                                (error) =>
                                    print("Failed to update user: $error"),
                              );

                              // Navigator.pop(context);
                              // Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: _height * 0.020,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
