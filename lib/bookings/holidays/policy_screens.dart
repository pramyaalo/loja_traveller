import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 35, weight: 800.0, color: Theme.of(context).primaryColor),
        titleSpacing: 0,
        title: const Text("Package Details", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
        //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),

      body: ListView.builder(itemCount:1, itemBuilder: (BuildContext context, index){
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("•", style: TextStyle( color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(width: 10,),
                //SizedBox( width: MediaQuery.of(context).size.width * 0.9, child: Text(highlights[index]['Highlight'], softWrap: true, style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),)),
              ],
            ),
            SizedBox(height: 5,)
          ],
        );
      }),
    );
  }
}
