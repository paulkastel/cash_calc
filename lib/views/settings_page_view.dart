import 'package:flutter/material.dart';

@immutable
class SettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).iconTheme.color,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
        ),
      ),
      body: Text(
        'You are in settings',
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
