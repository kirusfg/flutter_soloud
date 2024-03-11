import 'package:flutter_soloud/src/exceptions.dart';
import 'package:meta/meta.dart';

/// CaptureDevice exposed to Dart
final class CaptureDevice {
  /// Constructs a new [CaptureDevice].
  // ignore: avoid_positional_boolean_parameters
  const CaptureDevice(this.name, this.isDefault);

  /// The name of the device.
  final String name;

  /// Whether this is the default capture device.
  final bool isDefault;
}

/// Possible capture errors
enum CaptureErrors {
  /// No error
  captureNoError,

  /// Capture failed to initialize
  captureInitFailed,

  /// Capture not yet initialized
  captureNotInited,

  /// null pointer. Could happens when passing a non initialized
  /// pointer (with calloc()) to retrieve FFT or wave data
  nullPointer;

  /// Returns a human-friendly sentence describing the error.
  String get _asSentence {
    switch (this) {
      case CaptureErrors.captureNoError:
        return 'No error';
      case CaptureErrors.captureInitFailed:
        return 'Capture failed to initialize';
      case CaptureErrors.captureNotInited:
        return 'Capture not yet initialized';
      case CaptureErrors.nullPointer:
        return 'Capture null pointer error. Could happens when passing a non '
            'initialized pointer (with calloc()) to retrieve FFT or wave data. '
            'Or, setVisualization has not been enabled.';
    }
  }

  @override
  String toString() => 'CaptureErrors.$name ($_asSentence)';
}

/// Possible player errors.
/// New values must be enumerated at the bottom
@internal
enum PlayerErrors {
  /// No error
  noError,

  /// Some parameter is invalid
  invalidParameter,

  /// File not found
  fileNotFound,

  /// File found, but could not be loaded
  fileLoadFailed,

  /// The sound file has already been loaded
  fileAlreadyLoaded,

  /// DLL not found, or wrong DLL
  dllNotFound,

  /// Out of memory
  outOfMemory,

  /// Feature not implemented
  notImplemented,

  /// Other error
  unknownError,

  /// null pointer. Could happens when passing a non initialized
  /// pointer (with calloc()) to retrieve FFT or wave data
  nullPointer,

  /// The sound with specified hash is not found
  soundHashNotFound,

  /// Player not initialized
  backendNotInited,

  /// Filter not found
  filterNotFound,

  /// asking for wave and FFT is not enabled
  visualizationNotEnabled,

  /// Audio isolate not yet started
  isolateNotStarted,

  /// Engine not yet started
  engineNotInited,

  /// The engine took too long to initialize.
  engineInitializationTimedOut,

  /// Asset was found but for some reason couldn't be loaded.
  assetLoadFailed;

  /// Returns a human-friendly sentence describing the error.
  String get _asSentence {
    switch (this) {
      case PlayerErrors.noError:
        return 'No error';
      case PlayerErrors.invalidParameter:
        return 'Some parameter is invalid';
      case PlayerErrors.fileNotFound:
        return 'File not found';
      case PlayerErrors.fileLoadFailed:
        return 'File found, but could not be loaded';
      case PlayerErrors.fileAlreadyLoaded:
        return 'The sound file has already been loaded';
      case PlayerErrors.dllNotFound:
        return 'DLL not found, or wrong DLL';
      case PlayerErrors.outOfMemory:
        return 'Out of memory';
      case PlayerErrors.notImplemented:
        return 'Feature not implemented';
      case PlayerErrors.unknownError:
        return 'Unknown error';
      case PlayerErrors.nullPointer:
        return 'Capture null pointer error. Could happens when passing a non '
            'initialized pointer (with calloc()) to retrieve FFT or wave data. '
            'Or, setVisualization has not been enabled.';
      case PlayerErrors.soundHashNotFound:
        return 'The sound with specified hash is not found';
      case PlayerErrors.backendNotInited:
        return 'Player not initialized';
      case PlayerErrors.isolateNotStarted:
        return 'Audio isolate not yet started';
      case PlayerErrors.engineNotInited:
        return 'Engine not yet started. '
            'Either asynchronously await `SoLoud.ready` '
            'or synchronously check `SoLoud.isReady` '
            'before calling the function.';
      case PlayerErrors.engineInitializationTimedOut:
        return 'Engine initialization timed out';
      case PlayerErrors.filterNotFound:
        return 'Filter not found';
      case PlayerErrors.visualizationNotEnabled:
        return 'Asking for audio data is not enabled! Please use '
            '`setVisualizationEnabled(true);` to enable!';
      case PlayerErrors.assetLoadFailed:
        return "Asset was found but for some reason couldn't be loaded. "
            'This could be a problem with the temporary directory into which '
            'the asset is being copied.';
    }
  }

  @override
  String toString() => 'PlayerErrors.$name ($_asSentence)';

  /// Returns the error as an exception to be thrown.
  Exception toException() {
    switch (this) {
      case PlayerErrors.noError:
        throw StateError('Trying to throw an exception with no error');
      case PlayerErrors.invalidParameter:
        return const SoLoudInvalidParameterException();
      case PlayerErrors.fileNotFound:
        return const SoLoudFileNotFoundException();
      case PlayerErrors.fileLoadFailed:
        return const SoLoudFileLoadFailedException();
      case PlayerErrors.fileAlreadyLoaded:
        return const SoLoudFileAlreadyLoadedException();
      case PlayerErrors.dllNotFound:
        return const SoLoudDllNotFoundException();
      case PlayerErrors.outOfMemory:
        return const SoLoudOutOfMemoryException();
      case PlayerErrors.notImplemented:
        return const SoLoudNotImplementedException();
      case PlayerErrors.unknownError:
        return const SoLoudUnknownErrorException();
      case PlayerErrors.nullPointer:
        return const SoLoudNullPointerException();
      case PlayerErrors.soundHashNotFound:
        return const SoLoudSoundHashNotFoundException(null);
      case PlayerErrors.backendNotInited:
        return const SoLoudBackendNotInitedException();
      case PlayerErrors.isolateNotStarted:
        return const SoLoudIsolateNotStartedException();
      case PlayerErrors.engineNotInited:
        return const SoLoudEngineNotInitedException();
      case PlayerErrors.engineInitializationTimedOut:
        return const SoLoudEngineInitializationTimedOutException();
      case PlayerErrors.filterNotFound:
        return const SoLoudFilterNotFoundException();
      case PlayerErrors.visualizationNotEnabled:
        return const SoLoudVisualizationNotEnabledException();
      case PlayerErrors.assetLoadFailed:
        return const SoLoudAssetLoadFailedException();
    }
  }
}

/// Wave forms
enum WaveForm {
  /// Raw, harsh square wave
  square,

  /// Raw, harsh saw wave
  saw,

  /// Sine wave
  sin,

  /// Triangle wave
  triangle,

  /// Bounce, i.e, abs(sin())
  bounce,

  /// Quarter sine wave, rest of period quiet
  jaws,

  /// Half sine wave, rest of period quiet
  humps,

  /// "Fourier" square wave; less noisy
  fSquare,

  /// "Fourier" saw wave; less noisy
  fSaw,
}

/// The way an audio file is loaded.
enum LoadMode {
  /// Load and decompress the audio file into RAM.
  /// Less CPU, more memory allocated, low latency.
  memory,

  /// Keep the file on disk and only load chunks as needed.
  /// More CPU, less memory allocated, seeking lags with MP3s.
  disk,
}
