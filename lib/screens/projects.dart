import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/screens/projects_details.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: CarouselView.weighted(
        controller: controller,
        itemSnapping: true,
        flexWeights: const <int>[3, 7, 3],
        children:
            ProjectInfo.values.map((ProjectInfo project) {
              return HeroLayoutCard(projectInfo: project);
            }).toList(),
        onTap: (int index) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder:
                  (BuildContext context) =>
                      ProjectsDetailsScreen(projectInfo: ProjectInfo.values[index]),
            ),
          );
        },
      ),
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({required this.projectInfo, super.key});

  final ProjectInfo projectInfo;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ClipRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Image(
                    fit: BoxFit.cover,
                    width: width / 4,
                    image: AssetImage('assets/projects/${projectInfo.mainImage}'),
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ClipRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Image(
                    fit: BoxFit.cover,
                    width: width / 4,
                    image: AssetImage('assets/projects/${projectInfo.mainImage}'),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),
            ),
            Align(
              child: ClipRect(
                child: Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/projects/${projectInfo.mainImage}'),
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(75),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                projectInfo.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                projectInfo.subtitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

enum ProjectInfo {
  plantWhisperer(
    'Plant Whisperer',
    'Blog mobile pour présenter des plantes et leurs bienfaits',
    "Plant Whisperer est une application dans un style blog qui permet d'ajouter des plantes avec diverses informations.\nSur cette application nous pourrons retrouver un système de contribution, n'importe qui peut ajouter une plante avec ses informations dessus qui devront par la suite être validé par un modérateur.\nNous avons aussi la possibilité de rechercher des plantes et de les trier par contributions, catégories, etc.\nJ'ai pu en apprendre beaucoup sur la gestion des contributions dans une base de données, en plus des filtres de recherche.",
    'plant_whisperer.jpg',
    'plant_whisperer_2.jpg',
    'https://github.com/NzoSifou/plant_whisperer',
  ),
  neoGate(
    'NeoGate',
    'Projet de porte connectée et securisée',
    "NeoGate est une application et un ESP32 permettant de controller différents module afin de gérer une porte à distance ou physiquement. C'est un projet de porte connectée qui ne s'ouvre uniquement en la présence d'un badge NFC autorisé. De plus, une option de maintien de la porte ouverte est disponible avec un bouton physique ou depuis l'application. À partir de celle-ci, nous pouvons gérer la porte à distance, comme l'ouvrir sans badge NFC (car il faut être authentifié sur l'application), mais encore ajouter ou supprimer des badges NFC dit \"Autoriser\" pour ouvrir la porte.\nCe projet m'a permis d'en apprendre énormément sur la communication entre un ESP32 et une Firebase (Realtime Database), ainsi que la gestion des différents modules d'un ESP32.",
    'neogate.jpg',
    'neogate_2.jpg',
    'https://forge.univ-lyon1.fr/WOT_BUT3MOB_2025/groupe-11',
  ),
  orienteering(
    'Orienteering',
    "Interactivité et personnalisation pour des courses d'orientation",
    "Orienteering est une application lié à des ESP32 qui communique avec celle-ci. L'objectif de cette application est de permettre de concevoir une course avec différentes étapes entièrement personnalisable avec ou sans la présence de l'application mobile.\nL'application mobile permet à l'utilisateur de rendre la course interactive, c'est-à-dire qu'à chaque fois que l'utilisateur présentera son badge à chaque balise (chaque étape de la course), l'application réagira en faisant augmenter son nombre de balise trouvées et donc mettra à jour son classement en temps réel, et lui posera une question (QCM) vis-à-vis de la balise qu'il vient de scanner avec une animation en plus.\nJ'ai pu renforcer mes connaissances sur la communication entre Firebase et Flutter, notamment avec les systèmes de listener. J'ai aussi pu apprendre a gérer des QR Code avec une page personnalisée (ce que je ne savais pas faire avant).",
    'orienteering.jpg',
    'orienteering_2.jpg',
    'https://iutbg-gitlab.iutbourg.univ-lyon1.fr/sae-but31/2024-25-mobile/course-orientation',
  ),
  forgather(
    'Forgather',
    'Propose des activités à faire autour de chez soi',
    "Forgather est une application dans le style d'un Google Maps mais avec des détails uniquement sur les activités à faire autour de chez soi, elle permet de trouver facilement et rapidement des activités à faire dans un rayon donnée (pratique si on souhaite y aller en voiture ou à pied) et à une position donnée (soit la position actuelle de l'utilisateur, soit la position préférée de l'utilisateur, exemple : chez soi).\nL'objectif était d'afficher la fourchette de prix et les horaires d'ouverture et de fermeture de chaque activité (bien que nous n'avons pas pu trouver d'API pour faire ceci, cela reste possible).\nCette application possède une gestion de favoris, nous pouvons donc ajouter aux favoris nos activités préférées.\nJe n'ai pas l'habitude de travailler avec la position actuelle de l'utilisateur ainsi qu'avec des cartes (comme Google Maps), c'est pourquoi j'ai pu acquérir de nouvelles connaissances grâce à cette application, autant pour récupérer la position de l'utilisateur en temps réel que poru afficher les activités avec des marqueurs sur la carte.",
    'forgather.jpg',
    'forgather_2.jpg',
    'https://github.com/NzoSifou/forgather-flutter',
  );

  const ProjectInfo(this.title, this.subtitle, this.description, this.mainImage, this.secondImage, this.url);

  final String title;
  final String subtitle;
  final String description;
  final String mainImage;
  final String secondImage;
  final String url;
}
