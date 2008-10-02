namespace :radiant do
  namespace :extensions do
    namespace :banner_rotator do
      
      desc "Runs the migration of the Banner Rotator extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          BannerRotatorExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          BannerRotatorExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Banner Rotator to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[BannerRotatorExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(BannerRotatorExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end
      
    end
  end
end
