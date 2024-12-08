require "redis"
require "minitest/autorun"

# 6379 for official redis, 6380 for ours
SERVER_PORT = ENV["SERVER_PORT"]

class TestRedisServer < Minitest::Test
  def test_responds_to_ping
    r = Redis.new(port: SERVER_PORT)
    assert_equal "PONG", r.ping
  end
end