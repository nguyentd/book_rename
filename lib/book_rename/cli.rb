require 'thor'
require 'book_rename'
# require "FileUtils"

module BookRename
  class CLI < Thor    
    default_task :search
    # extend BookRename

    desc "search isbn", "Search book by isbn"
    def search(isbn)
      mybook =BookRename.find_book_by_isbn_10 isbn
      puts BookRename.get_file_name(mybook)
      mybook
    end    

    desc "extract_isbn filename", "Extract isbn from file name"
    def extract_isbn filename
      puts BookRename.extract_isbn filename
    end

    desc "list", ""
    def list()
      Dir.glob("*.*") { |filename| 
        puts filename        
      }
    end

    desc "rename path", "rename all pdf file in the path"
    def rename path='.'
      done_folder = 'done'
      Dir.chdir(path)
      if not File.directory?( done_folder)
        puts "creating directory \"#{done_folder}\""
        Dir.mkdir("done")
      end
      Dir.glob("*.pdf") { |filename| 
        isbn = BookRename.extract_isbn filename
        if isbn.length > 0
          mybook = BookRename.find_book_by_isbn_10 isbn
          newFileName = BookRename.get_file_name(mybook)
          puts newFileName
          newFileName = (done_folder + "/" + newFileName)
          File.rename(filename, newFileName)
        end
      }
      
      

    end

  end
end