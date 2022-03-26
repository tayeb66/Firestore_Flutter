import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchDataPage extends StatefulWidget {
  const FetchDataPage({Key? key}) : super(key: key);

  @override
  State<FetchDataPage> createState() => _FetchDataPageState();
}

class _FetchDataPageState extends State<FetchDataPage> {
  Stream<QuerySnapshot> countryStream =
      FirebaseFirestore.instance.collection('Countries').snapshots();

  @override
  Widget build(BuildContext context) {
    /// One way to fetch data from Firestore
   // return StreamBuilder(
   //   stream: countryStream,
   //   builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
   //     if(snapshot.hasError){
   //       print('Something wrong');
   //     }else if(snapshot.connectionState == ConnectionState.waiting){
   //       return Center(
   //         child: CircularProgressIndicator(),
   //       );
   //     }
   //
   //     var listDocs = [];
   //     snapshot.data!.docs.map((DocumentSnapshot document){
   //       Map map = document.data() as Map<String,dynamic>;
   //       map['id'] = document.id;
   //       listDocs.add(map);
   //     }).toList();
   //
   //     return Scaffold(
   //       appBar: AppBar(
   //         title: Text('FetchDataPage'),
   //       ),
   //       body: ListView.builder(
   //         itemCount: snapshot.data!.docs.length,
   //         itemBuilder: (context, index){
   //           return Card(
   //             child: ListTile(
   //               title: Text(listDocs[index]['name']),
   //             ),
   //           );
   //         },
   //       ),
   //     );
   //   },
   // );

    /// Other way to fetch data from Firestore
    return Scaffold(
      appBar: AppBar(
        title: Text('FetchDataPage'),
      ),
      body: StreamBuilder(
        stream: countryStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            print('Something wrong');
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  title: Text(documentSnapshot['name']),
                ),
              );
          }
          );
        },
      ),
    );
  }
}
