import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/components/animated_gradient_container.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class AboutPage extends StatefulWidget {
  static const String _website = "https://palota.co.za";
  static const String _email = "jobs@palota.co.za";
  static const String _spotifyTerms =
      "https://www.spotify.com/us/legal/end-user-agreement/";

  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.width * 0.75,
            flexibleSpace: FlexibleSpaceBar(
              background: AnimatedGradientContainer(
                animation: animation,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 32,
              right: 32,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Text(
                    'This is a simple Flutter project prepared by Palota to be used for assessment purposes.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        child: const Text("Open Website"),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.blue,
                        ),
                        onPressed: () => _openUrl(AboutPage._website),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        child: const Text("E-Mail Us"),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.green,
                        ),
                        onPressed: () => _launchEmail(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Music playlist and category data in this assessment belongs to Spotify and is used under Spotify's terms and conditions",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextButton(
                        onPressed: () => _openUrl(AboutPage._spotifyTerms),
                        child: const Text("Spotify Terms and Conditions"),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                _buildVersionText(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionText(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext ctx, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          final PackageInfo packageInfo = snapshot.data as PackageInfo;
          return Text(
            "v${packageInfo.version} (${packageInfo.buildNumber})",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Future<bool> _openUrl(String url) async {
    if (await url_launcher.canLaunch(url)) {
      return url_launcher.launch(url);
    } else {
      return false;
    }
  }

  Future<bool> _launchEmail() async {
    const emailLink = "mailto:${AboutPage._email}";
    if (await url_launcher.canLaunch(emailLink)) {
      return url_launcher.launch(emailLink);
    } else {
      return false;
    }
  }
}
