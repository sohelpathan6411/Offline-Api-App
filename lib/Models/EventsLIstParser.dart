class EventsLIstParser {
  var name;
  var dateTime;
  var bookBy;
  var ticketsSold;
  var maxTickets;
  var friendsAttending;
  var price;
  var isPartnered;
  var sport;
  var totalPrize;
  var location;
  var isRecommended;
  var mainImage;
  var id;

  EventsLIstParser(
      {this.name,
        this.dateTime,
        this.bookBy,
        this.ticketsSold,
        this.maxTickets,
        this.friendsAttending,
        this.price,
        this.isPartnered,
        this.sport,
        this.totalPrize,
        this.location,
        this.isRecommended,
        this.mainImage,
        this.id});

  EventsLIstParser.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    bookBy = json['bookBy'];
    ticketsSold = json['ticketsSold'];
    maxTickets = json['maxTickets'];
    friendsAttending = json['friendsAttending'];
    price = json['price'];
    isPartnered = json['isPartnered'];
    sport = json['sport'];
    totalPrize = json['totalPrize'];
    location = json['location'];
    isRecommended = json['isRecommended'];
    mainImage = json['mainImage'];
    id = json['id'];
  }


}
