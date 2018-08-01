require "test_helper"

class ElasticsearchQueryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ElasticsearchQuery::VERSION
  end

  def test_can_parse_params
    q = ElasticsearchQuery.from_params( {} )
    assert q
  end

  def test_can_parse_params
    q = ElasticsearchQuery.from_params( {} )
    assert_equal Hash, q.to_hash.class
  end
end
