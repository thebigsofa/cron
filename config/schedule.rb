# frozen_string_literal: true

require "whenever"

env :TORII_URL,ENV['TORII_URL']
env :PATH, '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/bundle/bin'
env :GEM_PATH, '/usr/local/bundle' # defines where to find rake command
set :output, '/var/log/cron.log' # log location


# We override rake job type, as we don't want envrinoment specific task
job_type :rake, "cd :path && bundle exec rake :task --silent :output"

# REGULAR

every 1.minutes do
  rake "bigsofa:set_logout_times", environment: "development"
end

every 30.minutes, roles: [:primary] do
  rake "bigsofa:set_logout_times"
end

every 2.hours, roles: [:primary] do
  rake "bigsofa:retrieve_all_awaiting_transcripts"
end

# HOURLY

every :hour, roles: [:primary] do
  rake "bigsofa:retrieve_new_camera_tag_videos"
end

# DAILY

every 1.day, at: "10:05 pm", roles: [:primary] do
  rake "bigsofa:notification_cleanup"
end

every 1.day, at: "11:05 pm", roles: [:primary] do
  rake "bigsofa:session_garbage_collector"
end

every 1.day, at: "1:05 am", roles: [:primary] do
  rake "bigsofa:database_check_up", timeout: "90m"
end

every 1.day, at: "1:35 am", roles: [:primary] do
  rake "bigsofa:account_cleanup"
end

every 1.day, at: "2:05 am", roles: [:primary] do
  rake "bigsofa:version_cleanup"
end

every 1.day, at: "3:05 am", roles: [:primary] do
  rake "bigsofa:reindex_projects"
end

every 1.day, at: "4:05 am", roles: [:primary] do
  rake "bigsofa:reindex_search"
end

every 1.day, at: "5:05 am", roles: [:app] do
  rake "bigsofa:background_images"
end

every 1.day, at: "5:10 am", roles: [:primary] do
  rake "bigsofa:sweep_screened_media"
end

every 2.hours, roles: [:primary] do
  rake "bigsofa:sweep_expired_downloads"
end
