class Client

  attr_reader :delay, :throw_error, :name

  class << self
    def slow_client = Client.new(name: "slow_client", delay: -> {3})
    def variable_client = Client.new(name: "variable_client", delay: -> {rand(0.25..1.5)})
    def fast_client = Client.new(name: "fast_client", delay: -> {0.25})
    def error_client = Client.new(name: "error_client", delay: -> {0.5}, throw_error: true)
  end

  def call
    puts "#{name}: Starting"
    latency = delay.call
    sleep(latency)
    raise "error" if throw_error
    puts "#{name} response after #{latency} seconds"
  end

  private

  def initialize(delay:, name:, throw_error: false)
    @delay = delay
    @throw_error = throw_error
    @name = name
  end
end
