require "thor"

class Heroku < Thor
  include Thor::Actions

  desc "deploy", "Start Deployment"
  def deploy
    p "Deploying #{app}"
    run_clean "git push -f git@heroku.com:#{app}.git master:master"

    run_migrate

    restart_app

    p "Deployment finished for #{app}"
  end

  desc "c", "Start Rails Console"
  def c
    run_clean "heroku run rails c --app #{app}"
  end

  desc "console", "Start Rails Console"
  def console
    run_clean "heroku run rails c --app #{app}"
  end

  desc "logs", "Show Logs"
  option :n, type: :numeric, default: 300
  def logs
    run_clean "heroku logs -n #{options[:n]} -t --app #{app}"
  end

  desc "migrate", "Migrate Database"
  def migrate
    run_migrate
  end

  desc "restart", "Restart App"
  def restart
    restart_app
  end

  no_commands do
    private def run_migrate
      p "Migrate DB"
      run_clean "heroku maintenance:on --app #{app}"
      run_clean "heroku run rake db:migrate --app #{app}"
      run_clean "heroku maintenance:off --app #{app}"
    end

    private def restart_app
      p "Restart #{app}"
      run_clean "heroku restart --app #{app}"
    end

    private def app
      @app ||= "sor-2015-read-1"
    end

    private def run_clean(command)
      Bundler.with_clean_env { run(command) }
    end
  end
end
