require "socket"

class RedisServer
  def initialize(port)
    @server = TCPServer.new(port)
    @clients = []
  end

  def listen
    loop do
      fds_to_watch = [@server, *@clients]
      ready_to_read, _, _ = IO.select(fds_to_watch)
      ready_to_read.each do |ready|
        if ready == @server
          @clients << @server.accept
        
        else
          begin
            handle_client(ready)
            rescue Errno::EPIPE => e
              puts "Connection closed: #{e.message}"
            
            ensure
              @clients.delete(ready) if ready.closed?

            end

        end    
      end
    end
  end
 
  def handle_client(client)
    begin
      client.readpartial(1024)
    rescue EOFError => e 
        puts "End of file reached: #{e.message}"
    end
    client.write("+PONG\r\n")
  end
end