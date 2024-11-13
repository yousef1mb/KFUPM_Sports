import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';

class EventsPageView extends StatelessWidget {
  const EventsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Adjust height as needed
        child: Column(
          children: [
            AppBar(
              title: Container(
                padding: const EdgeInsets.only(
                    top: 20), // Adjust the top padding as needed
                child: const Text(
                  'Find Match',
                  style: TextStyle(
                    fontSize: 32, // Larger font size
                    fontWeight: FontWeight.bold, // Bold font
                    color: Colors.black, // Black color
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent, // Transparent background
              elevation: 0, // No shadow
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 16.0), // Adjust the value as needed
              height: 10, // Height of the line
              color: AppColors.navigationBar, // Color of the line
              width: double.infinity, // Full width
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            MatchCard(
              sport: 'Football',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
              imageUrl:
                  "https://s3-alpha-sig.figma.com/img/acd1/a7b7/df9840fe9d894de3084e41b03c39691f?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lE1eQBv1o3sHFJ3aaAqvMjeZl4ukvhPkp1eKsrwZqSgwWFn5ZUPAxQtTpGANRiNalXDPTUsljEb6thXIhipuPzpr9SCGxbOavS0RxRPt2NRNKsycBWz7EnpGwmZYE6uFz4XpHvfpkyo8C2H0Dm8Kw4kbLDzHfUlC4JIrAH-h2qAFr2PtK6gNHkEK8xDaOOIQfD3GGUCrsUPXCpR2Bnfqig6SCs6TrLSWZSU-7QBdh7qRZva~ihjxywXvXSyNkeA-sVYznuwHTIO0Mk0gRhjYW8oEz~QatM4e6PqvkwiOSZuUP6q0V9pPyf1Hxa2pxJqnB7fMYPYTKkkS~CsoEcRxZw__",
              blendColor: Color(0xFF0D6761),
            ),
            SizedBox(height: 16), // Spacing between cards
            MatchCard(
              sport: 'Volleyball',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/7b4a/1c9c/c840d634ae0922d5fc8d630f34fe3c90?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ul~4CZrLbQXww8s4Z1~SYSCWSFqy2olCvyqtlnqYFM2l46po5HhhMTGHLgpchHdMTnrDUODuaYZ7vdcJzOMn0bA-wivTTv5qlOq7wmLlv3aSfh1Hi-WDWqhlF9T7EFQY1iBitiM1djwUuGbtOtAJ13bgIcBV5-H0gO5yXqWMbzdM~BSOU~JqDlDPUUztNVfraFNk5Z0~dw-liVrO1SgvGQ14iJOEv3CvxqpaXjF~3RYaukeJzIbkSvlUMVXxtxCdTjYznqNglAnEFIEJrHSdvj2TnVLglPde-4M2N3POPtbo78o6WdQsjqfFyI0D~~xIydPBJJgl8NqfYCMNSjB0Vw__',
              blendColor: Color(0xFF12385D),
            ),SizedBox(height: 16), // Spacing between cards
            MatchCard(
              sport: 'Volleyball',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/7b4a/1c9c/c840d634ae0922d5fc8d630f34fe3c90?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ul~4CZrLbQXww8s4Z1~SYSCWSFqy2olCvyqtlnqYFM2l46po5HhhMTGHLgpchHdMTnrDUODuaYZ7vdcJzOMn0bA-wivTTv5qlOq7wmLlv3aSfh1Hi-WDWqhlF9T7EFQY1iBitiM1djwUuGbtOtAJ13bgIcBV5-H0gO5yXqWMbzdM~BSOU~JqDlDPUUztNVfraFNk5Z0~dw-liVrO1SgvGQ14iJOEv3CvxqpaXjF~3RYaukeJzIbkSvlUMVXxtxCdTjYznqNglAnEFIEJrHSdvj2TnVLglPde-4M2N3POPtbo78o6WdQsjqfFyI0D~~xIydPBJJgl8NqfYCMNSjB0Vw__',
              blendColor: Color(0xFF12385D),
            ),SizedBox(height: 16), // Spacing between cards
             MatchCard(
              sport: 'Football',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
              imageUrl:
                  "https://s3-alpha-sig.figma.com/img/acd1/a7b7/df9840fe9d894de3084e41b03c39691f?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lE1eQBv1o3sHFJ3aaAqvMjeZl4ukvhPkp1eKsrwZqSgwWFn5ZUPAxQtTpGANRiNalXDPTUsljEb6thXIhipuPzpr9SCGxbOavS0RxRPt2NRNKsycBWz7EnpGwmZYE6uFz4XpHvfpkyo8C2H0Dm8Kw4kbLDzHfUlC4JIrAH-h2qAFr2PtK6gNHkEK8xDaOOIQfD3GGUCrsUPXCpR2Bnfqig6SCs6TrLSWZSU-7QBdh7qRZva~ihjxywXvXSyNkeA-sVYznuwHTIO0Mk0gRhjYW8oEz~QatM4e6PqvkwiOSZuUP6q0V9pPyf1Hxa2pxJqnB7fMYPYTKkkS~CsoEcRxZw__",
              blendColor: Color(0xFF0D6761),
            ),SizedBox(height: 16), // Spacing between cards
            MatchCard(
              sport: 'Volleyball',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/7b4a/1c9c/c840d634ae0922d5fc8d630f34fe3c90?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ul~4CZrLbQXww8s4Z1~SYSCWSFqy2olCvyqtlnqYFM2l46po5HhhMTGHLgpchHdMTnrDUODuaYZ7vdcJzOMn0bA-wivTTv5qlOq7wmLlv3aSfh1Hi-WDWqhlF9T7EFQY1iBitiM1djwUuGbtOtAJ13bgIcBV5-H0gO5yXqWMbzdM~BSOU~JqDlDPUUztNVfraFNk5Z0~dw-liVrO1SgvGQ14iJOEv3CvxqpaXjF~3RYaukeJzIbkSvlUMVXxtxCdTjYznqNglAnEFIEJrHSdvj2TnVLglPde-4M2N3POPtbo78o6WdQsjqfFyI0D~~xIydPBJJgl8NqfYCMNSjB0Vw__',
              blendColor: Color(0xFF12385D),
            ),SizedBox(height: 16), // Spacing between cards
            MatchCard(
              sport: 'Volleyball',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/7b4a/1c9c/c840d634ae0922d5fc8d630f34fe3c90?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ul~4CZrLbQXww8s4Z1~SYSCWSFqy2olCvyqtlnqYFM2l46po5HhhMTGHLgpchHdMTnrDUODuaYZ7vdcJzOMn0bA-wivTTv5qlOq7wmLlv3aSfh1Hi-WDWqhlF9T7EFQY1iBitiM1djwUuGbtOtAJ13bgIcBV5-H0gO5yXqWMbzdM~BSOU~JqDlDPUUztNVfraFNk5Z0~dw-liVrO1SgvGQ14iJOEv3CvxqpaXjF~3RYaukeJzIbkSvlUMVXxtxCdTjYznqNglAnEFIEJrHSdvj2TnVLglPde-4M2N3POPtbo78o6WdQsjqfFyI0D~~xIydPBJJgl8NqfYCMNSjB0Vw__',
              blendColor: Color(0xFF12385D),
            )
          ],
        ),
      ),
    );
  }
}
