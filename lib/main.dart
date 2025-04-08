import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/i18n/generated/translations.g.dart';
import 'package:portfolio/screens/about_me.dart';
import 'package:portfolio/screens/projects.dart';
import 'package:portfolio/screens/skills.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const Portfolio()));
}

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      title: 'Portfolio',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: PortfolioScreen(),
      scrollBehavior: WebScrollBehavior(),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AboutMeScreen(),
    ProjectsScreen(),
    SkillsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) async {
              if (index == 3) {
                final url = "assets/CV_Enzo_MONCHANIN.pdf";
                final uri = Uri.parse(url);
                if (!await launchUrl(uri)) {
                  throw 'Impossible de lancer $uri';
                }
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Image.asset(
                  'assets/minecraft/head.png',
                  width: 24,
                  height: 24,
                ),
                selectedIcon: Image.asset(
                  'assets/minecraft/head.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(t.about_me),
              ),
              NavigationRailDestination(
                icon: Image.asset(
                  'assets/minecraft/redstone.png',
                  width: 24,
                  height: 24,
                ),
                selectedIcon: Image.asset(
                  'assets/minecraft/redstone.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(t.my_projets),
              ),
              NavigationRailDestination(
                icon: Image.asset(
                  'assets/minecraft/enchantment_table.png',
                  width: 24,
                  height: 24,
                ),
                selectedIcon: Image.asset(
                  'assets/minecraft/enchantment_table.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(t.my_skills),
              ),
              NavigationRailDestination(
                icon: Image.asset(
                  'assets/minecraft/book.png',
                  width: 24,
                  height: 24,
                ),
                selectedIcon: Image.asset(
                  'assets/minecraft/book.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(t.my_cv),
              ),
            ],
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}
