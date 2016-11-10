import { NativeEventEmitter, NativeModules } from 'react-native'
const { RNRemoteAudio } = NativeModules

class Audio {
  constructor() {
    const audioEventEmitter = new NativeEventEmitter(RNRemoteAudio)

    this.subscriptions = [
      audioEventEmitter.addListener(
        RNRemoteAudio.PlaybackDidFinish,
        () => typeof this.onPlaybackDidFinish === 'function'
              && this.onPlaybackDidFinish()
      ),
      audioEventEmitter.addListener(
        RNRemoteAudio.PlaybackReady,
        () => typeof this.onPlaybackReady === 'function'
              && this.onPlaybackReady()
      )
    ]
  }

  destroy() {
    this.subscriptions.forEach(sub => sub.remove())
  }

  play(url) {
    RNRemoteAudio.play(url)
  }

  pause() {
    RNRemoteAudio.pause()
  }
}

export default Audio
