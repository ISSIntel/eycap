Capistrano::Configuration.instance(:must_exist).load do

  namespace :resque do
    desc "After deploy:restart we want to restart the workers"
    task :restart, :roles => [:app], :only => {:resque => true} do
      run "monit restart all -g resque_#{application}"
    end
    
    desc "After update_code we want to symlink the resque.yml"
    task :symlink, :roles => [:app], :only => {:resque => true} do
      run "if [ -f #{shared_path}/config/resque.yml ]; then ln -nfs #{shared_path}/config/resque.yml #{latest_release}/config/resque.yml; fi"
    end
#    after "deploy:symlink_configs", "resque:symlink" add this to the deploy.rb file
  end 
  
end