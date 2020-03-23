# The task assumes you have figaro application.yml config in Capistrano shared folder
# https://github.com/laserlemon/figaro

require 'sshkit'

namespace :db do
  desc "Backup your PostgreSQL database to ~/"
  task :dump_postgres do
    on roles(:db) do
      # @dbconf = dbconfig
      @dbconf = dbconfig
      dbuser = @dbconf.user
      dbname = "#{(@dbconf.path || "").split("/")[1]}"
      dbhost = @dbconf.host
      dbpass = @dbconf.password

      # # feel free to add required flags for pg_dump
      # # http://www.postgresql.org/docs/9.4/static/app-pgdump.html
      
      within '~/' do
        execute :pg_dump,
                "-W -U #{dbuser} -h #{dbhost} --format=plain --quote-all-identifiers",
                "#{dbname} > \"/home/rails/vcv/decidim/db-backups/decidim_backup_$(date +%F_%R).sql\"",
                interaction_handler: {
                  'Password: ' => "#{dbpass}\n"
                }
      end
    end
  end

  
  # extract password from figaro shared config file
  def dbconfig
    URI.parse(YAML::load(
      capture :cat, "#{shared_path}/config/application.yml"
    )['DATABASE_URL'])
  end

end