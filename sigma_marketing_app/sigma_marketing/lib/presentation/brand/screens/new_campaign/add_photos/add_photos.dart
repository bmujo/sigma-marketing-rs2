import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/colors/colors.dart';
import 'package:dotted_border/dotted_border.dart';

class AddPhotos extends StatefulWidget {
  final bool isValid;
  final void Function(List<String> photos) onPhotosUpdated;

  const AddPhotos({
    Key? key,
    required this.isValid,
    required this.onPhotosUpdated,
  }) : super(key: key);

  @override
  _AddPhotosState createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  final List<String> photos = [];
  final List<XFile> _list = [];

  bool _dragging = false;

  Offset? offset;

  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) async {
        bool shouldContinue = true;
        setState(() {
          for (var element in detail.files) {
            if (shouldContinue) {
              if (isOver5Photos()) {
                showOver5PhotosErrorDialog();
                shouldContinue = false;
              } else {
                _list.add(element);
              }
            }
          }
        });

        for (final file in _list) {
          final imageBytes = await file.readAsBytes();
          final base64Image = base64Encode(imageBytes);
          setState(() {
            photos.add(base64Image);
            widget.onPhotosUpdated(photos);
          });
        }
      },
      onDragUpdated: (details) {
        setState(() {
          offset = details.localPosition;
        });
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
          offset = detail.localPosition;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
          offset = null;
        });
      },
      child: DottedBorder(
        color: _dragging ? Colors.blue.withOpacity(0.4) : SMColors.thirdMain,
        radius: const Radius.circular(8),
        strokeWidth: 2,
        child: Container(
          color: SMColors.secondMain,
          height: 350,
          child: Stack(
            children: [
              if (_list.isEmpty)
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.file_upload_outlined, size: 24),
                  const Center(child: Text("Drag and drop here")),
                  const Center(child: Text("or")),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: SMColors.secondMain,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          if (isOver5Photos()) {
                            showOver5PhotosErrorDialog();
                            return;
                          }
                          setState(() {
                            _list.add(pickedFile);
                          });

                          for (final file in _list) {
                            final imageBytes = await file.readAsBytes();
                            final base64Image = base64Encode(imageBytes);
                            setState(() {
                              photos.add(base64Image);
                              widget.onPhotosUpdated(photos);
                            });
                          }
                        }
                      },
                      child: const Text("Browse files"),
                    ),
                  ),
                ])
              else
                Column(
                  children: [
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: _list.map((file) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Image.file(File(file.path)),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      foregroundColor: Colors.white,
                                      backgroundColor: SMColors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Delete Image"),
                                            content: Text(
                                                "Are you sure you want to delete this image?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    setState(() {
                                                      photos.removeAt(
                                                          _currentIndex);
                                                      widget.onPhotosUpdated(
                                                          photos);
                                                    });
                                                    _list.remove(file);
                                                    if (_list.isEmpty) {
                                                      _currentIndex = 0;
                                                    } else if (_currentIndex >=
                                                        _list.length) {
                                                      _currentIndex =
                                                          _list.length - 1;
                                                    }
                                                  });
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text("Delete"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(Icons.delete, size: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _list.asMap().entries.map((entry) {
                        int index = entry.key;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                              _controller.animateToPage(index);
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? SMColors.primaryColor
                                  : Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              if (offset != null)
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '$offset',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              Visibility(
                  child: Text('Please select at least one photo',
                      style: TextStyle(color: SMColors.red)),
                  visible: !widget.isValid),
            ],
          ),
        ),
      ),
    );
  }

  bool isOver5Photos() {
    return _list.length > 4;
  }

  void showOver5PhotosErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("You can only upload up to 5 photos"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
