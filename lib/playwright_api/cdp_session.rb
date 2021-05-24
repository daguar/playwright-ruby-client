module Playwright
  # - extends: [EventEmitter]
  #
  # The `CDPSession` instances are used to talk raw Chrome Devtools Protocol:
  # - protocol methods can be called with `session.send` method.
  # - protocol events can be subscribed to with `session.on` method.
  #
  # Useful links:
  # - Documentation on DevTools Protocol can be found here:
  #   [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/).
  # - Getting Started with DevTools Protocol:
  #   https://github.com/aslushnikov/getting-started-with-cdp/blob/master/README.md
  #
  #
  # ```js
  # const client = await page.context().newCDPSession(page);
  # await client.send('Animation.enable');
  # client.on('Animation.animationCreated', () => console.log('Animation created!'));
  # const response = await client.send('Animation.getPlaybackRate');
  # console.log('playback rate is ' + response.playbackRate);
  # await client.send('Animation.setPlaybackRate', {
  #   playbackRate: response.playbackRate / 2
  # });
  # ```
  #
  # ```python async
  # client = await page.context().new_cdp_session(page)
  # await client.send("animation.enable")
  # client.on("animation.animation_created", lambda: print("animation created!"))
  # response = await client.send("animation.get_playback_rate")
  # print("playback rate is " + response["playback_rate"])
  # await client.send("animation.set_playback_rate", {
  #     playback_rate: response["playback_rate"] / 2
  # })
  # ```
  #
  # ```python sync
  # client = page.context().new_cdp_session(page)
  # client.send("animation.enable")
  # client.on("animation.animation_created", lambda: print("animation created!"))
  # response = client.send("animation.get_playback_rate")
  # print("playback rate is " + response["playback_rate"])
  # client.send("animation.set_playback_rate", {
  #     playback_rate: response["playback_rate"] / 2
  # })
  # ```
  class CDPSession < PlaywrightApi

    # Detaches the CDPSession from the target. Once detached, the CDPSession object won't emit any events and can't be used to
    # send messages.
    def detach
      raise NotImplementedError.new('detach is not implemented yet.')
    end

    def send_message(method, params: nil)
      raise NotImplementedError.new('send_message is not implemented yet.')
    end
  end
end
