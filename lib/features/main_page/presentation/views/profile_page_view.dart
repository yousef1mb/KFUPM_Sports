import 'package:flutter/material.dart';
import 'package:kfupm_sports/providers/player_provider.dart';
import 'package:kfupm_sports/providers/uuid_provider.dart';
import 'package:provider/provider.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the KFUPM ID from UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final kfupmId = userProvider.kfupmId;

    return ChangeNotifierProxyProvider<UserProvider, PlayerProvider>(
      create: (_) => PlayerProvider(userId: kfupmId ?? "placeholder"),
      update: (context, userProvider, previous) =>
          PlayerProvider(userId: userProvider.kfupmId ?? "placeholder"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<PlayerProvider>(
          builder: (context, playerProvider, _) {
            // Trigger data fetch if not already done
            if (playerProvider.playerData.isEmpty) {
              playerProvider.fetchPlayerData();
            }

            // Loading state
            if (playerProvider.playerData.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Error handling (if needed)
            final playerData = playerProvider.playerData;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    backgroundImage: playerData['profilePicture'] != null
                        ? NetworkImage(playerData['profilePicture'])
                        : null,
                    child: playerData['profilePicture'] == null
                        ? const Icon(Icons.person,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(height: 12),

                  // User Name
                  Text(
                    playerData['name'] ?? 'Unknown User',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Divider
                  const Divider(),

                  // Bio Section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bio",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    playerData['bio'] ?? 'No bio available.',
                    textAlign: TextAlign.left,
                  ),

                  // Divider
                  const Divider(),

                  // Favorite Sports
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Favorite Sports",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        (playerData['favoriteSports'] as List<dynamic>? ?? [])
                            .map((sport) => Chip(
                                  label: Text(sport),
                                ))
                            .toList(),
                  ),

                  // Preferred Positions
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Preferred Positions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        (playerData['preferredPositions'] as List<dynamic>? ??
                                [])
                            .map((position) => Chip(
                                  label: Text(position),
                                ))
                            .toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
