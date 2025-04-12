import 'package:hive/hive.dart';

part 'contact.g.dart';  // Hive generates this file, so don't delete it.

@HiveType(typeId: 0)  // Type ID must be unique for each model.
class Contact {
  @HiveField(0)
  final String nickname;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final String photoUrl;

  Contact({
    required this.nickname,
    required this.phone,
    required this.photoUrl,
  });
}
