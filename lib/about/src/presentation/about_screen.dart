import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/localization/localization.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(S.of(context).about),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                onTap: _onPrivacyPolicyPressed,
                title: Text(S.of(context).about_privacy_policy),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  void _onPrivacyPolicyPressed() {
    final url = Uri.parse(
        'https://hexagonal-lillipilli-258.notion.site/Privacy-Policy-85c1876e57ed445b825a32863e603885');
    launchUrl(url);
  }
}
