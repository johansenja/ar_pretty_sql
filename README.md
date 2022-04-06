# ArPrettySql

Inspect the SQL behind your Active Record queries, in a human-friendly manner.

```SQL
[1] pry(main)> User.where(first_name: "Geoff").order(id: :asc).limit(10).pp
SELECT
        "users" . *
    FROM
        "users"
    WHERE
        "users"."first_name" = 'Geoff'
    ORDER BY
        "users"."id" ASC LIMIT 10
=> nil
```

### Features

- Syntax highlighting
- Indentation and line breaks
- Customisable colour schemes
- Support for extended SQL function highlighting

## Installation

Add this line to your application's Gemfile:

```ruby
group :development, :test do
  gem 'ar_pretty_sql'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ar_pretty_sql

## Usage

```ruby
relation = User.where(age: 50)

relation.to_pretty_sql # generates a pretty string
relation.pp # same as `puts relation.to_pretty_sql`
```

Both of the methods can accept one-off options:

```ruby
relation.to_pretty_sql(color: false)
```

Configuration can also be set globally:

```ruby
# config/initializers/ar_pretty_sql.rb

ArPrettySql.configure do |config|
  # enable syntax highlighting for the output (also accepts `colour`)
  config.colour = true
  # prettify the SQL output
  config.format = true
  # the colour theme to use for highlighting the SQL output (provided `color` is true)
  config.theme =  Rouge::Themes::Colorful.new
  # extra SQL functions you want to provide highlighting for
  config.addition_sql_functions += %w[jsonb_build_object]
  # keyword case (:upper, :lower, :unchanged)
  config.keyword_case = :upper
end
```

- These same options can all be passed in as one-offs as keyword arguments.
- Colour themes are provided by [rouge](https://github.com/rouge-ruby/rouge) - see their docs for
  more options.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johansenja/ar_pretty_sql.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
