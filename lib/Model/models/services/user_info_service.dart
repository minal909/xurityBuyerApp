import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xuriti/models/core/user_details.dart';

class UserInfoService {
  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('userInfo');
  UserDetails userDetails = UserDetails();

  addData(UserDetails? userInfo) async {
    await userInfoCollection.doc(userInfo!.user!.sId).set(userInfo.toJson());
    return true;
  }

  Future<UserDetails> getInfo(String? userId) async {
    DocumentSnapshot ds = await userInfoCollection.doc(userId).get();
    if (ds.data() != null) {
      return UserDetails.fromJson(ds.data() as Map<String, dynamic>);
    }
    return UserDetails();
  }
}
