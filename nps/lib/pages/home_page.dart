import 'package:flutter/material.dart';
import 'sound_level_page.dart';
import 'history_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Histórico',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Histórico de Cálculos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context); // Sai para a tela de login
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo, $username!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SoundLevelCalculationPage(username: username),
                  ),
                );
              },
              child: const Text('Calcular Nível de Pressão Sonora'),
            ),
          ],
        ),
      ),
    );
  }
}
