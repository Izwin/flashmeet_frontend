abstract class Either<L,R>{
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightRn);
}

class Left<L,R> extends Either<L,R> {
  final L value;
  Left(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightRn) {
    return leftFn(value);
  }
}

class Right<L,R> extends Either<L,R>{
  final R value;
  Right(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightRn) {
    return rightRn(value);
  }


}