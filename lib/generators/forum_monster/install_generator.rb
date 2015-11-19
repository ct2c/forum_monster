require 'rails/generators'
require 'rails/generators/migration'

class ForumMonster::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  desc "Installs the ForumMonster Controllers, Models, Views, and Migrations."

  argument :user_model, :type => :string, :required => false, :default => "User", :desc => "Your user model name."

  attr_reader :singular_camel_case_name, :plural_camel_case_name, :singular_lower_case_name, :plural_lower_case_name

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_controllers
    template "controllers/forum_categories_controller.rb", "app/controllers/forum/forum_categories_controller.rb"
    template "controllers/forums_controller.rb", "app/controllers/forum/forums_controller.rb"
    template "controllers/topics_controller.rb", "app/controllers/forum/topics_controller.rb"
    template "controllers/posts_controller.rb", "app/controllers/forum/posts_controller.rb"
  end

  def create_models
    @singular_camel_case_name = user_model.singularize.camelize
    @plural_camel_case_name = user_model.pluralize.camelize
    @singular_lower_case_name = user_model.singularize.underscore
    @plural_lower_case_name = user_model.pluralize.underscore

  	template "models/forum_category.rb", "app/models/forum_related/forum_category.rb"
  	template "models/forum.rb", "app/models/forum_related/forum.rb"
    template "models/topic.rb", "app/models/forum_related/topic.rb"
    template "models/post.rb", "app/models/forum_related/post.rb"
  end

  def create_views
    directory "views/forum_categories", "app/views/forum/forum_categories"
    directory "views/forums", "app/views/forum/forums"
    directory "views/topics", "app/views/forum/topics"
    directory "views/posts", "app/views/forum/posts"
    directory "views/shared", "app/views/forum/shared"
    template  "public/stylesheets/forum-monster.css", "public/stylesheets/forum-monster.css"
    template  "public/images/ruby.png", "public/images/ruby.png"
  end

  def create_migrations
    migration_template 'migrations/forum_categories.rb', 'db/migrate/create_forum_categories_table.rb'
    migration_template 'migrations/forums.rb', 'db/migrate/create_forums_table.rb'
    migration_template 'migrations/topics.rb', 'db/migrate/create_topics_table.rb'
    migration_template 'migrations/posts.rb', 'db/migrate/create_posts_table.rb'
    migration_template 'migrations/user.rb', 'db/migrate/update_users_table.rb'
  end

  def create_routes
    route "resources :forum_categories, :except => [:index, :show], :module => 'forum'
      resources :forums, :module => 'forum', :except => :index do
      resources :topics, :shallow => true, :except => :index do
      resources :posts, :shallow => true, :except => [:index, :show]
    end
    root :to => 'forum_categories#index', :via => :get
  end"
  end

  def create_locales
    template "config/locales/forum_monster/en-forum.yml", "config/locales/forum_monster/en-forum.yml"
    template "config/locales/forum_monster/fr-forum.yml", "config/locales/forum_monster/fr-forum.yml"
  end

  def self.next_migration_number(path)
    unless @prev_migration_nr
      @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
      @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end
end
