# frozen_string_literal: true

return unless Rails.env.development?

namespace :rails_graphql_api do
  desc 'Bootstrap a fresh copy of the app'
  task :setup, [:app_name] => :environment do |_task, args|
    if args.app_name.blank?
      puts 'Rake aborted!'
      puts 'Provide an application name to the rake task'
      puts '-> rails rails_graphql_api:setup[new_app_name]'
      next
    end

    def change_in_file(file_path, old_content, new_content)
      return unless File.exist?(file_path)

      puts "updating #{file_path.basename.to_s}"

      app_file_contents = File.read(file_path)
      new_app_file_contents = app_file_contents.gsub(old_content, new_content)

      File.open(file_path, 'w') { |file| file.puts(new_app_file_contents) }

      puts "  -> changed #{old_content} to #{new_content}"
      puts ''
    end

    ## Assign the app name in two formats
    ###########################################
    app_name_underscored = args.app_name.parameterize(separator: '_').underscore
    app_name_classified  = app_name_underscored.classify

    ## Files
    ###########################################
    app_config   = Rails.root.join('config/application.rb')
    db_config    = Rails.root.join('config/database.yml')
    cable_config = Rails.root.join('config/cable.yml')
    prod_config  = Rails.root.join('config/environments/production.rb')

    ## Update contents of the files
    ###########################################
    change_in_file(app_config, 'RailsGraphqlApiTemplate', app_name_classified)
    change_in_file(db_config, 'RAILS_GRAPHQL_API_TEMPLATE', app_name_underscored.upcase)
    change_in_file(db_config, 'rails_graphql_api_template', app_name_underscored)
    change_in_file(cable_config, 'rails_graphql_api_template', app_name_underscored)
    change_in_file(prod_config, 'rails_graphql_api_template', app_name_underscored)
  end
end
