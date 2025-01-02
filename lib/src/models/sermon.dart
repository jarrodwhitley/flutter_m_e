import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

class Sermon {
  Sermon({
    required this.title,
    required this.scripture,
    required this.source,
    required this.sourceLink,
    required this.body,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final String scripture;
  final String source;
  final String sourceLink;
  final List<dynamic> body;
}
