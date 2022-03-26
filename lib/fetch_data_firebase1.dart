import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData1 extends StatefulWidget {
  const FetchData1({Key? key}) : super(key: key);

  @override
  State<FetchData1> createState() => _FetchData1State();
}

class _FetchData1State extends State<FetchData1> {
  Stream<QuerySnapshot> carsItem =
      FirebaseFirestore.instance.collection('Cars').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FetchData1'),
      ),
      body: StreamBuilder(
        stream: carsItem,
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasError){
            print('Something wrong');
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index){
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Card(
                child: GridTile(
                  child: Image.network(documentSnapshot['image'],fit: BoxFit.fill,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
