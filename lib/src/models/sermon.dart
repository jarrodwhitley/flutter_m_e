// import 'package:uuid/uuid.dart';
// import 'package:flutter/foundation.dart';

// const uuid = Uuid();

class Sermon {
  final String id;
  final String title;
  final String scripture;
  final String source;
  final String sourceLink;
  final List<dynamic> body;

  Sermon({
    required this.id,
    required this.title,
    required this.scripture,
    required this.source,
    required this.sourceLink,
    required this.body,
  });

  // set up fromId()
  Sermon.fromId(this.id)
      : title = '',
        scripture = '',
        source = '',
        sourceLink = '',
        body = [];

  // set up == operator
  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Sermon && other.id == id;
  // }

  // set up hashCode
  // @override
  // int get hashCode => id.hashCode;
}
