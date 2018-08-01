# ElasticsearchQuery

`ElasticsearchQuery` is a tranformer from [`JSONAPI`](http://jsonapi.org) style params hash into an [`Elasticseatch-ruby`](https://github.com/elastic/elasticsearch-ruby)-compatible object that can easily be fed into `client.search`

*Note*: This gem was written for use with a [modified](https://github.com/tiagopog/jsonapi-utils/pull/90) [`JSONAPI::Utils`](https://github.com/tiagopog/jsonapi-utils/) and uses several concepts from it (Paginator interface, param structure), but has no hard dependencies.

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

Using the gem is pretty strightforward. You have to set up 2 things: the paginator, and the range parser (if your API accepts range filters)

*NOTE*: This gem assumes that params come in the form of
```ruby
{
  filter: { key: :value },
  sort: :sort_value
}.merge( your_pagination_format_here )
```

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

```ruby
# in your config/initializers/elasticsearch_query.rb
ElasticsearchQuery::Query.paginator_class = MyPaginator
ElasticsearchQuery::FilterFormatter::Range.parser = MyRangeParser
```

#### Paginator

Most APIs want paged results. But since your interface is your own and not super relevant to how the query is contructed, it needs to duck the following type:

```ruby
class MyPaginator
  def initialize( params )
    @params = params
  end

  def to_hash
    { size: size,
      from: from }
  end
end
```

What the params look like and how you extract the page size and offset(`from`) are up to you. 

#### RangeFormatter

If your API has values that are filterable by range (e.g. `created_at`) `ElasticsearchQuery` can supprt those values; all you have to do is set up how to parse the parameter.

```ruby
class MyRangeParser
  def initialize( value )
    @value = value
  end

  # if your values come in as beginning-to-end for some reason
  def parse
    value.split "-to-"
  end
end
```

The result of `MyRangeParser#parse` method **MUST** respond to `#first` and `#last`, so things like `Array` and `Range` are great things to return, but if yoiu want to roll your own, have at it.

*Note*: This gem assumes that infinity and negative infinity are represented as `inf` and `neginf`. 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gaorlov/elasticsearch_query. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ElasticsearchQuery project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gaorlov/elasticsearch_query/blob/master/CODE_OF_CONDUCT.md).
