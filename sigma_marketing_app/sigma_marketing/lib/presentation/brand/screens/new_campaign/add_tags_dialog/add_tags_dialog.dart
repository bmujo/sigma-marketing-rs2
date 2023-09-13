import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/data/models/response/new_campaign/tag_data.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../common/widgets/custom_button/custom_button.dart';

class AddTagsDialog extends StatefulWidget {
  final List<TagData> alreadySelectedTags;
  final List<TagData> tags;

  const AddTagsDialog(
      {Key? key, required this.alreadySelectedTags, required this.tags})
      : super(key: key);

  @override
  _AddTagsDialogState createState() => _AddTagsDialogState();
}

class _AddTagsDialogState extends State<AddTagsDialog> {
  List<TagData> selectedTags = [];

  final _searchTextController = TextEditingController();

  @override
  void initState() {
    widget.alreadySelectedTags.forEach((element) {
      widget.tags.removeWhere((tag) => tag.id == element.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(20),
            color: SMColors.secondMain.withOpacity(0.8),
            child: SingleChildScrollView(
              // Wrap the content in SingleChildScrollView
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Add Tags',
                        style: CustomTextStyle.semiBoldText(20),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: SMColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSearchField(),
                const SizedBox(height: 16),
                _buildTagsList(),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Add all selected tags',
                  onPressed: () {
                    Navigator.of(context).pop(selectedTags);
                  },
                ),
                const SizedBox(height: 16),
                const Divider(color: SMColors.white, height: 1),
                const SizedBox(height: 8),
                _buildAddedTags(),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _searchTextController,
        decoration: const InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildTagsList() {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.tags.length,
        itemBuilder: (context, index) {
          final tag = widget.tags[index];
          return CheckboxListTile(
            selectedTileColor: SMColors.primaryColor,
            activeColor: SMColors.primaryColor,
            title: Text(tag.name),
            value: selectedTags.contains(tag),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedTags.add(tag);
                } else {
                  selectedTags.remove(tag);
                }
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildAddedTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(selectedTags.length, (index) {
        final tag = selectedTags[index];
        return Chip(
          backgroundColor: SMColors.primaryColor,
          label: Text(tag.name),
          onDeleted: () {
            setState(() {
              selectedTags.remove(tag);
            });
          },
        );
      }),
    );
  }
}
