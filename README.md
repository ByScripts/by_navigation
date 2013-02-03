ByNavigation
============

Menu builder for Rails 3.2 (maybe earlier, not tested)

**Very early** version

Installation
------------

### Add gem to your Gemfile

    gem "by_navigation", git: "git@github.com:ByScripts/by_navigation.git"

### Update your gems

    bundle update

### Run the installer

    rails g by_navigation:install


Basic configuration
-------------------

```ruby
ByNavigation::Configuration.new :main_nav do

  item :home, "Home"

  item :media, "Multimedia" do

    item :audio, "Audio" do
      item :mp3, "MP3"
      item :flac, "FLAC"
    end

    item :video, "Video" do
      item :avi, "AVI"
      item :mkv, "MKV"
    end
  end

end
```

This will generates the following menu :

```html
  <ul class="main-nav depth-0" id="main-nav">
    <li class="main-nav home" data-url="/home" id="main-nav-home-item}">
      <div class="main-nav home" id="main-nav-home-content}">
        <a class="main-nav home" href="/home" id="main-nav-home-label">Home</a>
      </div>
    </li>
    <li class="main-nav media" data-url="/multimedia" id="main-nav-media-item}">
      <div class="main-nav media" id="main-nav-media-content}">
        <a class="main-nav media" href="/multimedia" id="main-nav-media-label">Multimedia</a>
        <ul class="main-nav media depth-1" id="main-nav-media">
          <li class="main-nav media audio" data-url="/multimedia/audio" id="main-nav-media-audio-item}">
            <div class="main-nav media audio" id="main-nav-media-audio-content}">
              <a class="main-nav media audio" href="/multimedia/audio" id="main-nav-media-audio-label">Audio</a>
              <ul class="main-nav media audio depth-2" id="main-nav-media-audio">
                <li class="main-nav media audio mp3" data-url="/multimedia/audio/mp3" id="main-nav-media-audio-mp3-item}">
                  <div class="main-nav media audio mp3" id="main-nav-media-audio-mp3-content}">
                    <a class="main-nav media audio mp3" href="/multimedia/audio/mp3" id="main-nav-media-audio-mp3-label">MP3</a>
                  </div>
                </li>
                <li class="main-nav media audio flac" data-url="/multimedia/audio/flac" id="main-nav-media-audio-flac-item}">
                  <div class="main-nav media audio flac" id="main-nav-media-audio-flac-content}">
                    <a class="main-nav media audio flac" href="/multimedia/audio/flac" id="main-nav-media-audio-flac-label">FLAC</a>
                  </div>
                </li>
              </ul>
            </div>
          </li>
          <li class="main-nav media video" data-url="/multimedia/video" id="main-nav-media-video-item}">
            <div class="main-nav media video" id="main-nav-media-video-content}">
              <a class="main-nav media video" href="/multimedia/video" id="main-nav-media-video-label">Video</a>
              <ul class="main-nav media video depth-2" id="main-nav-media-video">
                <li class="main-nav media video avi" data-url="/multimedia/video/avi" id="main-nav-media-video-avi-item}">
                  <div class="main-nav media video avi" id="main-nav-media-video-avi-content}">
                    <a class="main-nav media video avi" href="/multimedia/video/avi" id="main-nav-media-video-avi-label">AVI</a>
                  </div>
                </li>
                <li class="main-nav media video mkv" data-url="/multimedia/video/mkv" id="main-nav-media-video-mkv-item}">
                  <div class="main-nav media video mkv" id="main-nav-media-video-mkv-content}">
                    <a class="main-nav media video mkv" href="/multimedia/video/mkv" id="main-nav-media-video-mkv-label">MKV</a>
                  </div>
                </li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
    </li>
  </ul>
```

Advanced Configuration
----------------------

### Reference

```ruby
ByNavigation::Configuration.new :main_nav do
  item :level_1, "Level 1" do
    item :level_2, "Level 2" do
      item :level_3, "Level 3"
    end
  end
end
```

For reference, in the example above, `:level_3` datas will be:
  * **url:** `/level-1/level-2/level-3`
  * **html_id:** `main-nav-level-1-level-2-level-3`
  * **html_class**: `main-nav level-1 level-2 level-3`

### `no_link`

The `no_link` keyword permits to avoid the link creation for an item, replaced
by a span

```ruby
ByNavigation::Configuration.new :main_nav do
  item :level_1, "Level 1" do
    item :level_2, "Level 2" do
      no_link
      item :level_3, "Level 3"
    end
  end
end
```

In the example above, the `<a>` link will be replaced by a `<span>` for `:level_2`


### `slug`

By default, the item "slug" is auto-generated from title, thanks to [Stringex][stringex]

You can override this by using the `slug` keyword

```ruby
ByNavigation::Configuration.new :main_nav do
  item :level_1, "Level 1" do
    item :level_2, "Level 2" do
      slug "second-level"
      item :level_3, "Level 3"
    end
  end
end
```

In the example above, `:level_3` datas will be:
  * **url:** `/level-1/second-level/level-3`
  * **html_id:** `main-nav-level-1-level-2-level-3`
  * **html_class**: `main-nav level-1 level-2 level-3`

### `url`

By default, an item URL is generated by combining the item "slug" with all its
ascendants slug

However, sometimes you will need to override a whole URL
(pointing to another controller/action for example)

You can use full text, or whichever Rails helper to generate the url

```ruby
ByNavigation::Configuration.new :main_nav do
  item :level_1, "Level 1" do
    item :level_2, "Level 2" do
      url "im-root-url"
      item :level_3, "Level 3"
    end
  end
end
```

In the example above, `:level_3` datas will be:
  * **url:** `/im-root-url/level-3`
  * **html_id:** `main-nav-level-1-level-2-level-3`
  * **html_class**: `main-nav level-1 level-2 level-3`

### `html_id` and `html_class`

By default, `html_id` and `html_id` class will be set to the `dasherize`'d
version of item id

You can override these using the `html_id` and `html_class` keywords

```ruby
ByNavigation::Configuration.new :main_nav do
  item :level_1, "Level 1" do
    item :level_2, "Level 2" do
      html_id "second-id"
      html_class "second-class"
      item :level_3, "Level 3"
    end
  end
end
```

In the example above, `:level_3` datas will be:
  * **url:** `/level-1/level-2/level-3`
  * **html_id:** `main-nav-level-1-second-id-level-3`
  * **html_class**: `main-nav level-1 second-class level-3`

### `param`

The `param` keyword allows you to pass any additional parameter you want
to an item, which will be usable in the views.
Pass it a **key** and a **value** and you are done

`param :key, "value"`

You can also pass a third, optional, boolean parameter which, if is **true**,
will propagate the value to descendant items

`param :key, "value", true`

```ruby
ByNavigation::Configuration.new :main_nav do
  item :level_1, "Level 1" do
    param :first, "First"
    param :second, "Second", true
    param :third, "Third", true

    item :level_2, "Level 2" do
      param :second, nil

      item :level_3, "Level 3" do
        param :third, nil, true

        item :level_4, "Level 4"
      end
    end
  end
end
```

In the previous example

  * the `:first` param will be only available for `:level_1` item
  * the `:second` param will be available for `:level_1`, `:level_3` and `:level_4`
  * the `:third` param will be available for `:level_1` and `:level_2` only


[stringex]: https://github.com/rsl/stringex
