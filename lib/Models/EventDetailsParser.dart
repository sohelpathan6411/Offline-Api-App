class EventDetailsParser {
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
  var description;
  var venueInformation;
  var eventCreator;
  var teamInformation;
  var tags;
  var mainImage;
  var id;

  EventDetailsParser(
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
        this.description,
        this.venueInformation,
        this.eventCreator,
        this.teamInformation,
        this.tags,
        this.mainImage,
        this.id});

  EventDetailsParser.fromJson(Map<String, dynamic> json) {
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
    description = json['description'];
    venueInformation = json['venueInformation'];
    eventCreator = json['eventCreator'];
    teamInformation = json['teamInformation'];
    tags = json['tags'];
    mainImage = json['mainImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateTime'] = this.dateTime;
    data['bookBy'] = this.bookBy;
    data['ticketsSold'] = this.ticketsSold;
    data['maxTickets'] = this.maxTickets;
    data['friendsAttending'] = this.friendsAttending;
    data['price'] = this.price;
    data['isPartnered'] = this.isPartnered;
    data['sport'] = this.sport;
    data['totalPrize'] = this.totalPrize;
    data['location'] = this.location;
    data['description'] = this.description;
    data['venueInformation'] = this.venueInformation;
    data['eventCreator'] = this.eventCreator;
    data['teamInformation'] = this.teamInformation;
    data['tags'] = this.tags;
    data['mainImage'] = this.mainImage;
    data['id'] = this.id;
    return data;
  }
}
