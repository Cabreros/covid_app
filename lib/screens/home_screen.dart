import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [_appBar(), _header(), _body()],
      ),
    );
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      backgroundColor: Color(0xffe27d60),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: null,
        )
      ],
      //title: Text('Floating app bar'),
      floating: true,
    );
  }

  SliverToBoxAdapter _header() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(15.0),
        height: 100.0,
        decoration: BoxDecoration(
          color: Color(0xffe27d60),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'COVID-19',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontFamily: 'Futura',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _body() {
    return SliverToBoxAdapter(
      child: Container(
        height: 1000.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}

// appBar: AppBar(
//   backgroundColor: Color(0xff85dcba),
//   actions: [
//     IconButton(
//         icon: Icon(
//           Icons.notifications,
//         ),
//         onPressed: null)
//   ],
// ),
