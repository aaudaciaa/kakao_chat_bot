class KakaoController < ApplicationController
  def keyboard
    home_keyboard = {
      type: "text" # :type => "text"  //  "type" => "text"
    }

    render json: home_keyboard
  end

  def message
    # 사용자가 보내준 텍스트를 그대로 다시 보내주기
    user_message = params[:content] #content에 사용자가 보낸 텍스트가 담겨있다.
    return_text = "임시 텍스트"
    image = false

    home_keyboard = {
      type: "text" # :type => "text"  //  "type" => "text"
    }

    # 로또
    if user_message == "로또"
      return_text = (1..45).to_a.sample(6).to_s

    # 메뉴추천
    elsif user_message == "메뉴"
      return_text = ["치킨", "피자", "햄버거", "라면", "짜장면", "20층"].sample(1)

    elsif user_message == "고양이"
      # 고양이 사진 보여주기
      image = true
      url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      cat_xml = RestClient.get(url)
      doc = Nokogiri::XML(cat_xml)
      cat_url = doc.xpath("//url").text
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
          url: cat_url,
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
