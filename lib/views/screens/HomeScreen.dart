import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(onPressed: () {
              Navigator.pushNamed(context, '/current_loc');
            },
            child: Text('اطلاعات آب و هوای محل کنونی'),
            color: Colors.blue,),
            SizedBox(
              height: 20,
            ),
            MaterialButton(onPressed: () {
              Navigator.pushNamed(context, '/city_select');
            },
              child: Text('اطلاعات آب و هوای شهر دلخواه'),
            color: Colors.red,),
          ],
        ),
      ),
    );
  }

}