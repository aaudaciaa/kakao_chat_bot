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
    return_message = {
      message: {
        text: user_message
      }
    }

    # 로또
    if user_message == "로또"
      lotto = [1..45].sample(6)

      return_message = {
        message :{
          text: lotto
        }
      }

    # 메뉴추천

    # 다른 명령어가 들어왔을 때 => ㅠㅠ 알 수 없는 명령어 입니다 출력되게



    render json: return_message

  end
end
