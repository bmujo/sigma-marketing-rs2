import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/user/profile_details/profile_details_bloc.dart';
import 'package:sigma_marketing/data/models/response/profile/profile_details.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_text_input/custom_text_input.dart';

import '../../../../utils/colors/colors.dart';

class ProfileBrandScreen extends StatefulWidget {
  const ProfileBrandScreen({Key? key}) : super(key: key);

  @override
  _ProfileBrandScreenState createState() => _ProfileBrandScreenState();
}

class _ProfileBrandScreenState extends State<ProfileBrandScreen> {
  late ProfileDetailsBloc _profileDetailsBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _bioTextController = TextEditingController();

  final _instagramTextController = TextEditingController();
  final _tikTokTextController = TextEditingController();
  final _facebookTextController = TextEditingController();
  final _linkedInTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileDetailsBloc = ProfileDetailsBloc();
    _profileDetailsBloc.add(GetProfileEvent());
  }

  @override
  void dispose() {
    _profileDetailsBloc.close();

    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _emailTextController.dispose();
    _bioTextController.dispose();
    _instagramTextController.dispose();
    _tikTokTextController.dispose();
    _facebookTextController.dispose();
    _linkedInTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            color: SMColors.main.withOpacity(0.8),
            child: Form(
                key: _formKey, // Attach the GlobalKey to the Form widget
                child: SingleChildScrollView(
                  child: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
                      bloc: _profileDetailsBloc,
                      builder: (context, state) {
                        if (state is ProfileError) {
                          return const Center(
                            child: Text("Error loading data"),
                          );
                        }

                        if (state is ProfileLoaded) {
                          _firstNameTextController.text =
                              state.profileDetails.firstName;
                          _lastNameTextController.text =
                              state.profileDetails.lastName;
                          _emailTextController.text =
                              state.profileDetails.email;
                          _bioTextController.text = state.profileDetails.bio;
                          _instagramTextController.text =
                              state.profileDetails.instagram;
                          _tikTokTextController.text =
                              state.profileDetails.tikTok;
                          _facebookTextController.text =
                              state.profileDetails.facebook;
                          _linkedInTextController.text =
                              state.profileDetails.linkedIn;

                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Profile Details',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: SMColors.white,
                                  height: 1,
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLeftColumn(state.profileDetails),
                                    const SizedBox(width: 24),
                                    _buildRightColumn(state.profileDetails)
                                  ],
                                )
                              ]);
                        }
                        ;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn(ProfileDetails profileDetails) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: SMColors.main,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 20),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage:
                    NetworkImage(profileDetails.profileImageUrl),
                  ),
                  Positioned(
                    top: 50,
                    left: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.photo),
                          onPressed: () {
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextInput(
              labelText: "FirstName",
              hintText: "Enter your first name",
              controller: _firstNameTextController),
          const SizedBox(height: 16),
          CustomTextInput(
              labelText: "LastName",
              hintText: "Enter your last name",
              controller: _lastNameTextController),
          const SizedBox(height: 16),
          CustomTextInput(
              labelText: "Email",
              hintText: "Enter your email",
              controller: _emailTextController),
          const SizedBox(height: 16),
          CustomTextInput(
              labelText: "Bio",
              hintText: "Enter your bio",
              controller: _bioTextController),
        ],
      ),
    );
  }

  Widget _buildRightColumn(ProfileDetails profileDetails) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextInput(
              labelText: "Instagram",
              hintText: "Enter your instagram",
              controller: _instagramTextController),
          const SizedBox(height: 16),
          CustomTextInput(
              labelText: "TikTok",
              hintText: "Enter your tiktok",
              controller: _tikTokTextController),
          const SizedBox(height: 16),
          CustomTextInput(
              labelText: "Facebook",
              hintText: "Enter your facebook",
              controller: _facebookTextController),
          const SizedBox(height: 16),
          CustomTextInput(
              labelText: "LinkedIn",
              hintText: "Enter your linkedin",
              controller: _linkedInTextController),
          const SizedBox(height: 32),
          CustomButton(text: "Update", onPressed: () {}),
        ],
      ),
    );
  }
}
