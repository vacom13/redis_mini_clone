require "redis"
require "minitest/autorun"

# 6379 for official redis, 6380 for ours
SERVER_PORT = 6380

class TestRedisServer < Minitest::Test
  def test_responds_to_ping
    r = Redis.new(port: SERVER_PORT)
    assert_equal "PONG", r.ping
  end

  def test_multiple_commands_from_same_client
    r = Redis.new(port: SERVER_PORT)

    # The Redis client re-connects on timeout by default, without_reconnect
    # prevents that.
    r.without_reconnect do
      assert_equal "PONG", r.ping
      assert_equal "PONG", r.ping
    end
  end

  def test_multiple_clients
    r1 = Redis.new(port: SERVER_PORT)
    r2 = Redis.new(port: SERVER_PORT)

    assert_equal "PONG", r1.ping
    assert_equal "PONG", r2.ping
  end
  
end