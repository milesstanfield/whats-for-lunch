namespace :heroku do
  desc "deploy to production"
  task :push_to_production => :environment do
    Bundler.with_clean_env do
      branches = `git branch`
      current_branch = branches.split("* ")[1].split[0]

      if current_branch == "master"
        puts "BE CAREFUL!!! YOU ARE ABOUT TO PUSH TO PRODUCTION!"
        puts "do you wish to continue? y/n"
        response = STDIN.gets.chomp

        if response == "y"
          puts "pushing to production ..."
          system "git pull --rebase origin master && git push origin master && git push heroku master && heroku run rake db:migrate && heroku open"
        else
          puts "did nothing"
        end
      else
        puts "you must be on the master branch in order to push to production"
      end
    end
  end
end
