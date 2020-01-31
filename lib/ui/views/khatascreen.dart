import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/shared/bottomnav.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/core/services/database.dart';
import 'package:provider/provider.dart';
import  'package:tassist/ui/widgets/khataScreen/khataform.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';
import 'package:tassist/core/models/khata.dart';
import 'package:tassist/ui/widgets/khataScreen/khatalist.dart';




class KhataScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

   final user = Provider.of<FirebaseUser>(context);

    void _showProductionPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: spacer.all.xs,
          child: KhataForm(),
        );
      }
      );
    }


    return StreamProvider<List<Khata>>.value (
          value: DatabaseService(uid: user.uid).khataData,
          child: Scaffold(
        appBar: headerNav(context),
        bottomNavigationBar: bottomNav(),
        body: Column(
          children: <Widget>[
            SectionHeader('Your Secret Khata'),
                      
             
            KhataList(),
            Container(
              padding: spacer.x.xxs,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: TassistPrimaryBackground,
                      onPressed: () => _showProductionPanel(),
                  ),
                ),
            ),
             
          ],

        )
          
        
        ),
          );
  }
}