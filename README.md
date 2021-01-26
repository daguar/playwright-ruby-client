[![Gem Version](https://badge.fury.io/rb/playwright-ruby-client.svg)](https://badge.fury.io/rb/playwright-ruby-client)

# playwright-ruby-client

A Ruby client for Playwright driver.

Note: Currently, this Gem is just a PoC (Proof of Concept). If you want to develop browser-automation for Chrome with Ruby, consider using [puppeteer-ruby](https://github.com/YusukeIwaki/puppeteer-ruby)

## Getting Started

At this point, playwright-ruby-client doesn't include the downloader of playwright driver, so **we have to install [playwright](https://github.com/microsoft/playwright) in advance**.

```sh
npm install playwright
./node_modules/.bin/playwright install
```

and then, set `playwright_cli_executable_path: ./node_modules/.bin/playwright` at `Playwright.create`.

Instead of npm install, you can also directly download playwright driver from playwright.azureedge.net/builds/. The URL can be easily detected from [here](https://github.com/microsoft/playwright-python/blob/79f6ce0a6a69c480573372706df84af5ef99c4a4/setup.py#L56-L61)

### Capture a site

```ruby
require 'playwright'

Playwright.create(playwright_cli_executable_path: '/path/to/playwright') do |playwright|
  playwright.chromium.launch(headless: false) do |browser|
    page = browser.new_page
    page.goto('https://github.com/YusukeIwaki')
    page.screenshot(path: './YusukeIwaki.png')
  end
end
```

![image](https://user-images.githubusercontent.com/11763113/104339718-412f9180-553b-11eb-9116-908e1e4b5186.gif)

### Simple scraping

```ruby
require 'playwright'

Playwright.create(playwright_cli_executable_path: './node_modules/.bin/playwright') do |playwright|
  playwright.chromium.launch(headless: false) do |browser|
    page = browser.new_page
    page.goto('https://github.com/')

    form = page.query_selector("form.js-site-search-form")
    search_input = form.query_selector("input.header-search-input")
    search_input.click
    page.keyboard.type_text("playwright")
    page.wait_for_navigation {
      page.keyboard.press("Enter")
    }

    list = page.query_selector("ul.repo-list")
    items = list.query_selector_all("div.f4")
    items.each do |item|
      title = item.eval_on_selector("a", "a => a.innerText")
      puts("==> #{title}")
    end
  end
end
```

```sh
$ bundle exec ruby main.rb 
==> microsoft/playwright
==> microsoft/playwright-python
==> microsoft/playwright-cli
==> checkly/headless-recorder
==> microsoft/playwright-sharp
==> playwright-community/jest-playwright
==> microsoft/playwright-test
==> mxschmitt/playwright-go
==> microsoft/playwright-java
==> MarketSquare/robotframework-browser
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Playwright project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/playwright-ruby-client/blob/master/CODE_OF_CONDUCT.md).
