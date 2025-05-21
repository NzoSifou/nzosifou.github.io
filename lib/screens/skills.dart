import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  SkillsScreenState createState() => SkillsScreenState();
}

class SkillsScreenState extends State<SkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              'Mes compétences',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SkillsList(
            skills: {
              'Mobile': null,
              'Flutter': 90,
              'Kotlin': 75,
              'API / Application': null,
              'Java': 80,
              'TypeScript (Node.js)': 70,
              'Web': null,
              'HTML / CSS': 90,
              'PHP': 60,
              'C++': 40,
              'Infrastructure': null,
              'Docker': 75,
              'CI/CD': 60,
              'Système': null,
              'Linux': 70,
            },
          ),
        ],
      ),
    );
  }
}

class SkillsList extends StatelessWidget {
  const SkillsList({required this.skills, super.key});

  final Map<String, int?> skills;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in skills.entries)
          if (entry.value == null)
            Column(
              children: [
                Divider(
                  thickness: 1,
                  indent: screenWidth / 4,
                  endIndent: screenWidth / 4,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      entry.key,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Builder(
              builder: (context) {
                final index = skills.keys.toList().indexOf(entry.key);
                final isFirstSkill =
                    index == 0 || skills.values.elementAt(index - 1) == null;
                if (isFirstSkill) {
                  final skillRow = <Widget>[];
                  var i = index;
                  while (i < skills.length &&
                      skills.values.elementAt(i) != null) {
                    final skillEntry = MapEntry(
                      skills.keys.elementAt(i),
                      skills.values.elementAt(i),
                    );
                    skillRow.add(
                      Padding(
                        padding: EdgeInsets.only(right: i > index ? 16.0 : 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              skillEntry.key,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  '${skillEntry.value}%',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge!.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.height / 8,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  child: CircularProgressIndicator(
                                    value: skillEntry.value! / 100,
                                    color: Colors.green,
                                    // ignore: deprecated_member_use Only way to use Material 3 design
                                    year2023: false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                    i++;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: skillRow,
                    ),
                  );
                } else {
                  // Ne rien afficher, déjà géré dans la ligne précédente
                  return const SizedBox.shrink();
                }
              },
            ),
      ],
    );
  }
}
