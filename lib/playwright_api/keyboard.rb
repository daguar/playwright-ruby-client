module Playwright
  # Keyboard provides an api for managing a virtual keyboard. The high level api is [`method: Keyboard.type`], which takes
  # raw characters and generates proper keydown, keypress/input, and keyup events on your page.
  #
  # For finer control, you can use [`method: Keyboard.down`], [`method: Keyboard.up`], and [`method: Keyboard.insertText`]
  # to manually fire events as if they were generated from a real keyboard.
  #
  # An example of holding down `Shift` in order to select and delete some text:
  #
  #
  # ```js
  # await page.keyboard.type('Hello World!');
  # await page.keyboard.press('ArrowLeft');
  #
  # await page.keyboard.down('Shift');
  # for (let i = 0; i < ' World'.length; i++)
  #   await page.keyboard.press('ArrowLeft');
  # await page.keyboard.up('Shift');
  #
  # await page.keyboard.press('Backspace');
  # // Result text will end up saying 'Hello!'
  # ```
  #
  # ```java
  # page.keyboard().type("Hello World!");
  # page.keyboard().press("ArrowLeft");
  # page.keyboard().down("Shift");
  # for (int i = 0; i < " World".length(); i++)
  #   page.keyboard().press("ArrowLeft");
  # page.keyboard().up("Shift");
  # page.keyboard().press("Backspace");
  # // Result text will end up saying "Hello!"
  # ```
  #
  # ```python async
  # await page.keyboard.type("Hello World!")
  # await page.keyboard.press("ArrowLeft")
  # await page.keyboard.down("Shift")
  # for i in range(6):
  #     await page.keyboard.press("ArrowLeft")
  # await page.keyboard.up("Shift")
  # await page.keyboard.press("Backspace")
  # # result text will end up saying "Hello!"
  # ```
  #
  # ```python sync
  # page.keyboard.type("Hello World!")
  # page.keyboard.press("ArrowLeft")
  # page.keyboard.down("Shift")
  # for i in range(6):
  #     page.keyboard.press("ArrowLeft")
  # page.keyboard.up("Shift")
  # page.keyboard.press("Backspace")
  # # result text will end up saying "Hello!"
  # ```
  #
  # ```csharp
  # await page.Keyboard.TypeAsync("Hello World!");
  # await page.Keyboard.PressAsync("ArrowLeft");
  #
  # await page.Keyboard.DownAsync("Shift");
  # for (int i = 0; i < " World".Length; i++)
  #     await page.Keyboard.PressAsync("ArrowLeft");
  #
  # await page.Keyboard.UpAsync("Shift");
  #
  # await page.Keyboard.PressAsync("Backspace");
  # // Result text will end up saying "Hello!"
  # ```
  #
  # An example of pressing uppercase `A`
  #
  #
  # ```js
  # await page.keyboard.press('Shift+KeyA');
  # // or
  # await page.keyboard.press('Shift+A');
  # ```
  #
  # ```java
  # page.keyboard().press("Shift+KeyA");
  # // or
  # page.keyboard().press("Shift+A");
  # ```
  #
  # ```python async
  # await page.keyboard.press("Shift+KeyA")
  # # or
  # await page.keyboard.press("Shift+A")
  # ```
  #
  # ```python sync
  # page.keyboard.press("Shift+KeyA")
  # # or
  # page.keyboard.press("Shift+A")
  # ```
  #
  # ```csharp
  # await page.Keyboard.PressAsync("Shift+KeyA");
  # // or
  # await page.Keyboard.PressAsync("Shift+A");
  # ```
  #
  # An example to trigger select-all with the keyboard
  #
  #
  # ```js
  # // on Windows and Linux
  # await page.keyboard.press('Control+A');
  # // on macOS
  # await page.keyboard.press('Meta+A');
  # ```
  #
  # ```java
  # // on Windows and Linux
  # page.keyboard().press("Control+A");
  # // on macOS
  # page.keyboard().press("Meta+A");
  # ```
  #
  # ```python async
  # # on windows and linux
  # await page.keyboard.press("Control+A")
  # # on mac_os
  # await page.keyboard.press("Meta+A")
  # ```
  #
  # ```python sync
  # # on windows and linux
  # page.keyboard.press("Control+A")
  # # on mac_os
  # page.keyboard.press("Meta+A")
  # ```
  #
  # ```csharp
  # // on Windows and Linux
  # await page.Keyboard.PressAsync("Control+A");
  # // on macOS
  # await page.Keyboard.PressAsync("Meta+A");
  # ```
  class Keyboard < PlaywrightApi

    # Dispatches a `keydown` event.
    #
    # `key` can specify the intended [keyboardEvent.key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key)
    # value or a single character to generate the text for. A superset of the `key` values can be found
    # [here](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values). Examples of the keys are:
    #
    # `F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`,
    # `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.
    #
    # Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`.
    #
    # Holding down `Shift` will type the text that corresponds to the `key` in the upper case.
    #
    # If `key` is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective
    # texts.
    #
    # If `key` is a modifier key, `Shift`, `Meta`, `Control`, or `Alt`, subsequent key presses will be sent with that modifier
    # active. To release the modifier key, use [`method: Keyboard.up`].
    #
    # After the key is pressed once, subsequent calls to [`method: Keyboard.down`] will have
    # [repeat](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat) set to true. To release the key, use
    # [`method: Keyboard.up`].
    #
    # > NOTE: Modifier keys DO influence `keyboard.down`. Holding down `Shift` will type the text in upper case.
    def down(key)
      wrap_impl(@impl.down(unwrap_impl(key)))
    end

    # Dispatches only `input` event, does not emit the `keydown`, `keyup` or `keypress` events.
    #
    #
    # ```js
    # page.keyboard.insertText('嗨');
    # ```
    #
    # ```java
    # page.keyboard().insertText("嗨");
    # ```
    #
    # ```python async
    # await page.keyboard.insert_text("嗨")
    # ```
    #
    # ```python sync
    # page.keyboard.insert_text("嗨")
    # ```
    #
    # ```csharp
    # await page.Keyboard.PressAsync("嗨");
    # ```
    #
    # > NOTE: Modifier keys DO NOT effect `keyboard.insertText`. Holding down `Shift` will not type the text in upper case.
    def insert_text(text)
      wrap_impl(@impl.insert_text(unwrap_impl(text)))
    end

    # `key` can specify the intended [keyboardEvent.key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key)
    # value or a single character to generate the text for. A superset of the `key` values can be found
    # [here](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values). Examples of the keys are:
    #
    # `F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`,
    # `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.
    #
    # Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`.
    #
    # Holding down `Shift` will type the text that corresponds to the `key` in the upper case.
    #
    # If `key` is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective
    # texts.
    #
    # Shortcuts such as `key: "Control+o"` or `key: "Control+Shift+T"` are supported as well. When specified with the
    # modifier, modifier is pressed and being held while the subsequent key is being pressed.
    #
    #
    # ```js
    # const page = await browser.newPage();
    # await page.goto('https://keycode.info');
    # await page.keyboard.press('A');
    # await page.screenshot({ path: 'A.png' });
    # await page.keyboard.press('ArrowLeft');
    # await page.screenshot({ path: 'ArrowLeft.png' });
    # await page.keyboard.press('Shift+O');
    # await page.screenshot({ path: 'O.png' });
    # await browser.close();
    # ```
    #
    # ```java
    # Page page = browser.newPage();
    # page.navigate("https://keycode.info");
    # page.keyboard().press("A");
    # page.screenshot(new Page.ScreenshotOptions().setPath(Paths.get("A.png"));
    # page.keyboard().press("ArrowLeft");
    # page.screenshot(new Page.ScreenshotOptions().setPath(Paths.get("ArrowLeft.png")));
    # page.keyboard().press("Shift+O");
    # page.screenshot(new Page.ScreenshotOptions().setPath(Paths.get("O.png")));
    # browser.close();
    # ```
    #
    # ```python async
    # page = await browser.new_page()
    # await page.goto("https://keycode.info")
    # await page.keyboard.press("a")
    # await page.screenshot(path="a.png")
    # await page.keyboard.press("ArrowLeft")
    # await page.screenshot(path="arrow_left.png")
    # await page.keyboard.press("Shift+O")
    # await page.screenshot(path="o.png")
    # await browser.close()
    # ```
    #
    # ```python sync
    # page = browser.new_page()
    # page.goto("https://keycode.info")
    # page.keyboard.press("a")
    # page.screenshot(path="a.png")
    # page.keyboard.press("ArrowLeft")
    # page.screenshot(path="arrow_left.png")
    # page.keyboard.press("Shift+O")
    # page.screenshot(path="o.png")
    # browser.close()
    # ```
    #
    # ```csharp
    # await page.GotoAsync("https://keycode.info");
    # await page.Keyboard.PressAsync("A");
    # await page.ScreenshotAsync("A.png");
    # await page.Keyboard.PressAsync("ArrowLeft");
    # await page.ScreenshotAsync("ArrowLeft.png");
    # await page.Keyboard.PressAsync("Shift+O");
    # await page.ScreenshotAsync("O.png");
    # await browser.CloseAsync();
    # ```
    #
    # Shortcut for [`method: Keyboard.down`] and [`method: Keyboard.up`].
    def press(key, delay: nil)
      wrap_impl(@impl.press(unwrap_impl(key), delay: unwrap_impl(delay)))
    end

    # Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.
    #
    # To press a special key, like `Control` or `ArrowDown`, use [`method: Keyboard.press`].
    #
    #
    # ```js
    # await page.keyboard.type('Hello'); // Types instantly
    # await page.keyboard.type('World', {delay: 100}); // Types slower, like a user
    # ```
    #
    # ```java
    # // Types instantly
    # page.keyboard().type("Hello");
    # // Types slower, like a user
    # page.keyboard().type("World", new Keyboard.TypeOptions().setDelay(100));
    # ```
    #
    # ```python async
    # await page.keyboard.type("Hello") # types instantly
    # await page.keyboard.type("World", delay=100) # types slower, like a user
    # ```
    #
    # ```python sync
    # page.keyboard.type("Hello") # types instantly
    # page.keyboard.type("World", delay=100) # types slower, like a user
    # ```
    #
    # ```csharp
    # await page.Keyboard.TypeAsync("Hello"); // types instantly
    # await page.Keyboard.TypeAsync("World"); // types slower, like a user
    # ```
    #
    # > NOTE: Modifier keys DO NOT effect `keyboard.type`. Holding down `Shift` will not type the text in upper case.
    # > NOTE: For characters that are not on a US keyboard, only an `input` event will be sent.
    def type(text, delay: nil)
      wrap_impl(@impl.type(unwrap_impl(text), delay: unwrap_impl(delay)))
    end

    # Dispatches a `keyup` event.
    def up(key)
      wrap_impl(@impl.up(unwrap_impl(key)))
    end
  end
end
