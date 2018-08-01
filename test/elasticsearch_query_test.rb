require "test_helper"

class ElasticsearchQueryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ElasticsearchQuery::VERSION
  end

  def test_accepts_params
    q = ElasticsearchQuery.from_params( {} )
    assert q
  end

  def test_to_hash
    q = ElasticsearchQuery.from_params( {} )
    assert_equal Hash, q.to_hash.class
  end

  def test_indifferent_acess
    q = ElasticsearchQuery.from_params( Params.new( { "filter" => { "key" => "value" } } ) )
    assert_equal( { query: { match: { "key" => "value" } }, size: 20, from: 0 }, q.to_hash )
  end

  def test_single_match_filter
    q = ElasticsearchQuery.from_params( { filter: { key: "value" } } )
    assert_equal( { query: { match: { key: "value" } }, size: 20, from: 0 }, q.to_hash )
  end

  def test_multiple_match_filters
    q = ElasticsearchQuery.from_params( { filter: { key: "value", other_key: "other_value" } } )
    assert_equal( { query: { bool: { must: [ { match: { key: "value" } }, { match: { other_key: "other_value" } } ] } }, size: 20, from: 0 }, q.to_hash )
  end

  def test_single_range_filter
    q = ElasticsearchQuery.from_params( { filter: { key: "beginning..end" } } )
    assert_equal( { query: { range: { key: { gte: "beginning", lt: "end" } } }, size: 20, from: 0 }, q.to_hash )
  end

  def test_multiple_range_filters
    q = ElasticsearchQuery.from_params( { filter: { key: "beginning..end", up_to: "neginf..end", from: "beginning..inf", all_of_it: "neginf..inf" } } )
    assert_equal( { query: { bool: { must: [ { range: { key: { gte: "beginning", lt: "end" } } },
                                             { range: { up_to: { lt: "end" } } },
                                             { range: { from: { gte: "beginning" } } } ] } }, size: 20, from: 0 }, q.to_hash )
  end

  def test_mixed_filters
    q = ElasticsearchQuery.from_params( { filter: { key: "value", other_key: "beginning..end" } } )
    assert_equal( { query: { bool: { must: [ { match: { key: "value" } }, { range: { other_key: { gte: "beginning", lt: "end" } } } ] } }, size: 20, from: 0 }, q.to_hash )
  end

  def test_desc_sort
    q = ElasticsearchQuery.from_params( { filter: { key: "value" }, sort: "some_field" } )
    assert_equal( { query: { match: { key: "value" } }, sort: { "some_field" => :asc }, size: 20, from: 0 }, q.to_hash )
  end
  
  def test_asc_sort
    q = ElasticsearchQuery.from_params( { filter: { key: "value" }, sort: "-some_field" } )
    assert_equal( { query: { match: { key: "value" } }, sort: { "some_field" => :desc }, size: 20, from: 0 }, q.to_hash )
  end

  def test_compound_sort
    q = ElasticsearchQuery.from_params( { filter: { key: "value" }, sort: "field,-other_field" } )
    assert_equal( { query: { match: { key: "value" } }, sort: [ { "field" => :asc }, { "other_field" => :desc } ], size: 20, from: 0 }, q.to_hash )
  end

  def test_pagination
    q = ElasticsearchQuery.from_params( { page: { limit: 150, offset: 15 } } )
    assert_equal( { query: { bool: { must: [ ] } }, size: 150, from: 15 }, q.to_hash )
  end

  def test_count_query_is_only_query
    q = ElasticsearchQuery.from_params( { filter: { key: "value" }, sort: "field,-other_field" } )
    assert_equal( { query: { match: { key: "value" } } }, q.to_count_hash )
  end
end
