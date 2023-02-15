import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
Path path = Path();
path.moveTo(100, 100);
path.lineTo(0, size.height);
path.lineTo(size.width, size.height);
path.lineTo(size.width, 0 );
return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  return true;
  }
  
}