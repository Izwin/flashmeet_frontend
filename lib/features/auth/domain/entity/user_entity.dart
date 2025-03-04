import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String? bio;

  const UserEntity(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatar,
      this.bio});

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  @override
  List<Object?> get props => [id, email, name, avatar, bio];
}
