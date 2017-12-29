class KakaoController < ApplicationController
  def keyboard # 최초의 사용자가
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

    render json: return_message

  end
end
