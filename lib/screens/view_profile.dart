import 'package:flutter/material.dart';

import '../widgets/blue_bubble_design.dart';
import '../widgets/constants.dart';
import './edit_profile.dart';
import '../widgets/gradient_button.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            MainPageBlueBubbleDesign(),
            Positioned(
              child: AppBar(
                centerTitle: true,
                title: Text(
                  "YWCA Of Bombay",
                  style: TextStyle(
                    fontFamily: 'LilyScriptOne',
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
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Distance from ywca
                    // or else it will overlap
                    SizedBox(height: 90),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: 'YOUR PROFILE',
                            style: TextStyle(
                              fontSize: 35,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RacingSansOne',
                              letterSpacing: 2.5,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.0, 3.0),
                                  blurRadius: 3.0,
                                  color: Color(0xff333333),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150),
                  //greetings
                  Container(
                    child: Text(
                      'Hello, thank you for submitting your information. You can choose to edit it by clicking below.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  //main_body
                  Container(
                    // margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name = firstName + lastName
                        DetailText(text: 'Name: Shawn Louis'),
                        // DetailText(text: 'Name: $firstName $lastName'),
                        SizedBox(height: 15),
                        // Phone
                        DetailText(text: 'Contact number: +91 1234567890'),
                        SizedBox(height: 15),
                        // Email id
                        DetailText(text: 'Email ID: shawnlouis@gmail.com'),
                        SizedBox(height: 15),
                        // Date of birth
                        DetailText(text: 'Date Of Birth: 19/12/2000'),
                        SizedBox(height: 15),
                        // Gender
                        DetailText(text: 'Gender: Male'),
                        SizedBox(height: 15),
                        // Nearest center
                        DetailText(text: 'Nearest YWCA Centre: Chembur'),
                        SizedBox(height: 15),
                        // Place of work/school/college
                        DetailText(
                            text:
                                'Institute/Organization: Don Bosco Institute Of Technology'),
                        SizedBox(height: 15),
                        // Profession
                        DetailText(text: 'Profession: Student'),
                        SizedBox(height: 15),
                        // Interest in membership
                        DetailText(text: 'Interested in being a member: Maybe'),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      color: Color(0x1A49DEE8),
                    ),
                  ),
                  SizedBox(height: 40),
                  GradientButton(
                    buttonText: 'Edit Profile',
                    screenHeight: _height,
                    route: 'edit_profile',
                    onPressedFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()));
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      'Contact the admin if you wish to make changes to your profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailText extends StatelessWidget {
  final String text;
  DetailText({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xff333333),
        fontFamily: 'Montserrat',
      ),
    );
  }
}