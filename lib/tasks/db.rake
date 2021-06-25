namespace :db do
  namespace :data do
    desc "Cleans up doorlock information older than one day"
    task cleanup: :environment do
      Doorlock.delete_by("created_at < '#{Time.now - 1.day}'")
    end
