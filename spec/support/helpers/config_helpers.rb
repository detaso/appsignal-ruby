module ConfigHelpers
  def project_fixture_path
    File.expand_path(
      File.join(File.dirname(__FILE__), "../fixtures/projects/valid")
    )
  end
  module_function :project_fixture_path

  def rails_project_fixture_path
    File.expand_path(
      File.join(File.dirname(__FILE__), "../fixtures/projects/valid_with_rails_app")
    )
  end
  module_function :rails_project_fixture_path

  def project_fixture_config(
    env = "production",
    initial_config = {},
    logger = Appsignal.internal_logger
  )
    Appsignal::Config.new(
      project_fixture_path,
      env,
      initial_config,
      logger
    )
  end
  module_function :project_fixture_config, :project_fixture_path

  def start_agent(env: "production", options: {})
    env = "production" if env == :default
    env ||= "production"
    Appsignal.configure(env, :root_path => project_fixture_path) do |config|
      options.each do |option, value|
        config.send("#{option}=", value)
      end
    end
    Appsignal.start
  end

  def clear_integration_env_vars!
    ENV.delete("RAILS_ENV")
    ENV.delete("RACK_ENV")
    ENV.delete("PADRINO_ENV")
  end
end
