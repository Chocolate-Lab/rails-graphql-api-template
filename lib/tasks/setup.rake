# frozen_string_literal: true

return unless Rails.env.development?

# rubocop:disable Metrics/BlockLength
namespace :rails_graphql_api do
  desc 'Bootstrap a fresh copy of the app'
  task :setup, [:app_name] => :environment do |_task, args|
    if args.app_name.blank?
      puts 'Rake aborted!'
      puts 'Provide an application name to the rake task'
      puts '-> rails rails_graphql_api:setup[new_app_name]'
      next
    end

    def build_file_hash(path, old_content, new_content)
      { path:, old_content:, new_content: }
    end

    def full_file_path(file_path)
      Rails.root.join(file_path)
    end

    def file_exists?(short_path)
      File.exist?(full_file_path(file_path))
    end

    def copy_file(file_path, new_file_path)
      return unless file_exists?(file_path)
      return if file_exists?(new_file_path)

      File.copy(
        full_file_path(file_path),
        full_file_path(new_file_path)
      )
    end

    def rename_file(file_path, new_file_path)
      return unless file_exists?(file_path)

      File.rename(
        full_file_path(file_path),
        full_file_path(new_file_path)
      )
    end

    def change_in_file(file_path, old_content, new_content)
      file_path = full_file_path(file_path)

      return unless File.exist?(file_path)

      puts "updating #{file_path.basename}"

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

    ## Copy files
    ###########################################
    copy_file('.env.sample', '.env.local')

    ## Rename / Move files
    ###########################################
    rename_file(
      'app/graphql/rails_graphql_api_template_schema.rb',
      "app/graphql/#{app_name_underscored}_schema.rb"
    )

    rename_file(
      'spec/graphql/rails_graphql_api_template_schema_spec.rb',
      "spec/graphql/#{app_name_underscored}_schema_spec.rb"
    )

    ## File changes
    ###########################################
    file_changes = [
      build_file_hash(
        'config/application.rb',
        'RailsGraphqlApiTemplate',
        app_name_classified
      ),
      build_file_hash(
        'config/database.yml',
        'RAILS_GRAPHQL_API_TEMPLATE',
        app_name_underscored.upcase
      ),
      build_file_hash(
        '.devcontainer/docker-componse.yml',
        'rails_graphql_api_template',
        app_name_underscored
      ),
      build_file_hash(
        'config/cable.yml',
        'rails_graphql_api_template',
        app_name_underscored
      ),
      build_file_hash(
        'config/environments/production.rb',
        'rails_graphql_api_template',
        app_name_underscored
      ),
      build_file_hash(
        "app/graphql/#{app_name_underscored}_schema.rb",
        'RailsGraphqlApiTemplateSchema',
        "#{app_name_classified}Schema"
      ),
      build_file_hash(
        "spec/graphql/#{app_name_underscored}_schema_spec.rb",
        'RailsGraphqlApiTemplateSchema',
        "#{app_name_classified}Schema"
      ),
      build_file_hash(
        'spec/requests/graphql_spec.rb',
        'RailsGraphqlApiTemplateSchema',
        "#{app_name_classified}Schema"
      ),
      build_file_hash(
        'app/controllers/graphql_controller.rb',
        'RailsGraphqlApiTemplateSchema',
        "#{app_name_classified}Schema"
      )
    ]

    ## Update contents of the files
    ###########################################
    file_changes.each do |file_change|
      change_in_file(
        file_change[:path],
        file_change[:old_content],
        file_change[:new_content]
      )
    end
  end
end
# rubocop:enable Metrics/BlockLength
