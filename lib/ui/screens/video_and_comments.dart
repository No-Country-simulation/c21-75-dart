import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/course.dart';
import '../../services/firebase_service.dart';

class VideoAndComments extends StatelessWidget {
  const VideoAndComments({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          // Video Player
          const VideoContainer(
            videoUrl:
                'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4',
          ),
          // Comments
          Expanded(
            child: ListView.builder(
              itemCount: course.evaluations?.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: FirebaseService.getStudentOfEvaluation(
                    studentId: course.evaluations![index].studentId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('No data');
                    }
                    final user = snapshot.data;
                    return ListTile(
                      title: Text(user!.name!),
                      subtitle: Text(course.evaluations![index].feedback),
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoContainer extends StatefulWidget {
  const VideoContainer({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .6,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: _controller.value.isInitialized
              ? Stack(
                  children: [
                    VideoPlayer(_controller),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: _controller.value.isPlaying
                            ? Colors.transparent
                            : Colors.black38,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _controller.value.position.compareTo(
                                            _controller.value.duration,
                                          ) ==
                                          0
                                      ? Icons.replay
                                      : _controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_controller.value.position.compareTo(
                                              _controller.value.duration,
                                            ) ==
                                            0 ||
                                        !_controller.value.isPlaying) {
                                      _controller.seekTo(
                                        const Duration(),
                                      );
                                    }
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                },
                              ),
                              Text(
                                '${_controller.value.position.inMinutes}:${_controller.value.position.inSeconds}/${_controller.value.duration.inMinutes}:${_controller.value.duration.inSeconds}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Slider(
                            value:
                                _controller.value.position.inSeconds.toDouble(),
                            min: 0,
                            max:
                                _controller.value.duration.inSeconds.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                _controller
                                    .seekTo(Duration(seconds: value.toInt()));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
