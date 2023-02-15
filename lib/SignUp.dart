import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/HomePage.dart';
import 'dart:async';
import 'dart:ui';
import 'package:project/utils.dart';

void main() async {
  runApp(
    MaterialApp(
      home: SignUp(),
      title: "Animated-Login-Page-UI",
    ),
  );
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState2 createState() => _SignUpState2();
}

class _SignUpState2 extends State<SignUp> with TickerProviderStateMixin {
  late AnimationController controller1;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });
    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });
    controller2.forward();
  }
  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40, // Set this height
          backgroundColor: Colors.transparent,
        ),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 18, 32, 47),
      body: SingleChildScrollView(
        child: SingleChildScrollView (
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height * (animation2.value + .58),
                  left: size.width * .21,
                  child: CustomPaint(
                    painter: MyPainter(50),
                  ),
                ),
                Positioned(
                  top: size.height * .98,
                  left: size.width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: size.height * .5,
                  left: size.width * (animation2.value + .8),
                  child: CustomPaint(
                    painter: MyPainter(30),
                  ),
                ),
                Positioned(
                  top: size.height * animation3.value,
                  left: size.width * (animation1.value + .1),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: size.height * .1,
                  left: size.width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),

                Form(
                  key: formKey,
                     child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * .1),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              imageUrl: 'https://i.ibb.co/hFTFj3w/ef4cc64952df617208dd1c9801ddee99-1-1-50-removebg-preview.png',
                            ),
                          ),
                        ),
                           Expanded(
                              flex: 7,
                              child: SingleChildScrollView(
                                child: GestureDetector(
                                  child: Column (
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Sign Up',
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFormField(
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Email',
                                          ),
                                          validator: (email)=>
                                          email !=null && !EmailValidator.validate(email)
                                              ?'Enter A Valid Email Address'
                                              :null,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: TextFormField(
                                          autovalidateMode:AutovalidateMode.onUserInteraction,
                                              validator:(value) => value != null && value.length <6
                                              ?'Password Must Be Min 6 Characters'
                                              :null,
                                          obscureText: true,
                                          controller: _passwordController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 50,
                                          padding: const EdgeInsets.all(5),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              SignUpUser();
                                            },
                                            child: const Text('Sign Up'),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                      ],
                  ),
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future SignUpUser()async{
final isValid = formKey.currentState!.validate();
if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), password: _passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
      );
    }
    on FirebaseAuthException catch (e){
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
class MyPainter extends CustomPainter {
  final double radius;
  MyPainter(this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
          colors: <Color>[Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: const Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



