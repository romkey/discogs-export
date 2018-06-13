# discogs.com export

This is a simple Ruby script to export a discogs.com user's wish list.

It scrapes the wish list from the web site and exports it as JSON.

## Installation

```
git clone git@github.com:romkey/discogs-export.git
cd discogs-export
bundle install
```

## Export

To run the export:
```
bundle exec discogs.rb USERNAME
```

where USERNAME is the discogs.com user's account name.

## Limitations

This script will break when discogs.com updates their page layout.

## License

[MIT License](https://romkey.mit-license.org/)
