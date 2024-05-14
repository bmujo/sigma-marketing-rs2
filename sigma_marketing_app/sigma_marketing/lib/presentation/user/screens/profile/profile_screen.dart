import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/presentation/user/screens/profile/payments/payments_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/models/response/profile/profile_details.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../blocs/user/profile_details/profile_details_bloc.dart';
import 'edit_profile/edit_profile_screen.dart';
import 'settings/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDetailsBloc(),
      child: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            BlocProvider.of<ProfileDetailsBloc>(context).add(const GetProfileEvent());
          }
          if (state is ProfileError) {
            return _buildProfileError(state.message);
          }
          if (state is ProfileLoading) {
            return _buildProfileLoading();
          }
          if (state is ProfileLoaded) {
            return _buildProfileLoaded(state.profileDetails);
          }
          return _buildProfileLoading();
        },
      ),
    );
  }

  AppBar _profileAppBar() {
    return AppBar(
        backgroundColor: SMColors.main,
        centerTitle: true,
        title: const Text('Profile',
            style: TextStyle(color: SMColors.white)));
  }

  Widget _buildProfileError(String errorMessage) {
    return Scaffold(
      backgroundColor: SMColors.main,
      appBar: _profileAppBar(),
      body: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildProfileLoading() {
    return Scaffold(
      backgroundColor: SMColors.main,
      appBar: _profileAppBar(),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProfileLoaded(ProfileDetails profileDetails) {
    final fullName = '${profileDetails.firstName} ${profileDetails.lastName}';
    return Scaffold(
      backgroundColor: SMColors.main,
      appBar: _profileAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildProfileHeader(context, fullName, profileDetails.profileImageUrl, profileDetails),
            const SizedBox(height: 50),
            _buildSocialMediaIcon("Instagram", profileDetails.instagram),
            _buildSocialMediaIcon("Facebook", profileDetails.facebook),
            _buildSocialMediaIcon("LinkedIn", profileDetails.linkedIn),
            _buildNavigationElements(),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaIcon(String label, String url) {
    final socialMediaName = '@${url.split('.com/')[1]}';
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: SMColors.white,
              ),
            ),
            Text(
              socialMediaName,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: SMColors.white,
              ),
            ),
            const Icon(Icons.facebook, color: SMColors.white),
          ],
        ),
      ),
    );
  }

  Stack _buildProfileHeader(BuildContext context, String fullName,
      String profileUrl, ProfileDetails profileDetails) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken),
              image: AssetImage('assets/default_banner.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 180,
          left: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: const BoxDecoration(
              color: SMColors.main,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding:
                const EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(profileDetails: profileDetails)),
                        ).then((value) => {
                              context.read<ProfileDetailsBloc>().add(const GetProfileEvent())
                            });
                      },
                      color: SMColors.primaryColor,
                      textColor: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 120,
          left: 30,
          width: 100,
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(profileUrl),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationElements() {
    return Container(
      padding: const EdgeInsets.only(left: 0, top: 20, right: 0),
      child: Column(
        children: [
          const Divider(
            color: SMColors.lightGrey,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          const Divider(
            color: SMColors.lightGrey,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.paypal),
            title: const Text('Payments'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentsScreen()),
              );
            },
          ),
          const Divider(
            color: SMColors.lightGrey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
