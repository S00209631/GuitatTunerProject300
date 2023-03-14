import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project/LogIn/auth.dart';
import 'package:project/LogIn/utils.dart';
import '../MainPages/ResetPassword.dart';
import 'SignUp.dart';
import '../config.dart';

void main() async {
  runApp(
     MaterialApp(
      home: LoginWidget(),
      title: "Animated-Login-Page-UI",
    ),
  );
}

class LoginWidget extends StatefulWidget {
   LoginWidget({super.key});
  final User? user = Auth().currentUser;
  Future<void> signOut() async{
    await Auth().signOut();
  }
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
  }

class _LoginWidgetState extends State<LoginWidget> with TickerProviderStateMixin {
  @override
  late AnimationController controller1;
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
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
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
                Column(
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
                                    'Sign in',
                                    style: TextStyle(fontSize: 20),
                                  )),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextField(
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
                                    child: const Text('Sign In'),
                                    onPressed: (SignIn)
                                  )
                              ),

                              Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Dont Have An Account?'),
                                  TextButton(
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  SignUp()),
                                      );
                                      },
                                  ),
                                ],
                              ),
                              TextButton(
                                child: const Text(

                                  'Forgot Password',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  ResetPassword()),
                                  );
                                },
                              ),
                            ],
                          ),

                        ),
                      )
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future SignIn()async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(), password: _passwordController.text.trim(),
      );
    }on FirebaseAuthException catch (e){
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
        center: Offset(0, 0),
        radius: radius,
      ));
    canvas.drawCircle(Offset.zero, radius, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


