import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'result_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _nomController =
  TextEditingController();

  final TextEditingController _prenomController =
  TextEditingController();

  bool _isHomme = true;

  final Map<String, bool> _langagesValides = {
    'Java': false,
    'Flutter': false,
    'Javascript': false,
  };

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  Future<void> _navigateToResultPage() async {
    final List<String> selectedLangages = _langagesValides.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    try {
      await FirebaseFirestore.instance.collection('users').add({
        'nom': _nomController.text,
        'prenom': _prenomController.text,
        'sexe': _isHomme ? 'Homme' : 'Femme',
        'langages': selectedLangages,
        'date_creation': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultPage(
            nom: _nomController.text,
            prenom: _prenomController.text,
            isHomme: _isHomme,
            langages: selectedLangages,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'enregistrement : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Formulaire'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informations Personnelles',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                        labelText: 'Prénom',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sexe :',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: _isHomme,
                          onChanged: (bool value) {
                            setState(() {
                              _isHomme = value;
                            });
                          },
                          activeColor: Colors.teal,
                        ),
                        Text(
                          _isHomme ? 'Homme' : 'Femme',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Compétences techniques',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ..._langagesValides.keys.map(
                          (String key) {
                        return CheckboxListTile(
                          title: Text(
                            key,
                            style: const TextStyle(fontSize: 16),
                          ),
                          value: _langagesValides[key],
                          onChanged: (bool? value) {
                            setState(() {
                              _langagesValides[key] = value ?? false;
                            });
                          },
                          activeColor: Colors.teal,
                          checkColor: Colors.white,
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _navigateToResultPage,
              icon: const Icon(Icons.send),
              label: const Text('Soumettre'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}