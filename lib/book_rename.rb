require "book_rename/version"

module BookRename
  require "amazon_product"


  def BookRename.req
    @req ||= AmazonProduct["us"]
    @req.configure do |c|
      c.key    = "05Z3HTZN2GSB5ZYRXC02"
      c.secret = "DfS64S9trXsg8J0SQvvZKxwV+YSjzfao/4CdDDSV"
      c.tag    = "nosters-20"
    end
    @req
  end


  def BookRename.find_book_by_isbn_10 (isbn)    
    # resp = req.search('Books',:response_group => %w{ItemAttributes Images},
    #     :power => isbn)

    resp = req.find(isbn)
    mybook = Hash.new
    mybook['ISBN'] = isbn
    mybook['Title'] =  'null'
    mybook['Publisher'] = 'null'
    
    resp['Item'].each do |item|
      mybook['ISBN'] = item['ASIN']
      mybook['Title'] =  item['ItemAttributes']['Title'].gsub(/#/,'Sharp').gsub(/C\+\+/,'Cpp').gsub(/[^\(\)\-\s\.\w]/,'')
      mybook['Publisher'] =  item['ItemAttributes']['Manufacturer'].gsub(/[\'\s]/,'.').gsub(/[^\.|\w]/,'')
    end
    mybook
  end
  
  def BookRename.get_file_name(mybook)
    [mybook['Publisher'], mybook['Title'], mybook['ISBN'], 'pdf'].join('.')
  end  
  
  def BookRename.extract_isbn(filename)
    result = ""
    if filename =~ /(^|\D+)([\d\-]{9,}[\dX])\D*/
        result = $2
    end
    result.gsub(/\-/,'')
  end
  
end

