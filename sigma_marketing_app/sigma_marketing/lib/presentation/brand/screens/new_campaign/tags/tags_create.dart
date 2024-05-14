import 'package:flutter/material.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/new_campaign/tag_data.dart';
import '../../../../../utils/colors/colors.dart';
import '../add_tags_dialog/add_tags_dialog.dart';

class TagsCreate extends StatefulWidget {
  final List<TagData> tags;
  final List<TagData> selectedTags;
  final bool isValid;
  final Function(List<TagData>) onUpdateTags;

  const TagsCreate({
    Key? key,
    required this.tags,
    required this.selectedTags,
    required this.isValid,
    required this.onUpdateTags,
  }) : super(key: key);

  @override
  _TagsCreateState createState() => _TagsCreateState();
}

class _TagsCreateState extends State<TagsCreate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Tags*',
                style: CustomTextStyle.semiBoldText(14),
              ),
            ),
            Visibility(
              visible: !widget.isValid,
              child: Text(
                'Add at least one tag',
                style: CustomTextStyle.regularText(12, SMColors.red),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize: const Size(50, 50),
                foregroundColor: Colors.white,
                backgroundColor: SMColors.greenButton,
              ),
              onPressed: _addTags,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(color: SMColors.white, height: 1),
        const SizedBox(height: 8),
        widget.selectedTags.isEmpty
            ? Text(
                'Add tags',
                style: CustomTextStyle.regularText(12),
              )
            : Wrap(
                spacing: 8,
                children: _buildChips(),
              ),
      ],
    );
  }

  void _addTags() async {
    final tagsToAdd = await showDialog<List<TagData>>(
      context: context,
      builder: (context) => AddTagsDialog(
          tags: widget.tags, alreadySelectedTags: widget.selectedTags),
    );

    if (tagsToAdd != null && tagsToAdd.isNotEmpty) {
      setState(() {
        widget.onUpdateTags([...widget.selectedTags, ...tagsToAdd]);
      });
    }
  }

  List<Widget> _buildChips() {
    return widget.selectedTags.map<Widget>((tag) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Chip(
          backgroundColor: SMColors.primaryColor,
          label: Text(tag.name),
          onDeleted: () {
            setState(() {
              widget.onUpdateTags(
                  widget.selectedTags.where((t) => t != tag).toList());
            });
          },
        ),
      );
    }).toList();
  }
}
