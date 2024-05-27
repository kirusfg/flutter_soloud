import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:logging/logging.dart';

/// Simple usecase of flutter_soloud plugin
class PageHelloFlutterSoLoud extends StatefulWidget {
  const PageHelloFlutterSoLoud({super.key});

  @override
  State<PageHelloFlutterSoLoud> createState() => _PageHelloFlutterSoLoudState();
}

class _PageHelloFlutterSoLoudState extends State<PageHelloFlutterSoLoud> {
  static final Logger _log = Logger('_PageHelloFlutterSoLoudState');

  AudioSource? currentSound;

  @override
  Widget build(BuildContext context) {
    if (!SoLoud.instance.isInitialized) return const SizedBox.shrink();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// pick audio file
            ElevatedButton(
              onPressed: () async {
                final paths = (await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['mp3', 'wav', 'ogg', 'flac'],
                  onFileLoading: print,
                  dialogTitle: 'Pick audio file',
                ))
                    ?.files;
                if (paths != null) {
                  unawaited(play(paths.first.path!));
                }
              },
              child: const Text('pick audio'),
            ),
          ],
        ),
      ),
    );
  }

  /// play file
  Future<void> play(String file) async {
    /// stop any previous sound loaded
    if (currentSound != null) {
      try {
        await SoLoud.instance.disposeSource(currentSound!);
      } catch (e) {
        _log.severe('dispose error', e);
        return;
      }
    }

    /// load the audio file
    final AudioSource newSound;
    try {
      newSound = await SoLoud.instance.loadFile(file);
    } catch (e) {
      _log.severe('load error', e);
      return;
    }

    currentSound = newSound;

    /// play it
    await SoLoud.instance.play(currentSound!);
  }
}
