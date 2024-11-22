import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';

class EventsPageView extends StatelessWidget {
  const EventsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            AppBar(
              title: Container(
                padding: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Find Match',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              height: 10,
              color: AppColors.navigationBar,
              width: double.infinity,
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading events'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No events found'));
          }

          final events = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;

              final sport = event['sport'] as String? ?? 'Unknown';
              final player = event['player'] as String? ?? 'Unknown';
              final location = event['location'] as String? ?? 'Unknown';
              final playersJoined = event['playersJoined'] as String? ?? '0/0';
              final Timestamp timestamp = event['date'] as Timestamp? ?? Timestamp.now();
              final DateTime dateTime = timestamp.toDate();
              final formattedDate = _formatDate(dateTime);

              return Column(
                children: [
                  MatchCard(
                    sport: sport,
                    player: player,
                    date: formattedDate,
                    location: location,
                    playersJoined: playersJoined,
                    imageUrl: sport == 'Football'
                        ? "https://s3-alpha-sig.figma.com/img/acd1/a7b7/df9840fe9d894de3084e41b03c39691f?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lE1eQBv1o3sHFJ3aaAqvMjeZl4ukvhPkp1eKsrwZqSgwWFn5ZUPAxQtTpGANRiNalXDPTUsljEb6thXIhipuPzpr9SCGxbOavS0RxRPt2NRNKsycBWz7EnpGwmZYE6uFz4XpHvfpkyo8C2H0Dm8Kw4kbLDzHfUlC4JIrAH-h2qAFr2PtK6gNHkEK8xDaOOIQfD3GGUCrsUPXCpR2Bnfqig6SCs6TrLSWZSU-7QBdh7qRZva~ihjxywXvXSyNkeA-sVYznuwHTIO0Mk0gRhjYW8oEz~QatM4e6PqvkwiOSZuUP6q0V9pPyf1Hxa2pxJqnB7fMYPYTKkkS~CsoEcRxZw__"
                        : "https://s3-alpha-sig.figma.com/img/7b4a/1c9c/c840d634ae0922d5fc8d630f34fe3c90?Expires=1732492800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ul~4CZrLbQXww8s4Z1~SYSCWSFqy2olCvyqtlnqYFM2l46po5HhhMTGHLgpchHdMTnrDUODuaYZ7vdcJzOMn0bA-wivTTv5qlOq7wmLlv3aSfh1Hi-WDWqhlF9T7EFQY1iBitiM1djwUuGbtOtAJ13bgIcBV5-H0gO5yXqWMbzdM~BSOU~JqDlDPUUztNVfraFNk5Z0~dw-liVrO1SgvGQ14iJOEv3CvxqpaXjF~3RYaukeJzIbkSvlUMVXxtxCdTjYznqNglAnEFIEJrHSdvj2TnVLglPde-4M2N3POPtbo78o6WdQsjqfFyI0D~~xIydPBJJgl8NqfYCMNSjB0Vw__",
                    blendColor: sport == 'Football'
                        ? const Color(0xFF0D6761)
                        : const Color(0xFF12385D),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Helper method to format the date
  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final day = date.day;
    final month = months[date.month - 1];
    final year = date.year;
    return '$month $day, $year'; // Example: October 20, 2023
  }
}
