import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CabsListScreen extends StatefulWidget {
  const CabsListScreen({Key? key}) : super(key: key);

  @override
  _CabsListScreenState createState() => _CabsListScreenState();
}

class _CabsListScreenState extends State<CabsListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      appBar: AppBar(
        title: Text("Cabs List", style: TextStyle(fontFamily: "Montserrat"),),
        //title: Image.asset('assets/images/lojologo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/lojologo.png',
            width: 150,
            height: 30,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Color(0xFF00ADEE),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Color(0xFF00ADEE),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  color: Color(0xFF00ADEE),
                  child: Material(
                    elevation: 5,
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF00ADEE)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffF0F5FB)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: new BoxDecoration(
                                      border: Border.all(width: 1, color: Color(0xFF00ADEE)),  //https://stackoverflow.com/a/67395539/16076689
                                      borderRadius: new BorderRadius.circular(10.0),
                                      color: Color(0xFF00ADEE),
                                    ),
                                    child: Text(
                                      "One-way",
                                      style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: new BoxDecoration(
                                      border: Border.all(width: 1, color: Color(0xFF00ADEE)),  //https://stackoverflow.com/a/67395539/16076689
                                      borderRadius: new BorderRadius.circular(10.0),
                                      color: Color(0xFF00ADEE),
                                    ),
                                    child: Text(
                                      "Custom",
                                      style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: new BoxDecoration(
                                      border: Border.all(width: 1, color: Color(0xFF00ADEE)),  //https://stackoverflow.com/a/67395539/16076689
                                      borderRadius: new BorderRadius.circular(10.0),
                                      color: Color(0xFF00ADEE),
                                    ),
                                    child: Text(
                                      "Round trip",
                                      style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                                    ),
                                  ),

                                ],
                              ),
                            ),



                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("From", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, color: Colors.grey),),
                                      SizedBox(height: 5,),
                                      Text("Nagercoil", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Text("NGL", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, color: Colors.grey),),

                                    ],
                                  ),

                                  Image(width: 40, height: 40, image: AssetImage("assets/images/swap2.png")),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("To", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, color: Colors.grey),),
                                      SizedBox(height: 5,),
                                      Text("Tirunelvel", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Text("TVL", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, color: Colors.grey),),

                                    ],
                                  )
                                ],
                              ),
                            ),


                          ],
                        )),
                  ),
                )
              ],
            ),
            
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              color: Color(0xFF00ADEE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                      child: Text("Choose your car", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.normal) )
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(image: AssetImage("assets/images/sedanpng.png"), width: 100, height: 80,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),
                            SizedBox(height: 2.5,),
                            Text("Verna or Similar", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),
                            SizedBox(height: 2.5,),
                            Text("3- baggages & 4-Peoples", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),

                          ],
                        ),

                        Text("₹4,999", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),


                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(image: AssetImage("assets/images/sedanpng.png"), width: 100, height: 80,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),
                            SizedBox(height: 2.5,),
                            Text("Verna or Similar", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),
                            SizedBox(height: 2.5,),
                            Text("3- baggages & 4-Peoples", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),

                          ],
                        ),

                        Text("₹4,999", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),


                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(image: AssetImage("assets/images/sedanpng.png"), width: 100, height: 80,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),
                            SizedBox(height: 2.5,),
                            Text("Verna or Similar", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),
                            SizedBox(height: 2.5,),
                            Text("3- baggages & 4-Peoples", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),

                          ],
                        ),

                        Text("₹4,999", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),


                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(image: AssetImage("assets/images/sedanpng.png"), width: 100, height: 80,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),
                            SizedBox(height: 2.5,),
                            Text("Verna or Similar", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),
                            SizedBox(height: 2.5,),
                            Text("3- baggages & 4-Peoples", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),

                          ],
                        ),

                        Text("₹4,999", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),


                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(image: AssetImage("assets/images/sedanpng.png"), width: 100, height: 80,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),
                            SizedBox(height: 2.5,),
                            Text("Verna or Similar", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),
                            SizedBox(height: 2.5,),
                            Text("3- baggages & 4-Peoples", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),

                          ],
                        ),

                        Text("₹4,999", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),


                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(image: AssetImage("assets/images/sedanpng.png"), width: 100, height: 80,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),
                            SizedBox(height: 2.5,),
                            Text("Verna or Similar", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),
                            SizedBox(height: 2.5,),
                            Text("3- baggages & 4-Peoples", style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.normal) ),

                          ],
                        ),

                        Text("₹4,999", style: TextStyle(fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.bold) ),


                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
            
          ],
        ),
      ),
    ));
  }
}
