import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rider.g.dart';

enum RiderAgeCategory {
  minor,
  adult,
}

@JsonSerializable(createFieldMap: true)
class Rider {
  Rider({
    required this.name,
    required this.phone,
    required this.city,
    required this.vehicleType,
    required String age,
    this.active = true,
    this.createdAt,
    required this.updatedAt,
  }) {
    this.age = RiderAgeCategory.values.firstWhere(
      (category) => category.toString() == age,
      orElse: () => RiderAgeCategory.adult,
    );
    // _$assertUsers(this);
  }

  factory Rider.fromJson(Map<String, Object?> json) => _$RiderFromJson(json);
  toMap() => _$RiderToJson(this);

  final String name;
  final String phone;
  final String city;
  final String vehicleType;
  late final RiderAgeCategory age;
  final bool active;
  @TimestampConverter()
  final DateTime? createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
}

@Collection<Rider>('Rider')
final riderRef = RiderCollectionReference();


// @Collection<User>('Users')
// // @Collection<Comment>('Users/*/comments', name: 'comments')
// final moviesRef = MovieCollectionReference();

// @JsonSerializable()
// class Comment {
//   Comment({
//     required this.authorName,
//     required this.message,
//   });

//   final String authorName;
//   final String message;
// }

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date);
  }
}
