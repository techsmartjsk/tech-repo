import 'package:Technovatives/constants.dart';
import 'package:Technovatives/screens/Homepage/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:Technovatives/screens/login/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Technovatives/screens/Homepage/BarcodeScanner.dart';

void main()=> runApp(
  MaterialApp(
    home: RegisterForm(),
  )
);

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with NavigationStates{
  String name,email, password,uid;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggendinuser;
  void getCurrentUser() async{
    try{
      final User = await _auth.currentUser();
      loggendinuser = User;
      if(User != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => barcodeApp()),
        );
      }
      uid = User.uid;
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;
    return Scaffold(
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            SizedBox(height: 2 * space),
              TextField(
                onChanged: (value){
                  name = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(kPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color: kBlack.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: kBlack.withOpacity(0.5),
                  ),
                ),
                obscureText: false,
              ),
              SizedBox(height: space),
              TextField(
                onChanged: (value){
                  email = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(kPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: kBlack.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: kBlack.withOpacity(0.5),
                  ),
                ),
                obscureText: false,
              ),
              SizedBox(height: space),
              TextField(
                onChanged: (value){
                  password = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(kPaddingM),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: kBlack.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: kBlack.withOpacity(0.5),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: space),
              CustomButton(
                color: kBlue,
                textColor: kWhite,
                text: 'Register',
                onPressed: () async{
                  try{
                    Firestore _firestore = Firestore.instance;
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password:password);
                    _firestore.collection('users').document(newUser.user.uid).setData({
                      "name":name,
                      "email":email
                    });
                    if(newUser != null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>barcodeApp ()),
                      );
                    }
                  }catch(e){
                    print(e);
                  }
                },
              ),
            ],
          ),
        )
    );
  }
}


