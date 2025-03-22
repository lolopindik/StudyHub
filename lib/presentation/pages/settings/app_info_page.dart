import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/appbars/settings_appbar.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  _AppInfoPageState createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppTheme.mainColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyles.ruberoidLight20,
          ),
          subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle,
              style: TextStyles.ruberoidLight15),
        ),
      ),
    );
  }

  Widget imageIcon(String asset) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.20,
        child: Image.asset(asset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSettingsAppBar(context, 'О программе'),
      backgroundColor: AppTheme.secondaryColor,
      body: RawScrollbar(
        thumbColor: Colors.white70,
        thickness: 2,
        radius: const Radius.circular(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              imageIcon('lib/assets/images/app_icon.png'),
              _infoTile('App name', _packageInfo.appName),
              _infoTile('Package name', _packageInfo.packageName),
              _infoTile('App version', _packageInfo.version),
              _infoTile('Build number', _packageInfo.buildNumber),
              _infoTile('Build signature', _packageInfo.buildSignature),
              _infoTile(
                'Installer store',
                _packageInfo.installerStore ?? 'not available',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
