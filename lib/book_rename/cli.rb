require 'thor'

module BookRename
  class CLI < Thor    
    desc "Say message", "Say somthing in concolse"
    def say(message)
      puts message
    end    
  end
end