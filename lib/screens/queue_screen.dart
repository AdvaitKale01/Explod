import 'dart:math';

import 'package:audio_manager/audio_manager.dart';
import 'package:explod/screens/base_screen.dart';
import 'package:explod/theme/app_colors.dart';
import 'package:explod/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class QueueScreen extends StatelessWidget {
  final List<SongInfo> songInfo;
  final Function goToVisualizer;
  const QueueScreen({
    Key? key,
    required this.songInfo,
    required this.goToVisualizer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: songInfo.length,
          itemBuilder: (context, index) {
            var dur =
                Duration(milliseconds: int.parse(songInfo[index].duration));
            String twoDigits(int n) => n.toString().padLeft(2, "0");
            String twoDigitMinutes = twoDigits(dur.inMinutes.remainder(60));
            String twoDigitSeconds = twoDigits(dur.inSeconds.remainder(60));
            String duration = 'N:N';

            if (!twoDigits(dur.inHours).contains('0'))
              duration =
                  "${twoDigits(dur.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
            else
              duration = "$twoDigitMinutes:$twoDigitSeconds";

            return TextButton(
              onPressed: () async {
                //Send data backwards without affecting routes or states (pageIndex, SongIndex)
                goToVisualizer(0, index);
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.6),
                      child: Text(
                        songInfo[index].title[0].toUpperCase(),
                        style: AppTextStyle.h7BoldBlackGilroy,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Text(
                        songInfo[index].title,
                        style: AppTextStyle.h7BoldBlackQuicksand,
                      ),
                    ),
                    Text(
                      duration,
                      style: AppTextStyle.h7BoldBlackGilroy,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
