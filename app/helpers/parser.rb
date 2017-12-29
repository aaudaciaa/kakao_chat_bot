module Parser
  class Movie
    def naver
  		url = "http://movie.naver.com/movie/running/current.nhn?view=list&tab=normal&order=reserve"
  		movie_html = RestClient.get(url)
  		doc = Nokogiri::HTML(movie_html)

  		movie_title = Array.new
  		movie_info = Hash.new

  		doc.css("ul.lst_detail_t1 dt a").each do |title|
  			movie_title << title.text
  		end

		  doc.css("ul.lst_detail_t1 li").each do |movie|
  			movie_info[movie.css("dl dt.tit a").text] = {
  				url: movie.css("div.thumb img").attribute('src').to_s,
  				star: movie.css("dl.info_star span.num").text
  			}
  		end

  		sample_movie = movie_title.sample
  		return_text = sample_movie + " " + movie_info[sample_movie][:star]
  		cat_url = movie_info[sample_movie][:url]

      return [return_text, cat_url]
    end
  end

  class Animal
    def cat
      url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      cat_xml = RestClient.get(url)
      doc = Nokogiri::XML(cat_xml)
      cat_url = doc.xpath("//url").text
      return_text = "고양이 사진이요ㅎㅎ"

      return [return_text, cat_url]
    end

    def dog
      url = "https://dog.ceo/api/breeds/image/random"
      doc = RestClient.get(url)
      info = JSON.parse(doc)
      dog_url = info["message"]
      return_text = "강아지 사진이요ㅋㅋ"

      return [return_text, dog_url]
    end
  end
end
