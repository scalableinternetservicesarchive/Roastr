json.extract! user, :id, :profile_pic, :username, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
