import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:motoon_api_example/models/login_req.dart';
import 'package:motoon_api_example/ui/screens/register_screen.dart';
import 'package:motoon_api_example/ui/screens/usersScreen/users_screen.dart';

import '../../repos/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool hidePass = true;
  late LoginRequest loginRequest;
  late String tokenItem = '';
  TextEditingController _mailcontroller = TextEditingController();
  TextEditingController _passwrodcontroller = TextEditingController();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // TextEditingController? _controllerUsername, _controllerPassword;
  @override
  void initState() {
    super.initState();
    loginRequest = LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 200,
              child: Stack(children: [
                CustomPaint(
                  size: Size(size.width, 500),
                  painter: RPSCustomPainter(),
                )
              ]),
            )),
        const Positioned(
          top: 250,
          left: 150,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          bottom: 200,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            width: size.width,
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 253, 253, 253),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0, 10),
                    blurRadius: 20,
                  ),
                ]),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _mailcontroller,
                    decoration: InputDecoration(
                        labelText: 'Username', prefixIcon: Icon(Icons.email)),
                    validator: (val) =>
                        !val!.contains('@') ? "Email Id should be valid" : null,
                    onSaved: (val) => loginRequest.email = val!,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    // controller: _controllerUsername,
                  ),
                  TextFormField(
                    controller: _passwrodcontroller,

                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(hidePass
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                        )),
                    validator: (val) =>
                        val!.length < 3 ? 'Password Required' : null,
                    onSaved: (val) => loginRequest.password = val!,
                    obscureText: hidePass,
                    // controller: _controllerPassword,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        final form = formKey.currentState;
                        if (validateAndSave()) {
                          print(loginRequest.toJson());

                          LoginSevice loginService = LoginSevice();
                          loginService.login(loginRequest).then((value) {
                            if (value != null) {
                              print('it good not null');
                              if (value.token.isNotEmpty) {
                                tokenItem = value.token;
                                print(value.token);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UsersScreen(
                                          token: tokenItem,
                                        )));
                                _mailcontroller.clear();
                                _passwrodcontroller.clear();
                              } else {
                                print(value.error);

                                var snackBar =
                                    SnackBar(content: Text(value.error));
                                // Step 3
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          });
                        }
                      }),
                  TextButton(
                    child: Text(
                      'Need an Account?',
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                      _mailcontroller.clear();
                      _passwrodcontroller.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: size.width,
              height: 200,
              child: Stack(children: [
                CustomPaint(
                  size: Size(size.width, 500),
                  painter: RPSCustomPainter2(),
                )
              ]),
            )),
      ]),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.32),
        Offset(size.width * 0.96, size.height * 0.32),
        [Color(0xfff50a0a), Color(0xffffffff)],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(size.width * 0.9637500, 0);
    path0.quadraticBezierTo(size.width * 0.8187500, size.height * 0.1614286,
        size.width * 0.4487500, size.height * 0.2842857);
    path0.quadraticBezierTo(size.width * 0.0828125, size.height * 0.4307143, 0,
        size.height * 0.6428571);
    path0.lineTo(0, 0);
    path0.lineTo(size.width * 0.9637500, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.50),
        Offset(size.width, size.height * 0.50),
        [Color(0xff0a83f5), Color(0xffffffff)],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.quadraticBezierTo(size.width * 0.9775000, size.height * 0.4900000,
        size.width * 0.6075000, size.height * 0.6128571);
    path0.quadraticBezierTo(
        size.width * 0.2415625, size.height * 0.7592857, 0, size.height);
    path0.lineTo(size.width, size.height * 0.9985714);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
