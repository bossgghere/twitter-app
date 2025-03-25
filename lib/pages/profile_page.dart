import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_app/services/database/database_provider.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  ProfilePage({super.key, required this.uid});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final databaseProvider = Provider.of<DatabaseProvider>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("P R O F I L E")),
      body: Center(child: Text(widget.uid)),
    );
  }
}
