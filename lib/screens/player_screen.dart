import 'package:audio_manager/audio_manager.dart';
import 'package:explod/theme/app_colors.dart';
import 'package:explod/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class PlayerScreen extends StatefulWidget {
  final List<SongInfo> songInfo;
  final int songIndex;
  final bool isPlaying;
  const PlayerScreen(
      {Key? key,
      required this.songInfo,
      required this.songIndex,
      required this.isPlaying})
      : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with TickerProviderStateMixin {
  List<Color> colors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.yellowAccent
  ];
  late AnimationController _animationController;
  List<int> duration = [800, 900, 700, 600, 400];
  bool isPlaying = false;
  late double seekBar;
  late double songDuration;
  var audioManagerInstance = AudioManager.instance;

  playSong(songInfo, index) async {
    SongInfo song = songInfo[index];
    print('${song.fileSize}, $index');
    await audioManagerInstance
        .start("file://${song.filePath}", song.title,
            desc: song.displayName ?? 'song desc',
            auto: true,
            cover: song.albumArtwork ?? 'images/google_logo.png')
        .then((err) {
      print(err);
    });
  }

  void setupAudio() {
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          seekBar = 0;
          break;
        case AudioManagerEvents.seekComplete:
          seekBar = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = audioManagerInstance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          seekBar = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          // seekBar = audioManagerInstance.duration.inMilliseconds.toDouble();
          audioManagerInstance.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    playSong(widget.songInfo, widget.songIndex);
    isPlaying = widget.isPlaying;
    print('is playing $isPlaying');
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    songDuration = double.parse(widget.songInfo[widget.songIndex].duration);
    setupAudio();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'seekbar at $seekBar position ${audioManagerInstance.position} song duration $songDuration');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            widget.songInfo[widget.songIndex].title,
            style: AppTextStyle.h2BoldBlackGilroy,
            textAlign: TextAlign.center,
          ),
        ),

        //Visualizer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(
              10,
              (index) => VisualComponent(
                  duration: duration[index % 5], color: colors[index % 4])),
        ),
        //Music Slide Bar

        //Music Controls
        Column(
          children: [
            // Container(
            //   width: 32.0,
            //   margin: EdgeInsets.only(left: 6.0),
            //   child: Text(
            //     '${audioManagerInstance.position.inMinutes}:${audioManagerInstance.position.inSeconds}',
            //     style: AppTextStyle.h7BoldBlackQuicksand,
            //   ),
            // ),
            Slider(
              value: seekBar,
              min: 0,
              max: 1,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.black.withOpacity(0.3),
              onChanged: (value) {
                setState(() {
                  // audioManagerInstance.seekTo(position)
                  seekBar = value;
                });
              },
              onChangeEnd: (value) {
                if (audioManagerInstance.duration != null) {
                  Duration msec = Duration(
                      milliseconds:
                          (audioManagerInstance.duration.inMilliseconds * value)
                              .round());
                  audioManagerInstance.seekTo(msec);
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Previous
                IconButton(
                  icon: Icon(Icons.skip_previous_rounded),
                  iconSize: 60,
                  onPressed: () => audioManagerInstance.previous(),
                ),
                IconButton(
                  onPressed: () {
                    print('is playing $isPlaying');
                    setState(() {
                      isPlaying = !isPlaying;
                      isPlaying
                          ? _animationController.reverse()
                          : _animationController.forward();
                      audioManagerInstance.playOrPause();
                    });
                  },
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.pause_play,
                    progress: _animationController,
                  ),
                  iconSize: 60,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next_rounded),
                  iconSize: 60,
                  onPressed: () => audioManagerInstance.next(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class VisualComponent extends StatefulWidget {
  const VisualComponent({required this.duration, required this.color});

  final int duration;
  final Color color;

  @override
  _VisualComponentState createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animController, curve: Curves.easeOutExpo);

    //end: 100 is height of all bars
    animation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10,
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(5)),
        height: animation.value);
  }
}

/*
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  void setupAudio() {
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          _slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = audioManagerInstance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          audioManagerInstance.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    showVol = !showVol;
                  });
                },
                child: IconText(
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    string: "volume",
                    iconSize: 20,
                    iconData: Icons.volume_down),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.black,
          title: showVol
              ? Slider(
                  value: audioManagerInstance.volume ?? 0,
                  onChanged: (value) {
                    setState(() {
                      audioManagerInstance.setVolume(value, showVolume: true);
                    });
                  },
                )
              : Text("Music app demo"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 500,
              child: FutureBuilder<List<SongInfo>>(
                future: FlutterAudioQuery().getSongs(),
                builder: (context, snapshot) {
                  List<SongInfo>? songInfo = snapshot.data;
                  print(snapshot.data);
                  if (snapshot.hasData) return SongWidget(songList: songInfo!);
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Loading....",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomPanel(),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget songProgress(BuildContext context) {
    var style = TextStyle(color: Colors.black);
    return Row(
      children: <Widget>[
        Text(
          _formatDuration(audioManagerInstance.position),
          style: style,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: Colors.blueAccent,
                  overlayColor: Colors.blue,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _slider ?? 0,
                  onChanged: (value) {
                    setState(() {
                      _slider = value;
                    });
                  },
                  onChangeEnd: (value) {
                    if (audioManagerInstance.duration != null) {
                      Duration msec = Duration(
                          milliseconds:
                              (audioManagerInstance.duration.inMilliseconds *
                                      value)
                                  .round());
                      audioManagerInstance.seekTo(msec);
                    }
                  },
                )),
          ),
        ),
        Text(
          _formatDuration(audioManagerInstance.duration),
          style: style,
        ),
      ],
    );
  }

  Widget bottomPanel() {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: songProgress(context),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                    onPressed: () => audioManagerInstance.previous()),
              ),
              backgroundColor: Colors.cyan.withOpacity(0.3),
            ),
            CircleAvatar(
              radius: 30,
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    audioManagerInstance.playOrPause();
                  },
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(
                    audioManagerInstance.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.cyan.withOpacity(0.3),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                    onPressed: () => audioManagerInstance.next()),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

var audioManagerInstance = AudioManager.instance;
bool showVol = false;
PlayMode playMode = audioManagerInstance.playMode;
bool isPlaying = false;
double _slider = 0.0;

class IconText extends StatelessWidget {
  final IconData iconData;
  final String string;
  final Color iconColor;
  final Color textColor;
  final double iconSize;

  IconText({
    required this.textColor,
    required this.iconColor,
    required this.string,
    required this.iconSize,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          string,
          style: TextStyle(
              color: Colors.red, fontSize: 10, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class SongWidget extends StatelessWidget {
  final List<SongInfo> songList;

  SongWidget({required this.songList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, songIndex) {
          SongInfo song = songList[songIndex];
          if (song.displayName.contains(".mp3"))
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(song.title,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Text("Release Year: ${song.year}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text("Artist: ${song.artist}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text("Composer: ${song.composer}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                  "Duration: ${parseToMinutesSeconds(int.parse(song.duration))} min",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await audioManagerInstance
                                  .start("file://${song.filePath}", song.title,
                                      desc: song.displayName ??
                                          'images/google_logo.png',
                                      auto: true,
                                      cover: song.albumArtwork ??
                                          'images/google_logo.png')
                                  .then((err) {
                                print(err);
                              });
                            },
                            child: IconText(
                              iconData: Icons.play_circle_outline,
                              iconColor: Colors.red,
                              string: "Play",
                              textColor: Colors.black,
                              iconSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

          return SizedBox(
            height: 0,
          );
        });
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}
*/
