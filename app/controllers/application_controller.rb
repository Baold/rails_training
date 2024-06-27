class ApplicationController < ActionController::API
    require 'jwt'

    def encode_token(payload)
        JWT.encode(payload, 'RubyonRails')
    end

    def decoded_token
        header = request.headers['Authorization']
        if header
            token = header.split(" ")[1]
            begin
                JWT.decode(token, 'RubyonRails')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        @current_user ||= User.find(decoded_token[0]) if decoded_token
    end

    def logged_in?
        !!current_user
    end

    def require_user
        if !logged_in?
            render json: { error: "You must login first" }, status: :unauthorized
        end
    end

end

# before_action :authorized

#   def encode_token(payload)
#     JWT.encode(payload, 'ngaoJSToken') 
#   end

#   def decoded_token
#     header = request.headers['Authorization']
#     if header
#       token = header.split(" ")[0]
#       begin
#         JWT.decode(token, 'ngaoJSToken', true, algorithm: 'HS256')
#       rescue JWT::DecodeError
#         nil
#       end
#     end
#   end

#   def current_user
#     if decoded_token
#       user_id = decoded_token[0]['user_id']
#       @user = User.find_by!(id: user_id)
#     end
#   end

#   def authorized
#     unless !!current_user
#       render json: { message: 'Please log in' }, status: :unauthorized
#     end
#   end
# end