import 'package:brik_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}

abstract class UseCaseNoParam<Type> {
  Future<Either<Failure, Type>> call();
}

class NoParam extends Equatable {
  @override
  List<Object> get props => [];
}
