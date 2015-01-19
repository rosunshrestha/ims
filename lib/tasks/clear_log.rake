namespace :log do
  desc 'clear development.log file'
  task clear: :environment do
    #clear log file
    File.open('log/development.log', 'w') {|file| file.truncate(0) }
    p 'development.log file cleared successfully'
  end
end
