class DateModel{
  int year ;
  int month ;
  int day ;
  int hour;
  int minute;
  int second;

  DateModel(this.year, this.month, this.day, this.hour, this.minute, this.second);

  static DateModel fromTimestamp(String timestamp){
    if(timestamp == ""){
      return DateModel(0, 0, 0, 0, 0, 0);
    }
    var firstCut = timestamp.split("-");
    var secondCut = firstCut[2].split('T');
    var thirdCut = secondCut[1].split(':');
    var forthCut = thirdCut[2].split('.');
    return DateModel(int.parse(firstCut[0]),
        int.parse(firstCut[1]),
        int.parse(secondCut[0]),
        int.parse(thirdCut[0]),
        int.parse(thirdCut[1]),
        int.parse(forthCut[0]));
  }

  String toString(){
    return '${this.day}/${this.month}/${this.year}';
  }
}