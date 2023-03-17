import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCheckScreen extends StatefulWidget {
  const AppCheckScreen({Key? key}) : super(key: key);

  @override
  State<AppCheckScreen> createState() => _AppCheckScreenState();
}

class _AppCheckScreenState extends State<AppCheckScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<String> links = [
    "rainbow://",
    "kryptogo://",
    "ethereum://",
    "wc://",
    "argent://",
    "metamask://",
    "trust://",
    "coinbase-wallet://",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var link in links)
              LanuchItem(
                uri: Uri.parse(link),
              ),
            //refresh btn
            ElevatedButton(
              onPressed: () async {
                setState(() {});
                //show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Refreshed"),
                  ),
                );
              },
              child: const Text("Refresh"),
            ),
          ],
        ),
      ),
    );
  }
}

class LanuchItem extends StatefulWidget {
  const LanuchItem({
    Key? key,
    required this.uri,
  }) : super(key: key);
  final Uri uri;

  @override
  State<LanuchItem> createState() => _LanuchItemState();
}

class _LanuchItemState extends State<LanuchItem> {
  bool can = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  onTap() async {
    if (await canLaunchUrl(widget.uri)) {
      final bool nativeAppLaunchSucceeded = await launchUrl(
        widget.uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  init() async {
    try {
      can = await canLaunchUrl(widget.uri);
      setState(() {});
    } catch (e) {
      debugPrint('=======e : $e=========');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Text("${widget.uri} $can"),
      ),
    );
  }
}
