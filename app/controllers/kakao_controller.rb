class KakaoController < ApplicationController
  def keyboard # 최초의 사용자가
    home_keyboard = {
      type: "text" # :type => "text"  //  "type" => "text"
    }

    render json: home_keyboard
  end

  def message
  end
end
