import 'package:hive/hive.dart';  

part 'contact.g.dart'; 

@HiveType(typeId: 0) 
class Contact {
  @HiveField(0)
  final String nickname;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final String photoUrl;

  Contact({required this.nickname, required this.phone, required this.photoUrl});
}
