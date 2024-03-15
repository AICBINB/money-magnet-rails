namespace :dev do
    desc 'Start development processes'
    task :start_server do
      procfile = File.read('Procfile.dev').split("\n")
  
      procfile.each do |line|
        process_name, command = line.split(':', 2)
        puts "Starting #{process_name}..."
        system(command)
      end
    end
  end