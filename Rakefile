require "sinatra"
require "excon"
require "uri"
require "logger"

# frozen_string_literal: true





namespace :bigsofa do
  desc "prints hello world"
  task :print_hello_world do
    puts "hello world"
  end

  desc "checks for invalid records"
  task :database_check_up do
    send_task(build_body("bigsofa:database_check_up"))
  end

  desc "Re-indexes all elastic search indexes"
  task :reindex_search do
    send_task(build_body("bigsofa:reindex_search"))
  end

  desc "Reindex projects with homepages if the project has changed"
  task :reindex_projects do
    send_task(build_body("bigsofa:reindex_projects"))
  end

  desc "Gets (attempts to get) all transcripts from external services"
  task :retrieve_all_awaiting_transcripts do
    send_task(build_body("bigsofa:retrieve_all_awaiting_transcripts"))
  end

  desc "Sets user logout times"
  task :set_logout_times do
    send_task(build_body("bigsofa:set_logout_times"))
  end

  desc "Re-indexes all BST models"
  task :bst_reindex do
    send_task(build_body("bigsofa:bst_reindex"))
  end

  desc "rotate background images daily"
  task :background_images do
    send_task(build_body("bigsofa:background_images"))
  end

  desc "garbage collect old sessions"
  task :session_garbage_collector do
    send_task(build_body("bigsofa:session_garbage_collector"))
  end

  desc "Accounts can be orphaned if their accountable is deleted manually, this process cleans them up"
  task :account_cleanup do
    send_task(build_body("bigsofa:account_cleanup"))
  end

  desc "Cleanup Versions"
  task :version_cleanup do
    send_task(build_body("bigsofa:version_cleanup"))
  end

  desc "Cleanup Norifications"
  task :notification_cleanup do
    send_task(build_body("bigsofa:notification_cleanup"))
  end

  desc "Retrieve camera tag videos"
  task :retrieve_new_camera_tag_videos do
    send_task(build_body("bigsofa:retrieve_new_camera_tag_videos"))
  end

  desc "Delete Media screened out 60 days or earlier relatively to cureent date"
  task :sweep_screened_media do
    send_task(build_body("bigsofa:sweep_screened_media"))
  end

  desc "Delete expired Downloads"
  task :sweep_expired_downloads do
    send_task(build_body("bigsofa:sweep_expired_downloads"))
  end

  desc "Seed Basic Data for Test Cafe"
  task :test_cafe_seed do
    send_task(build_body("bigsofa:test_cafe_seed"))
  end

  desc "Seed Basic Data for Integration"
  task :integration_seed do
    send_task(build_body("bigsofa:integration_seed"))
  end

  desc "Compete reset for development"
  task :clean_start do
    send_task(build_body("bigsofa:clean_start"))
  end
end

def build_body(task)
  URI.encode_www_form(
    payload: task,
    queue: "platform.cron",
  )
end

def send_task(body)

  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO
  logger.info("Sending #{body}")

  Excon.post(
   ENV["TORII_URL"],
   headers: { "Content-Type" => "application/x-www-form-urlencoded" },
   body: body
  )
end
