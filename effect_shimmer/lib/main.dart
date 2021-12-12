import 'package:effect_shimmer/models/charlist.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: transformPage(),
    );
  }
}

class transformPage extends StatefulWidget {
  const transformPage({Key? key}) : super(key: key);

  @override
  _transformPageState createState() => _transformPageState();
}

class _transformPageState extends State<transformPage> with TickerProviderStateMixin{
  // late AnimationController _rippleController;
  // late AnimationController _scaleController;

  // late Animation<double> _rippleAnimation;
  // late Animation<double> _scaleAnimation;

  // @override
  // void initState() {
  //   super.initState();

  //   _rippleController =
  //       AnimationController(vsync: this, duration: Duration(seconds: 1));

  //   _scaleController =
  //       AnimationController(vsync: this, duration: Duration(seconds: 1));

  //   _rippleAnimation =
  //       Tween<double>(begin: 80.0, end: 90.0).animate(_rippleController)
  //         ..addStatusListener((status) {
  //           if (status == AnimationStatus.completed) {
  //             _rippleController.reverse();
  //           } else if (status == AnimationStatus.dismissed) {
  //             _rippleController.forward();
  //           }
  //         });

  //   _scaleAnimation =
  //       Tween<double>(begin: 1.0, end: 30.0).animate(_scaleController);

  //   _rippleController.forward();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: AnimatedBuilder(
  //           animation: _rippleAnimation,
  //           builder: (context, child) => Container(
  //                 height: _rippleAnimation.value,
  //                 width: _rippleAnimation.value,
  //                 child: Container(
  //                   decoration:  BoxDecoration(
  //                       color: Colors.blue.withOpacity(0.4),
  //                        shape: BoxShape.circle),
  //                   child: InkWell(
  //                     onTap: () {
  //                       _scaleController.forward();
  //                     },
  //                     child: AnimatedBuilder(animation: _scaleAnimation, builder:(context,child) =>
  //                     Transform.scale(scale: _scaleAnimation.value,
  //                     child: Container(
  //                       margin: EdgeInsets.all(10),
  //                       decoration:const BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         color:Colors.green,
  //                       ),
  //                     ),
  //                     ))),
  //                   ),
  //                 ),
  //               )),
  //     );
  // }
  
  
  final _cardHeight = 160.0;
  final scrollcontroller = ScrollController();

  

  final _topcardwidth = 200.0;
  final _topcardHeight = 100.0;

  late bool closetop;
  late double topitem = 0;

  void onlisten() {
    print("${scrollcontroller.offset}");
  }

  @override
  void initState() {
    super.initState();
    scrollcontroller.addListener(() {
      setState(() {
        topitem = scrollcontroller.offset / (_cardHeight * 0.7);
        closetop = scrollcontroller.offset > 50;
      });
    });
  }

  @override
  void dispose() {
    scrollcontroller.removeListener(onlisten);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 200.0,
            pinned: false,
            floating: true,
            collapsedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: charlist.length,
                  itemBuilder: (BuildContext context, index) {
                    return SizedBox(
                      width: _topcardwidth,
                      height: _topcardHeight,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        child: Card(
                          color: charlist[index].cardcolor,
                          child:
                              Image(image: NetworkImage(charlist[index].img)),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              double scale = 0;
              if (topitem > 0.5) {
                scale = index + 0.5 - topitem;
              } else if (topitem < 0) {
                scale = 0;
              } else {
                scale = 1;
              }
              physics:
              BouncingScrollPhysics();
              final character = charlist[index];
              return Transform(
                transform: Matrix4.identity()..scale(scale, scale),
                child: Align(
                  heightFactor: 0.7,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: _cardHeight,
                    width: width - 40,
                    child: Card(
                      
                      color: character.cardcolor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(character.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          //SizedBox(width: 100.0,),
                          Image(image: NetworkImage(character.img))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: charlist.length),
          ),
        ],
      ),
    );
  }
}

// fade card animation
// class _transformPageState extends State<transformPage>
//     with TickerProviderStateMixin {
//   List<character> newcharlist = [];

//   final _topcardwidth = 200.0;
//   final _topcardHeight = 100.0;

//   ScrollController controller = new ScrollController();
//   bool closetopcontainer = false;

//   double topcontainer = 0;

//   //final categoryheight = 50.0;
//   final categorywidth = 200.0;

//   late AnimationController controlleranimation;
//   late Animation sizeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controlleranimation =
//         AnimationController(vsync: this, duration: Duration(seconds: 5));
//     sizeAnimation = Tween(begin: 1.0, end: 120.0).animate(controlleranimation);
//     // controller.addListener(() {
//     //   double value = controller.offset / (150 * 0.7);

//     //   setState(() {
//     //     topcontainer = value;
//     //     closetopcontainer = controller.offset > 50;
//     //   });
//     // });

//     controller.addListener(() {
//       double value = controller.offset / (150 * 0.7);
//       setState(() {
//         topcontainer = value;
//         closetopcontainer = controller.offset > 20;
//         //print(topcontainer);
//       });
//     });

//     newcharlist = charlist;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: Icon(
//           Icons.menu,
//           color: Colors.black,
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.black),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.person, color: Colors.black),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: Container(
//         //height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: Colors.white,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: const <Widget>[
//                 Text(
//                   "Loyality Cards",
//                   style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//                 Text(
//                   "Menu",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),

//             AnimatedOpacity(
//               duration: Duration(milliseconds: 500),
//               opacity: closetopcontainer ? 0 : 1,
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 500),
//                 alignment: Alignment.topLeft,
//                 height: closetopcontainer ? 0 : 180.0,
//                 child: Container(
//                   height: 180,
//                   width: MediaQuery.of(context).size.width - 20,
//                   color: Colors.white,
//                   child: Expanded(
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: newcharlist.length,
//                           itemBuilder: (BuildContext context, index) {
//                             return SizedBox(
//                               width: _topcardwidth,
//                               child: Card(
//                                 color: newcharlist[index].cardcolor,
//                                 child: Image(
//                                   image: NetworkImage(newcharlist[index].img),
//                                 ),
//                               ),
//                             );
//                           })),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             Expanded(
//               child: ListView.builder(
//                   controller: controller,
//                   itemCount: newcharlist.length,
//                   //physics: BouncingScrollPhysics(),
//                   itemBuilder: (BuildContext context, index) {
//                     double scale = 1.0;
//                     if (topcontainer > 0.5) {
//                       scale = index + 0.5 - topcontainer;
//                       if (scale < 0) {
//                         scale = 0;
//                       } else if (scale > 1) {
//                         scale = 1;
//                       }
//                     }
//                     return Opacity(
//                       opacity: scale,
//                       child: Transform(
//                         transform: Matrix4.identity()..scale(scale, scale),
//                         alignment: Alignment.topCenter,
//                         child: Align(
//                           heightFactor: 0.7,
//                           child: AnimatedBuilder(
//                             animation: sizeAnimation,
//                             builder: (BuildContext context, child) =>
//                                 Transform.scale(
//                               scale: sizeAnimation.value,
//                               child: InkWell(
//                                 onTap: () {
//                                   controlleranimation.forward();
//                                 },
//                                 child: Container(
//                                     height: 150,
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 20),
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                         color: newcharlist[index].cardcolor,
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color:
//                                                   Colors.black.withAlpha(100),
//                                               blurRadius: 10.0)
//                                         ]),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 8.0, left: 15.0),
//                                           child: Text(
//                                             newcharlist[index].name,
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                         Hero(
//                                           tag: character,
//                                           child: Image(
//                                               image: NetworkImage(
//                                                   newcharlist[index].img)),
//                                         )
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             ),

//             //categoriesscroller(),
//           ],
//         ),
//       ),
//     );
//   }
// }
