module ApiRequestHelper
  def stub_api_request(config, path, body = nil)
    options = {
      :query => {
        :api_key => config[:push_api_key],
        :name => config[:name],
        :environment => config.respond_to?(:env) ? config.env : config[:environment],
        :hostname => config[:hostname],
        :gem_version => Appsignal::VERSION
      },
      :headers => {
        "Content-Type" => "application/json; charset=UTF-8"
      }
    }
    body = Appsignal::Utils::JSON.generate(body) if body.is_a? Hash
    options[:body] = body if body
    endpoint = config[:endpoint] || Appsignal::Config::DEFAULT_CONFIG[:endpoint]
    stub_request(:post, "#{endpoint}/1/#{path}").with(options)
  end
end
