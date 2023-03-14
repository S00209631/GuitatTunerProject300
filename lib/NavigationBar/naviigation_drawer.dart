import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/LogIn/login.dart';
import 'package:project/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/MainPages/TutorialsAndVideos.dart';
import 'package:project/MainPages/Recordings.dart';
import '../MainPages/GuitarTuner.dart';
import '../MainPages/SettingsPage.dart';
import '../MainPages/HomePage.dart';
import '../LogIn/SignUp.dart';
import '../config.dart';
import 'drawer_item.dart';

Future  main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());

}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // set your desired background color here
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerWidget(),
                const SizedBox(height: 40,),
                const Divider(thickness: 1, height: 10, color: Colors.white,),
                const SizedBox(height: 40,),
                DrawerItem(
                  name: 'Home',
                  icon: Icons.home,
                  onPressed: ()=> onItemPressed(context, index: 0),
                ),
                const SizedBox(height: 30,),
                DrawerItem(
                    name: 'Guitar Tuner',
                    icon: Icons.music_note_rounded,
                    onPressed: ()=> onItemPressed(context, index: 5)
                ),
                const SizedBox(height: 30,),
                DrawerItem(
                    name: 'Tutorials And Videos',
                    icon: Icons.tips_and_updates_outlined,
                    onPressed: ()=> onItemPressed(context, index: 1)
                ),
                const SizedBox(height: 30,),
                DrawerItem(
                    name: 'Recordings',
                    icon: Icons.record_voice_over,
                    onPressed: ()=> onItemPressed(context, index: 3)
                ),
                const SizedBox(height: 30,),
                const Divider(thickness: 1, height: 10, color: Colors.white,),
                const SizedBox(height: 30,),
                DrawerItem(
                    name: 'Settings',
                    icon: Icons.settings,
                    onPressed: ()=> onItemPressed(context, index: 4)
                ),
                const SizedBox(height: 30,),
                DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  onPressed: ()=> FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




void onItemPressed(BuildContext context, {required int index}){
    Navigator.pop(context);

    switch(index){
      case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage()));
      break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  SliderScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWidget()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecorderPage(title: 'Recorded Audios')));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsOnePage()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  GuitarTuner()));
        break;

    }
  }

  Widget headerWidget() {
    return Row(

      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage('https://iili.io/HXk4GLJ.png'),
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Daniel Stanislawski', style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(height: 10,),
            Text('S00209631@Atu.ie', style: TextStyle(fontSize: 14, color: Colors.white))
          ],
        )
      ],
    );
  }




