require "surak/version"
require "filewatcher"
require 'webrick'
require 'parallel'

class NonCachingFileHandler < WEBrick::HTTPServlet::FileHandler
  def prevent_caching(res)
    res['ETag']          = nil
    res['Last-Modified'] = Time.now + 100**4
    res['Cache-Control'] = 'no-store, no-cache, must-revalidate, post-check=0, pre-check=0'
    res['Pragma']        = 'no-cache'
    res['Expires']       = Time.now - 100**4
  end

  def do_GET(req, res)
    super
    prevent_caching(res)
  end

end

module Surak

  class Server
    attr_accessor :server
    def initialize(serving_directory_path: "./dist", mounting_point: "/", port: 3337)
      self.server = WEBrick::HTTPServer.new :Port => port
      server.mount mounting_point, NonCachingFileHandler , serving_directory_path
      trap('INT') { server.stop }
    end

    def start
      self.server.start
    end

  end

  class FileWatcherWrapper
    attr_accessor :files_to_monitor
    def initialize
      self.files_to_monitor = [
        'src',
        'surak.json'
      ]
      self.grunt
    end

    def grunt
      grunt_output = `grunt`
      puts "\n#{grunt_output}\n"
    end

    def start
      FileWatcher.new(self.files_to_monitor).watch() do |filename, event|
        if(event == :changed)
          puts "File updated: " + filename
        end
        if(event == :delete)
          puts "File deleted: " + filename
        end
        if(event == :new)
          puts "Added file: " + filename
        end
        self.grunt
      end
    end

  end

  def self.install
    `sudo npm install -g bower`
    `sudo npm install -g grunt`
  end

  def self.new(name)
    puts "creating new project: #{name}"
    gem_dir = Gem::Specification.find_by_name("surak").gem_dir
    template_dir = gem_dir + '/lib/template'
    if !File.exist?(name)
      `mkdir #{name}`
      `cp -a #{template_dir+"/."} #{name}/.`
      Dir.chdir(name) do
        `npm install`
        `bower install`
      end
    else
      puts "File/Folder already exists with name: #{name}"
    end
  end

  def self.start
    if File.exist?("surak.json")
      puts "In correct directory"

      monitor = surak::FileWatcherWrapper.new
      server = surak::Server.new

      monitor_l = lambda { monitor.start }
      server_l = lambda { server.start }
      processes = [monitor_l, server_l]

      Parallel.each(processes) {|process| process.call }
    else
      puts "You must be in the root directory of a surak project to run this."
      puts "You are currently in #{Dir.pwd}"
    end
  end



end
