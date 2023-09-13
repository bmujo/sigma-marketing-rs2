import 'dart:ui';

import 'package:flutter/material.dart';

class InfluencerProfile extends StatefulWidget {
  @override
  _InfluencerProfileState createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRect(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Scaffold(
              backgroundColor: Colors.white.withOpacity(0.2),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(''), // Replace with influencer's profile image URL
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Influencer Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Influencer Bio: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nonummy tincidunt...',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Earnings: 500 Sigma Tokens',
                      // Replace with actual earnings
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
        )));
  }
}
