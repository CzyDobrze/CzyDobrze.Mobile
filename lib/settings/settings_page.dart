import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ustawienia'),),
      body: ListView(
        children: [
          ListTile(title: const Text('Wersja aplikacji'), subtitle: FutureBuilder<PackageInfo>(future: PackageInfo.fromPlatform(), builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.done:
                return Text(snapshot.data!.version);
              default:
                return const Text('Ładowanie...');
            }
          },),),
        ],
      ),
    );
  }
}