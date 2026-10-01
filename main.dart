import 'package:flutter/material.dart';

void main() {
  runApp(const FlohmarktApp());
}

class FlohmarktApp extends StatelessWidget {
  const FlohmarktApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kinder-Flohmarkt',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
      ),
      home: const Startseite(),
    );
  }
}

class Angebot {
  final String name;
  final String preis;
  final String kategorie;
  final IconData icon;

  Angebot({
    required this.name,
    required this.preis,
    required this.kategorie,
    required this.icon,
  });
}

class Startseite extends StatefulWidget {
  const Startseite({super.key});

  @override
  State<Startseite> createState() => _StartseiteState();
}

class _StartseiteState extends State<Startseite> {
  final List<Angebot> angebote = [
    Angebot(
      name: 'LEGO-Baukasten',
      preis: '10 €',
      kategorie: 'Spielzeug',
      icon: Icons.extension,
    ),
    Angebot(
      name: 'Kinderbücher',
      preis: '2 €',
      kategorie: 'Bücher',
      icon: Icons.menu_book,
    ),
    Angebot(
      name: 'Kinderjacke',
      preis: '5 €',
      kategorie: 'Kleidung',
      icon: Icons.checkroom,
    ),
    Angebot(
      name: 'Fußball',
      preis: '4 €',
      kategorie: 'Sport',
      icon: Icons.sports_soccer,
    ),
  ];

  void angebotHinzufuegen() {
    final nameController = TextEditingController();
    final preisController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('➕ Neues Angebot'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Was verkaufst du?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: preisController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preis',
                  suffixText: '€',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    preisController.text.isNotEmpty) {
                  setState(() {
                    angebote.add(
                      Angebot(
                        name: nameController.text,
                        preis: '${preisController.text} €',
                        kategorie: 'Sonstiges',
                        icon: Icons.sell,
                      ),
                    );
                  });

                  Navigator.pop(context);
                }
              },
              child: const Text('Hinzufügen'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🧸 Kinder-Flohmarkt',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: angebotHinzufuegen,
        icon: const Icon(Icons.add),
        label: const Text('Angebot'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Titel
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade300,
                    Colors.yellow.shade300,
                  ],
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    '🌈 KINDER-FLOHMARKT 🌈',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Stöbern • Entdecken • Schnäppchen finden!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Veranstaltung
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Text(
                        '📅 Nächster Flohmarkt',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      const ListTile(
                        leading: Icon(Icons.calendar_month),
                        title: Text('Freitag, 16. Oktober 2026'),
                      ),

                      const ListTile(
                        leading: Icon(Icons.access_time),
                        title: Text('13:30 bis 16:00 Uhr'),
                      ),

                      const ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Gartenstadt beim ALDI Spielplatz'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '🛍️ Angebote',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Angebote
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: angebote.length,
              itemBuilder: (context, index) {
                final angebot = angebote[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(angebot.icon),
                    ),
                    title: Text(
                      angebot.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(angebot.kategorie),
                    trailing: Text(
                      angebot.preis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
