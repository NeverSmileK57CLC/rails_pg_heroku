# config/deploy.rb
set :app_name, "puma-test-app"
set :user, "puma-test-user"

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    run "cd #{current_path} && #{sudo} foreman export upstart /etc/init -a #{app_name} -u #{user} -l /var/#{app_name}/log"
  end

  desc "Start the application services"
  task :start, :roles => :app do
    run "#{sudo} service #{app_name} start"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    run "#{sudo} service #{app_name} stop"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "#{sudo} service #{app_name} start || #{sudo} service #{app_name} restart"
  end
end
