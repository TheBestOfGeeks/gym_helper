// ignore: one_member_abstracts
abstract interface class IRealTimeUpdater<T> {
  Stream<T> dataStream();
}
