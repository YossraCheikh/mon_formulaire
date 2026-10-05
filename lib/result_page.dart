import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String nom;
  final String prenom;
  final bool isHomme;
  final List<String> langages;

  const ResultPage({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.isHomme,
    required this.langages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synthèse des Données'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Profil de l’utilisateur',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),

                  const SizedBox(height: 30),

                  _buildRow(
                    Icons.person,
                    'Nom',
                    nom,
                  ),

                  const Divider(
                    height: 30,
                    thickness: 2,
                  ),

                  _buildRow(
                    Icons.person,
                    'Prénom',
                    prenom,
                  ),

                  const Divider(
                    height: 30,
                    thickness: 2,
                  ),

                  _buildRow(
                    isHomme ? Icons.male : Icons.female,
                    'Sexe',
                    isHomme ? 'Homme' : 'Femme',
                  ),

                  const Divider(
                    height: 30,
                    thickness: 2,
                  ),

                  _buildListTitle(
                    Icons.code,
                    'Languages',
                    langages,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.teal,
        ),
        const SizedBox(width: 15),
        Text(
          '$label : ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildListTitle(
      IconData icon,
      String label,
      List<String> values,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.teal,
        ),
        const SizedBox(width: 15),
        Text(
          '$label : ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            values.isEmpty
                ? 'Aucun language sélectionné'
                : values.join(', '),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}