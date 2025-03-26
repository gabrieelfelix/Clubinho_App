part of 'detail_page_cubit.dart';

sealed class DetailPageState extends Equatable {
  const DetailPageState();

  @override
  List<Object> get props => [];
}

final class DetailPageInitial extends DetailPageState {}

final class DetailPageFailure extends DetailPageState {
  final String message;

  const DetailPageFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class DetailPageSuccess extends DetailPageState {
  final String? message;

  const DetailPageSuccess({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

final class DetailPageLoading extends DetailPageState {}
