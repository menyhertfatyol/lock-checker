namespace :doorlock do
  desc 'Checks doorlock using hall sensor'
  task :check_state do
    Door.check_lock_state
  end
end
