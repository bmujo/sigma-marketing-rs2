import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../../data/models/response/new_campaign/platform_data.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../common/widgets/custom_label/custom_label.dart';

class PlatformsCreate extends StatefulWidget {
  final List<PlatformData> platformsSource;
  late List<PlatformData> selectedPlatforms;
  final bool isValid;
  final Function(List<PlatformData>) onUpdatePlatforms;

  PlatformsCreate({
    Key? key,
    required this.platformsSource,
    required this.selectedPlatforms,
    required this.isValid,
    required this.onUpdatePlatforms,
  }) : super(key: key);

  @override
  _PlatformsCreateState createState() => _PlatformsCreateState();
}

class _PlatformsCreateState extends State<PlatformsCreate> {
  late List<PlatformData> _selectedPlatforms;

  @override
  void initState() {
    super.initState();
    _selectedPlatforms = widget.selectedPlatforms;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabel(title: 'Select Platforms'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: SMColors.secondMain,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 130,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.platformsSource.length,
            itemBuilder: (context, index) {
              final platform = widget.platformsSource[index];
              return CheckboxListTile(
                key: Key(platform.id.toString()),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                selectedTileColor: SMColors.primaryColor,
                activeColor: SMColors.primaryColor,
                title: Text(platform.name),
                value: _selectedPlatforms
                        .singleWhere((element) => element.id == platform.id,
                            orElse: () => PlatformData(id: 0, name: ''))
                        .id ==
                    platform.id,
                onChanged: (value) {
                  setState(() {
                    // Create a copy of the current selectedPlatforms list
                    List<PlatformData> updatedSelectedPlatforms =
                        List.from(_selectedPlatforms);

                    if (value == true) {
                      updatedSelectedPlatforms.add(platform);
                    } else {
                      updatedSelectedPlatforms
                          .removeWhere((p) => p == platform);
                    }

                    _selectedPlatforms = updatedSelectedPlatforms;
                    setState(() {
                      widget.onUpdatePlatforms(updatedSelectedPlatforms);
                    });
                  });
                },
              );
            },
          ),
        ),
        Visibility(
            visible: !widget.isValid,
            child: Text(
              'Please select at least one platform',
              style: CustomTextStyle.regularText(14, SMColors.red),
            )),
      ],
    );
  }
}
