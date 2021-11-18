class BaseService
  def self.call(*args)
    new(*args).call
  end

  def call
    raise 'Every service must implement a #call method!'
  end
end
