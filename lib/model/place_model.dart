import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final String id;
  final String name;
  final String continent;
  final String? country;
  final String? stateName;
  final DocumentReference<Map<String, dynamic>>? stateReference;
  final double rating;
  final Map<String, Map<String, dynamic>> sustainability;
  final Map<String, List<String>> media;
  // final Map<String, dynamic> location;
  final List<String> headImage;
  final Map<String, String> facts;

  Place({
    required this.id,
    required this.name,
    required this.rating,
    required this.sustainability,
    required this.media,
    // required this.location,
    required this.headImage,
    required this.facts,
    required this.continent,
    required this.country,
    required this.stateName,
    required this.stateReference,
  });
}
