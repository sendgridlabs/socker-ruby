require 'hashie'
require 'httpclient'

require 'socker/version'
require 'socker/socker'

module Socker
  class << self
    def new(*args)
      Socker.new(*args)
    end
  end
end
