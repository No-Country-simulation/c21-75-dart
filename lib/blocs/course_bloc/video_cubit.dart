import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoState.initial());

  void initializeController(String videoUrl) async {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize();
    emit(state.copyWith(controller: controller));
  }

  void disposeController() {
    state.controller?.dispose();
    emit(state.copyWith(controller: null));
  }

  void changeVideo(VideoPlayerController controller) {
    emit(state.copyWith(controller: controller));
  }
}

class VideoState {
  VideoState({
    required controller,
  }) : _controller = controller;

  factory VideoState.initial() {
    return VideoState(
      controller: null,
    );
  }

  VideoState copyWith({
    VideoPlayerController? controller,
  }) {
    return VideoState(
      controller: controller,
    );
  }

  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;
}
