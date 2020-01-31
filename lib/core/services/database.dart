import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/production.dart';
import 'package:tassist/core/models/khata.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // create metric collection on signup
  final CollectionReference metricCollection =
      Firestore.instance.collection('metrics');

  Future createMetricsRecord() async {
    return await metricCollection.document(uid).setData({
      'total_sales': 0,
    });
  }

    Stream<QuerySnapshot> get sales => metricCollection.snapshots();

  final CollectionReference productionCollection = 
    Firestore.instance.collection('production');

  Future createProductionRecord(String date, String product, String production) async {
    return await productionCollection.document(this.uid).setData({
      'Date': date,
      'Product': product,
      'Production': production,
    });
  }


// defining a list of production data items 
  List<Production> _productionListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
          return Production(
            date: doc.data['Date'] ?? '',
            product: doc.data['Product'] ?? '',
            production: doc.data['Production'] ?? 0,
          );
        }).toList();
      }
    
// Creating a stream of production data items so that we can listen on them
    Stream<List<Production>> get productionData {
      return productionCollection.snapshots()
      .map(_productionListfromSnapshot);
    }

//Connectiong to Collection Products
final CollectionReference productCollection = 
    Firestore.instance.collection('products');


// //Connectiong to Collection Products
final CollectionReference khataCollection = 
    Firestore.instance.collection('khata');


// CTS

Future createKhataRecord(DateTime date, String partyname, String amount, String trantype) async {
    return await khataCollection.document('PTDQMfuftCgJJiA6UwZOExfawV23').collection('transations').document().setData({
      'date': date,
      'trantype': trantype,
      'partyname': partyname,
      'amount': amount,
    });
  }


// defining a list of production data items 
  List<Khata> _khatarecordfromSnapshots (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
          return Khata(
            date: doc.data['date'].toDate() ?? '',
            partyname: doc.data['partyname'] ?? '',
            amount: doc.data['amount'] ?? '',
            trantype: doc.data['l'] ?? '',
          );
        }).toList();
      }
    
// Creating a stream of production data items so that we can listen on them
    Stream<List<Khata>> get khataData {
      return khataCollection.document('PTDQMfuftCgJJiA6UwZOExfawV23')
      .collection('transations').snapshots()
      .map(_khatarecordfromSnapshots);
    }






    }