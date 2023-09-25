import 'package:cloud_firestore/cloud_firestore.dart';


class FetchUserRoleFromCloudFirestore {
  static Future<List<String>> administratorComplaintAccess() async {
    List<String> administratorAccessData = ["yu2G8TeAVFWGtjdzYixueNI4IPi2"];
    final firestore = await FirebaseFirestore.instance.collection("UserData").where("role", isEqualTo: "admin").get();
    for(int i = 0; i<firestore.docs.length; i++) {  
      final element = firestore.docs[i].data();
      administratorAccessData.add(element['userId'].toString());
    }

    return administratorAccessData;
  }
}

//login administratoracc1@gmail.com
//password administrator
// F71qQkPs0VTW47S4ynJOJQVqA223