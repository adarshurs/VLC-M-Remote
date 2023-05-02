
import '../utils/utils.dart';

class VLCStatus {

  VLCStatus({
    this.fullscreen = 0,
    this.audiodelay = 0,
    this.apiversion = 0,
    this.currentplid = -1,
    this.time = 0,
    this.volume = 0,
    this.length = 0,
    this.random = false,
    this.rate = 1,
    this.state = "paused",
    this.loop = false,
    this.version = "",
    this.position = 0.0,
    this.repeat = false,
    this.subtitledelay = 0,
    // required this.information,
    // required this.equalizer,
    //required this.videoeffects,
    //required this.audiofilters,
    //required this.stats,
  });

  late final int fullscreen;
  late final int audiodelay;
  late final int apiversion;
  late final int currentplid;
  late final int time;
  late final int volume;
  late final int length;
  late final bool random;
  late final int rate;
  late final String state;
  late final bool loop;
  late final String version;
  late final double position;
  late final bool repeat;
  late final int subtitledelay;

  Information? information;
  List<dynamic>? equalizer;
  //late final Stats stats;
  //late final Audiofilters audiofilters;
  //late final Videoeffects videoeffects;
  

  String get title{
    var title  = information?.category.meta.title ?? "";
    return title.isNotEmpty ? title : information?.category.meta.filename ?? "movie/song name";
  }

  String get album{
    return information?.category.meta.album ?? "album";
  }

  String get artist{
    return information?.category.meta.artist ?? "artist";
  }

  bool get isLatestVersionVLC{
    return version.contains("3.") ? true : false;
  }

  String get timeInHhMmSs{
    return formatSecondsInHhMmSs(time); 
  }

  String get lengthInHhMmSs{
    return formatSecondsInHhMmSs(length);
  }

  String get volumeInPercentage{
    //320 is 125% by default for vlc 512 is 200%
    return "  ${(double.parse((volume/256).toStringAsFixed(2)) * 100).toStringAsFixed(0)}%";
  }

  
  VLCStatus.fromJson(Map<String, dynamic> json){
    fullscreen = (json['fullscreen'] == true) ? 1 : 0;
    audiodelay = json['audiodelay'];
    apiversion = json['apiversion'];
    currentplid = json['currentplid'];
    time = json['time'];
    volume = json['volume'];
    length = json['length'];
    random = json['random'];
    rate = json['rate'];
    state = json['state'];
    loop = json['loop'];
    version = json['version'];
    position =  json['position'].toDouble();
    repeat = json['repeat'];
    subtitledelay = json['subtitledelay'];

    if(json['information'] != null){
      information = Information.fromJson(json['information']);
    }
    if(json['equalizer'] != null){
      equalizer = List.castFrom<dynamic, dynamic>(json['equalizer']);
    }

    //stats = Stats.fromJson(json['stats']);
    //audiofilters = Audiofilters.fromJson(json['audiofilters']);
    //videoeffects = Videoeffects.fromJson(json['videoeffects']);

  }
}
class Information {
  Information({
    required this.chapter,
    required this.chapters,
    required this.title,
    required this.category,
    required this.titles,
  });
  late final int chapter;
  late final List<dynamic> chapters;
  late final int title;
  late final Category category;
  late final List<dynamic> titles;
  
  Information.fromJson(Map<String, dynamic> json){
    chapter = json['chapter'];
    chapters = List.castFrom<dynamic, dynamic>(json['chapters']);
    title = json['title'];
    category = Category.fromJson(json['category']);
    titles = List.castFrom<dynamic, dynamic>(json['titles']);
  }
}

class Category {
  Category({
    required this.meta,
   // required this.stream0,
  });
  late final Meta meta;
  //late final Stream0 stream0;
  
  Category.fromJson(Map<String, dynamic> json){
    meta = Meta.fromJson(json['meta']);
   // stream0 = Stream0.fromJson(json['Stream 0']);
  }
}

class Meta{
  Meta({
    required this.album,
    required this.trackNumber,
    required this.title,
    required this.date,
    required this.artworkUrl,
    required this.artist,
    required this.filename,
  });
  late final String? album;
  late final String? trackNumber;
  late final String? title;
  late final String? date;
  late final String? artworkUrl;
  late final String? artist;
  late final String? filename;
  
  Meta.fromJson(Map<String, dynamic> json){
    album = json['album'];
    trackNumber = json['track_number'];
    title = json['title'];
    date = json['date'];
    artworkUrl = json['artwork_url'];
    artist = json['artist'];
    filename = json['filename'];
  }
}



// class Stats {
//   Stats({
//     required this.inputbitrate,
//     required this.sentbytes,
//     required this.lostabuffers,
//     required this.averagedemuxbitrate,
//     required this.readpackets,
//     required this.demuxreadpackets,
//     required this.lostpictures,
//     required this.displayedpictures,
//     required this.sentpackets,
//     required this.demuxreadbytes,
//     required this.demuxbitrate,
//     required this.playedabuffers,
//     required this.demuxdiscontinuity,
//     required this.decodedaudio,
//     required this.sendbitrate,
//     required this.readbytes,
//     required this.averageinputbitrate,
//     required this.demuxcorrupted,
//     required this.decodedvideo,
//   });
//   late final double inputbitrate;
//   late final int sentbytes;
//   late final int lostabuffers;
//   late final int averagedemuxbitrate;
//   late final int readpackets;
//   late final int demuxreadpackets;
//   late final int lostpictures;
//   late final int displayedpictures;
//   late final int sentpackets;
//   late final int demuxreadbytes;
//   late final double demuxbitrate;
//   late final int playedabuffers;
//   late final int demuxdiscontinuity;
//   late final int decodedaudio;
//   late final int sendbitrate;
//   late final int readbytes;
//   late final int averageinputbitrate;
//   late final int demuxcorrupted;
//   late final int decodedvideo;
  
//   Stats.fromJson(Map<String, dynamic> json){
//     inputbitrate = json['inputbitrate'];
//     sentbytes = json['sentbytes'];
//     lostabuffers = json['lostabuffers'];
//     averagedemuxbitrate = json['averagedemuxbitrate'];
//     readpackets = json['readpackets'];
//     demuxreadpackets = json['demuxreadpackets'];
//     lostpictures = json['lostpictures'];
//     displayedpictures = json['displayedpictures'];
//     sentpackets = json['sentpackets'];
//     demuxreadbytes = json['demuxreadbytes'];
//     demuxbitrate = json['demuxbitrate'];
//     playedabuffers = json['playedabuffers'];
//     demuxdiscontinuity = json['demuxdiscontinuity'];
//     decodedaudio = json['decodedaudio'];
//     sendbitrate = json['sendbitrate'];
//     readbytes = json['readbytes'];
//     averageinputbitrate = json['averageinputbitrate'];
//     demuxcorrupted = json['demuxcorrupted'];
//     decodedvideo = json['decodedvideo'];
//   }
// }

// class Audiofilters {
//   Audiofilters({
//     required this.filter_0,
//   });
//   late final String filter_0;
  
//   Audiofilters.fromJson(Map<String, dynamic> json){
//     filter_0 = json['filter_0'];
//   }
// }

// class Videoeffects {
//   Videoeffects({
//     required this.hue,
//     required this.saturation,
//     required this.contrast,
//     required this.brightness,
//     required this.gamma,
//   });
//   late final int hue;
//   late final int saturation;
//   late final int contrast;
//   late final int brightness;
//   late final int gamma;
  
//   Videoeffects.fromJson(Map<String, dynamic> json){
//     hue = json['hue'];
//     saturation = json['saturation'];
//     contrast = json['contrast'];
//     brightness = json['brightness'];
//     gamma = json['gamma'];
//   }
// }


//  class Stream0{
//   Stream0({
//     required this.Bitrate,
//     required this.Codec,
//     required this.Channels,
//     required this.BitsPerSample,
//     required this.Type,
//     required this.SampleRate,
//   });
//   late final String Bitrate;
//   late final String Codec;
//   late final String Channels;
//   late final String BitsPerSample;
//   late final String Type;
//   late final String SampleRate;
  
//   Stream0.fromJson(Map<String, dynamic> json){
//     Bitrate = json['Bitrate'];
//     Codec = json['Codec'];
//     Channels = json['Channels'];
//     BitsPerSample = json['Bits_per_sample'];
//     Type = json['Type'];
//     SampleRate = json['Sample_rate'];
//   }
// }