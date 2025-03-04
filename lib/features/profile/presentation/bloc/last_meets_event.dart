abstract class LastMeetsEvent{

}

class GetLastMeetsEvent extends LastMeetsEvent{
  final bool refresh;

  GetLastMeetsEvent({this.refresh = false});
}