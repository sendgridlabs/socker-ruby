module Socker
  class Options < Hashie::Mash
    def initialize(*)
      deep_merge!(Hashie::Mash.new(defaults))
      super
    end

    def defaults
      {
        logger: Logger.new(STDOUT),
        host: 'socker.io'
      }
    end
  end

  class Error < RuntimeError
  end

  class Socker
    def initialize(cfg = {})
      @options = Options.new(cfg)

      if @options.account.nil?
        raise Error.new "Missing required account parameter"
      end

      if @options.secret.nil?
        raise Error.new "Missing required secret parameter"
      end

      @httpclient = HTTPClient.new
      @httpclient.connect_timeout = 5
      @httpclient.receive_timeout = 5
      @httpclient.ssl_config.ssl_version = :TLSv1_2
    end

    def authenticate(path, id)
      response = {
        :auth => Digest::SHA256.hexdigest(@options.secret + path + id)
      }
    end

    def publish(path, data)
      begin
        msg = {}
        msg['account_key'] = @options.account
        msg['secret'] = @options.secret
        msg['path'] = path
        msg['data'] = data
        resp = @httpclient.post("https://#{@options.host}/v1/publish", { :body => MultiJson.dump(msg) } )
        raise Error.new "server responded " + resp.status_code.to_s unless resp.status_code == 204
      rescue HTTPClient::BadResponseError => e
        raise Error.new e.to_s
      rescue HTTPClient::ConfigurationError => e
        raise Error.new e.to_s
      rescue HTTPClient::KeepAliveDisconnected => e
        raise Error.new e.to_s
      rescue HTTPClient::TimeoutError => e
        raise Error.new e.to_s
      end
    end

  end
end
