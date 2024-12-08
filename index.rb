require_relative("server")

redisInstance = RedisServer.new(6380)

redisInstance.listen()
