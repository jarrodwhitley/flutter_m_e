class Sermon {
  const Sermon({
    required this.id,
    required this.date,
    required this.title,
    required this.scripture,
    required this.source,
    required this.sourceLink,
    required this.body,
  });

  final String id;
  final DateTime date;
  final String title;
  final String scripture;
  final String source;
  final String sourceLink;
  final String body;
}
