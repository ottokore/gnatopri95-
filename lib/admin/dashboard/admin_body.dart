import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';

class AdminBody extends StatelessWidget {
  AdminBody({super.key});

  final List<Map<String, dynamic>> userData = [
    {
      'name': 'Koffi Konan Jean',
      'country': 'Côte d\'Ivoire',
      'date': '05 Jan 2024',
      'time': '09:48',
      'userAvatar': const AssetImage('assets/images/avatar1.png'),
    },
    {
      'name': 'Ouédraogo Salimata',
      'country': 'Côte d\'Ivoire',
      'date': '05 Jan 2024',
      'time': '09:49',
      'userAvatar': const AssetImage('assets/images/avatar1.png'),
    },
    {
      'name': 'Traoré Jean-Luc',
      'country': 'Burkina Faso',
      'date': '06 Jan 2024',
      'time': '11:49',
      'userAvatar': const AssetImage('assets/images/avatar3.png'),
    },
    {
      'name': 'Kouassi Christian',
      'country': 'Côte d\'Ivoire',
      'date': '03 Fév 2024',
      'time': '11:41',
      'userAvatar': const AssetImage('assets/images/avatar4.png'),
    },
    {
      'name': 'Kouso Patrice',
      'country': 'Bénin',
      'date': '04 Fév 2024',
      'time': '10:31',
      'userAvatar': const AssetImage('assets/images/avatar5.png'),
    },
    {
      'name': 'Ami Touré',
      'country': 'Côte d\'Ivoire',
      'date': '03 Fév 2024',
      'time': '11:47',
      'userAvatar': const AssetImage('assets/images/avatar6.png'),
    },
    {
      'name': 'Sangaré Drissa',
      'country': 'Mali',
      'date': '03 Fév 2024',
      'time': '12:22',
      'userAvatar': const AssetImage('assets/images/avatar7.png'),
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: userData
          .map(
            (userDataMap) => Column(
              children: [
                UserCard(
                  name: userDataMap['name']!,
                  country: userDataMap['country']!,
                  date: userDataMap['date']!,
                  time: userDataMap['time']!,
                  userAvatar: userDataMap['userAvatar']!,
                ),
                if (userDataMap != userData.last) const SizedBox(height: 16),
              ],
            ),
          )
          .toList(),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String country;
  final String date;
  final String time;
  final ImageProvider userAvatar;

  const UserCard({
    super.key,
    required this.name,
    required this.country,
    required this.date,
    required this.time,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: userAvatar,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: darkColor,
                        ),
                      ),
                      Text(
                        country,
                        style: const TextStyle(
                          fontSize: 13,
                          color: lightColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: light2Color,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: light2Color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}