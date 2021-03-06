require 'parser'
require 'json'

class KakaoController < ApplicationController
  def keyboard
    # home_keyboard = {
    #   type: "text" # :type => "text"  //  "type" => "text"
    # }

    home_keyboard = {
      type: "buttons",
      buttons: ["영화", "고양이", "강아지", "메뉴", "로또", "코인"]
    }

    render json: home_keyboard
  end

  def message
    # 사용자가 보내준 텍스트를 그대로 다시 보내주기
    user_message = params[:content] #content에 사용자가 보낸 텍스트가 담겨있다.
    return_text = "임시 텍스트"
    image = false

    # home_keyboard = {
    #   type: "text" # :type => "text"  //  "type" => "text"
    # }

    home_keyboard = {
      type: "buttons",
      buttons: ["영화", "고양이", "강아지", "메뉴", "로또", "코인"]
    }

    # 로또
    if user_message == "로또"
      return_text = (1..45).to_a.sample(6).to_s

    # 메뉴추천
    elsif user_message == "메뉴"
      return_text = ["치킨", "피자", "햄버거", "라면", "짜장면", "20층"].sample(1).to_s

    # 고양이 사진 보여주기
    elsif user_message == "고양이"
      image = true
      cat_photo = Parser::Animal.new
      cat_info = cat_photo.cat

      return_text = cat_info[0]
      img_url = cat_info[1]

    # 강아지 사진 보여주기
    elsif user_message == "강아지"
      image = true
      dog_photo = Parser::Animal.new
      dog_info = dog_photo.dog

      return_text = dog_info[0]
      img_url = dog_info[1]

    # 영화 보여주기
    elsif user_message == "영화"
      image = true
      naver_movie = Parser::Movie.new
      naver_movie_info = naver_movie.naver

      return_text = naver_movie_info[0]
      img_url = naver_movie_info[1]

    elsif user_message == "코인"
      url = "https://api.coinnest.co.kr/api/pub/ticker?coin=tron"
      doc = RestClient.get(url)
      info = JSON.parse(doc)
      return_text = info["last"].to_s

    # 다른 명령어가 들어왔을 때 => ㅠㅠ 알 수 없는 명령어 입니다 출력되게
    else
      return_text = "ㅠㅠ 알 수 없는 명령어 입니다."
    end

    # return_message = {
    #   message: {
    #     text: user_message
    #   }
    # }

    return_message_with_img = {
      message: {
        text: return_text,
        photo: {
          url: img_url,
          width: 640,
          height: 480
        }
      },
      keyboard: home_keyboard
    }

    return_message = {
      message: {
        text: return_text
      },
      keyboard: home_keyboard
    }

    if image
      render json: return_message_with_img
    else
      render json: return_message
    end

  end
end
