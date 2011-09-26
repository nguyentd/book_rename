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
    myIsbn = ''
    begin      
      myIsbn = convert_isbn isbn      
    end


    mybook = Hash.new
    mybook['ISBN'] = myIsbn
    mybook['Title'] =  'null'
    mybook['Publisher'] = 'null'


    resp = req.find(myIsbn)

    resp['Item'].each do |item|
      mybook['ISBN'] = item['ASIN']
      mybook['Title'] =  item['ItemAttributes']['Title'].gsub(/#/,'Sharp').gsub(/C\+\+/,'Cpp').gsub(/[^\(\)\-\s\.\w]/,'')
      mybook['Publisher'] =  item['ItemAttributes']['Manufacturer'].gsub(/[\'\s]/,'.').gsub(/[^\.|\w]/,'')
    end
    mybook
  end

  def BookRename.get_file_name(mybook)
    [mybook['Publisher'], mybook['Title'], mybook['ISBN']].join('.')
  end  

  def BookRename.extract_isbn(filename)
    result = ""
    if filename =~ /(^|\D+)([\d\-]{9,}[\dX])\D*/
      result = $2
    end
    result.gsub(/\-/,'')
  end

  def BookRename.convert_isbn(isbn)
    case isbn.size
    when 10 then myIsbn = isbn[0..8]
    when 13 then myIsbn = isbn[/(?:^978|^290)*(.{9})\w/,1]
    else raise RuntimeError
    end
    
    if myIsbn.empty?
      raise RuntimeError
    end

    case ck = (11 - (myIsbn.split(//).zip((2..10).to_a.reverse).inject(0) {|s,n| s += n[0].to_i * n[1]} % 11))
    when 10 then myIsbn << "X"
    when 11 then myIsbn << "0"
    else myIsbn << ck.to_s
    end
  end

end

