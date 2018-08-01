# ElasticsearchQuery

`ElastocsearchQuery` is a tranformer from [`JSONAPI`](http://jsonapi.org) style params hash into an [`Elasticseatch-ruby`](https://github.com/elastic/elasticsearch-ruby)-compatible object that can easily be fed into `client.search`

*Note*: This gem was written for use with a [modified](https://github.com/tiagopog/jsonapi-utils/pull/90) [`JSONAPI::Utils`](https://github.com/tiagopog/jsonapi-utils/) and uses several constructs from it (Paginator, param structure).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elasticsearch_query'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elasticsearch_query

## Usage

Using the gem is pretty strightforward. You have to set up 2 things: the paginator, and the range parser (if your api accepts range filters)

### Example

If you are using the above mentioned [modified `JSONAPI::Utils`](https://github.com/tiagopog/jsonapi-utils/pull/90), Your controller action would look like:

```ruby
class MyApiController < ApplicationController
  def index
    # to_unsafe_h is here in order to support any version of rails/other frameworks that just get a hash for params
    @results = MyModel.search_from_params( params.to_unsafe_h )
    jsonapi_render json: @results
  end
end
```

### Configuration

As mentioned earlier the config is assignment of a paginator class (required) and a range formatter class (optional)

#### Paginator


#### RangeFormatter

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gaorlov/elasticsearch_query. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ElasticsearchQuery project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gaorlov/elasticsearch_query/blob/master/CODE_OF_CONDUCT.md).
