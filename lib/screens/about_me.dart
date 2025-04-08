import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/screens/about_me/first_section.dart';
import 'package:portfolio/screens/about_me/second_section.dart';
import 'package:portfolio/screens/about_me/third_section.dart';
import 'package:portfolio/utils/chat_bubble.dart';
import 'package:portfolio/utils/timeline_step.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  AboutMeScreenState createState() => AboutMeScreenState();
}

class AboutMeScreenState extends State<AboutMeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _scrolling = false;
  Duration duration = const Duration(milliseconds: 1000);

  Future<void> _onScroll(PointerScrollEvent event) async {
    if (_scrolling) return;
    _scrolling = true;

    if (event.scrollDelta.dy > 0 && _currentPage < 2) {
      setState(() {
        _currentPage++;
      });
    } else if (event.scrollDelta.dy < 0 && _currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }

    await _pageController.animateToPage(
      _currentPage,
      duration: duration,
      curve: Curves.easeInOut,
    );

    Future.delayed(duration, () {
      _scrolling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          _onScroll(event);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: const [FirstSection(), SecondSection(), ThirdSection()],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _buildFrameForPage(_currentPage),
          ),
        ],
      ),
    );
  }

  Widget _buildFrameForPage(int page) {
    final messages = [
      "👨‍🎓 Je m'appelle Enzo Monchanin et je suis un étudiant en 3ème année de BUT Informatique à l'IUT Lyon 1 (site de Bourg-en-Bresse).",
      "📱 Je suis passionné par le développement mobile, avec des préférences pour le Flutter en front-end :D",
      "🛠️ Je fais aussi énormément d'autres langages, consultez ma page \"Mes compétences\" pour en savoir plus !",
      "🧠 Je m'adapte très rapidement et facilement aux langages que je découvre grâce à ma curiosité.",
      "✨ J'adore ajouter des détails à mes projets, c'est selon moi ce qui lui donne de la vie, la minutie est très importante à mes yeux.",
    ];

    switch (page) {
      case 0:
        return KeyedSubtree(
          key: const ValueKey(0),
          child: _buildFrame(
            child: Column(
              children: [
                const SizedBox(height: 32),
                const CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 72,
                    backgroundImage: AssetImage('assets/photo.jpg'),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Enzo Monchanin',
                          style: Theme.of(
                            context,
                          ).textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            shadows: <Shadow>[const Shadow(blurRadius: 7)],
                          ),
                        ),
                        Text(
                          'Étudiant en BUT Informatique',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            shadows: <Shadow>[const Shadow(blurRadius: 5)],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                ...List.generate(
                  messages.length,
                  (i) => ChatBubble(text: messages[i], isMe: i.isEven),
                ),
              ],
            ),
          ),
        );
      case 1:
        return KeyedSubtree(
          key: const ValueKey(1),
          child: _buildFrame(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 24,
                    ),
                    child: Text(
                      "Mes centres d'intérêts",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        shadows: <Shadow>[const Shadow(blurRadius: 5)],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/interests/electronics.png',
                              width: MediaQuery.of(context).size.height * 0.15,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Électronique",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "L'imagination est infinie si on peut étendre la communication entre le réel et le virtuel.",
                              style: Theme.of(context).textTheme.titleSmall,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/interests/music.png',
                              width: MediaQuery.of(context).size.height * 0.15,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Musique",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "La musique est un élément nécessaire qui représente le mieux la liberté selon moi.",
                              style: Theme.of(context).textTheme.titleSmall,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/interests/photo.png',
                              width: MediaQuery.of(context).size.height * 0.15,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Photographie",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "La photographie me permet de faire le plein d'inspiration et de créativité.",
                              style: Theme.of(context).textTheme.titleSmall,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/interests/coffee.png',
                              width: MediaQuery.of(context).size.height * 0.15,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Café",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Que ce soit pour la digestion ou pour la fatigue, le café après le repas est un incontournable.",
                              style: Theme.of(context).textTheme.titleSmall,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case 2:
        return KeyedSubtree(
          key: const ValueKey(2),
          child: _buildFrame(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 24,
                    ),
                    child: Text(
                      "Passé composé, futur en marche",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        shadows: <Shadow>[const Shadow(blurRadius: 5)],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const TimelineStep(
                  title: "Les débuts sur Paint 🎨",
                  subtitle: "Étant petit, je dessinais sur l'ordinateur familial, fasciné par ce nouveau monde qui s'offrait à moi.",
                  icon: Icons.brush,
                ),
                const TimelineStep(
                  title: "Le déclic du collège 💡",
                  subtitle: "À cette période, j'ai vu les entrailles d'un site web et je me suis demandé comment cela fonctionnait ?",
                  icon: Icons.lightbulb,
                  isLeft: false,
                ),
                const TimelineStep(
                  title: "Mon premier site 🌐",
                  subtitle: "J’ai donc commencé à créer mon premier site perso à la fin du collège, pour expérimenter.",
                  icon: Icons.web,
                ),
                const TimelineStep(
                  title: "Bac STI2D SIN ⚙️",
                  subtitle: "J’ai fini par orienté mes études vers l’électronique et l'informatique, c'est là où j'ai su ce que je voulais faire.",
                  icon: Icons.school,
                  isLeft: false,
                ),
                const TimelineStep(
                  title: "BUT Informatique (voir + ?) 💻",
                  subtitle: "Aujourd’hui je continue mes études dans cette voie, j'ai compris que j'étais voué à celle-ci.",
                  icon: Icons.computer,
                ),
                const TimelineStep(
                  title: "Mon futur profesionnel 🚀",
                  subtitle: "Créer des apps mobiles qui communiquent avec le monde réel, Flutter & Arduino, là est ma passion.",
                  icon: Icons.mobile_friendly,
                  isLeft: false,
                ),
              ],
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildFrame({required Widget child}) {
    // 10% of the screen height
    final paddingHeight = MediaQuery.of(context).size.height * 0.10;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: paddingHeight,
          horizontal: paddingHeight,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(64)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.white),
                color: Colors.white38,
                borderRadius: const BorderRadius.all(Radius.circular(64)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
