ConnectionPool.new(size: 5, timeout: 3) {Redis.new({:host => 'localhost', :port => 6379, :db => 1, :timeout => 240})}
 

