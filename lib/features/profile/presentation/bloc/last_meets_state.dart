import 'package:equatable/equatable.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';

enum LastMeetsStatus { initial, loading, success, error }

class LastMeetsState extends Equatable{
  final LastMeetsStatus status;
  final String? errorMessage;

  final List<MeetEntity>? lastMeets;

  final int currentPage;
  final bool isLastPage;

  LastMeetsState._(
      {required this.status,
      this.errorMessage,
      this.lastMeets,
      this.currentPage = 1,
      this.isLastPage = false});

  factory LastMeetsState.initial() =>
      LastMeetsState._(status: LastMeetsStatus.initial);

  LastMeetsState copyWith(
          {LastMeetsStatus? status,
          String? errorMessage,
          List<MeetEntity>? lastMeets,
          int? currentPage,
          bool? isLastPage}) =>
      LastMeetsState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          lastMeets: lastMeets ?? this.lastMeets,
          currentPage: currentPage ?? this.currentPage,
          isLastPage: isLastPage ?? this.isLastPage);

  @override
  List<Object?> get props => [status,errorMessage,lastMeets,currentPage,isLastPage];
}
