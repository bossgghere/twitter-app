import 'package:flutter/material.dart';
import 'package:twitter_app/models/user.dart';
import 'package:twitter_app/services/auth/auth_services.dart';
import 'package:twitter_app/services/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  //db instances
  final _auth = AuthServices();
  final _db = DatabaseService();

  //get user profile frome the given uid

  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);
}
