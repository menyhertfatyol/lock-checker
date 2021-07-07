namespace :db do
  namespace :data do
    desc "Cleans up doorlock information older than one day"
    task cleanup: :environment do
      Doorlock.delete_by("created_at < '#{1.day.ago}'")
    end
  end
end
