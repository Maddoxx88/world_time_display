import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    //background image
    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.blue[200] : Colors.indigo[700];
    Color iconColor = data['isDayTime'] ? Colors.black : Colors.white;
    String country = data['isDayTime'] ? 
    data['location'].toString().toLowerCase() + '_day.jpg' 
    : data['location'].toString().toLowerCase() + '_night.jpg';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$country'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: iconColor,
                      size: 24.0,
                    ),
                    label: Text(
                        'Edit Location',
                      style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 2.0,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.white,
                        fontSize: 24.0
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          data['location'],
                          style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black,
                              ),
                            ],
                            fontSize: 32.0,
                            letterSpacing: 2.0,
                            color: Colors.white
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data['time'],
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(5.0, 3.0),
                          blurRadius: 5.0,
                          color: Colors.black,
                        ),
                      ],
                      fontSize: 72.0,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
