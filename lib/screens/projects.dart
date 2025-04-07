import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height / 2),
      child: CarouselView.weighted(
        controller: controller,
        itemSnapping: true,
        flexWeights: const <int>[2, 7, 2],
        children:
        ImageInfo.values.map((ImageInfo image) {
          return HeroLayoutCard(imageInfo: image);
        }).toList(),
      ),
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.imageInfo});

  final ImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 7 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/material/${imageInfo.url}',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                imageInfo.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                imageInfo.subtitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
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

enum ImageInfo {
  image0('The Flow', 'Sponsored | Season 1 Now Streaming', 'content_based_color_scheme_1.png'),
  image1(
    'Through the Pane',
    'Sponsored | Season 1 Now Streaming',
    'content_based_color_scheme_2.png',
  ),
  image2('Iridescence', 'Sponsored | Season 1 Now Streaming', 'content_based_color_scheme_3.png'),
  image3('Sea Change', 'Sponsored | Season 1 Now Streaming', 'content_based_color_scheme_4.png'),
  image4('Blue Symphony', 'Sponsored | Season 1 Now Streaming', 'content_based_color_scheme_5.png'),
  image5('When It Rains', 'Sponsored | Season 1 Now Streaming', 'content_based_color_scheme_6.png');

  const ImageInfo(this.title, this.subtitle, this.url);
  final String title;
  final String subtitle;
  final String url;
}