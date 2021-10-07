import 'package:app/Screens/Profile/constants.dart';
import 'package:app/Screens/Profile/user_model.dart';
import 'package:app/Screens/Profile/widgets/profile_list_item.dart';
import 'package:app/Screens/Welcome/welcome_screen.dart';
import 'package:app/components/toast_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'contactus.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final userReference = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  //backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color:Color(0xFF81B622),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color:Color(0xFF81B622),
                        size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            'B',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            'B@gmail.com',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
        ],
      ),
    );

    userProfileFrame(
        profileImage, double width, double radius, bool isNetworkImage) {
      return isNetworkImage == true
          ? Container(
        width: width,
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileImage != null
                ? CircleAvatar(
              backgroundImage: NetworkImage(profileImage),
              radius: radius,
            )
                : CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/default_user.png'),
              radius: radius,
            ),
          ],
        ),
      )
          : Container(
        height: 150.0,
        width: 150.0,
        child: CircleAvatar(
          backgroundImage: FileImage(profileImage),
          radius: 40,
        ),
      );
    }

    profileHeader() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('uid', isEqualTo: "${auth.currentUser.uid}")
            .snapshots(),
        builder: (context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Text(
              "Hi! ",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6.fontSize,
                  fontWeight: FontWeight.bold),
            );
          } else {
            UserModelClass userModelClass =
            UserModelClass.fromDocument(dataSnapshot.data.docs[0]);
            return Row(
              children: [
                userProfileFrame(
                    userModelClass.profile, 90.0, 36.0, true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userModelClass.username}",
                      style: TextStyle(
                        color: Colors.white,
                          fontSize:
                          Theme.of(context).textTheme.headline6.fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${userModelClass.username}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          Theme.of(context).textTheme.subtitle1.fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      );
    }

    // var themeSwitcher = ThemeSwitcher(
    //   builder: (context) {
    //     return AnimatedCrossFade(
    //       duration: Duration(milliseconds: 200),
    //       crossFadeState:
    //           ThemeProvider.of(context).brightness == Brightness.dark
    //               ? CrossFadeState.showFirst
    //               : CrossFadeState.showSecond,
    //       firstChild: GestureDetector(
    //         onTap: () =>
    //             ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
    //         child: Icon(
    //           LineAwesomeIcons.sun,
    //           size: ScreenUtil().setSp(kSpacingUnit.w * 3),
    //         ),
    //       ),
    //       secondChild: GestureDetector(
    //         onTap: () =>
    //             ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
    //         child: Icon(
    //           LineAwesomeIcons.moon,
    //           size: ScreenUtil().setSp(kSpacingUnit.w * 3),
    //         ),
    //       ),
    //     );
    //   },
    // );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        Icon(
          LineAwesomeIcons.arrow_left,
          size: ScreenUtil().setSp(kSpacingUnit.w * 3),
        ),
        profileHeader(),
        //profileInfo,
        //themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    void showAlert(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm for Sign Out'),
            content: Text("Are You Sure Want To Sign Out ?"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "NO",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  print("Cancel Sign Out");
                },
              ),
              TextButton(
                child: Text(
                  "YES",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  ToastMessages().generalToastMessage("Sign Out Success", context);
                  print("Sign Out Success");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WelcomeScreen(),
                    ),
                        (route) => false,
                  );
                },
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          );
        },
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: kSpacingUnit.w * 5),
          header,
          Expanded(
            child: ListView(
              children: <Widget>[
                /*ProfileListItem(
                  icon: LineAwesomeIcons.user_shield,
                  text: 'Privacy',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.question_circle,
                  text: 'Help & Support',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.cog,
                  text: 'Settings',
                ),
                ProfileListItem(
                  onTapGesture: () => showAlert(context),
                  icon: LineAwesomeIcons.alternate_sign_out,
                  text: 'Logout',
                  hasNavigation: false,
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120.0),
                  child: ElevatedButton(onPressed:  () => showAlert(context), child: Text("Sign Out")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120.0),
                  child: ElevatedButton(onPressed:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ContactUs(),
                      ),
                    );
                  }, child: Text("Contact Us")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

