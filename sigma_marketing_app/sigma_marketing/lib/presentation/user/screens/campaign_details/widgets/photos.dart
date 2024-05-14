import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';

class Photos extends StatefulWidget {
  const Photos({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomLabel(title: "PHOTOS"),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Column(
            children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: widget.campaignDetails.photos.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.campaignDetails.photos.asMap().entries.map((entry) {
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
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? SMColors.primaryColor
                            : Colors.grey,
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: CustomTextStyle.regularText(12)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}