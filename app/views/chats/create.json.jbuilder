json.id      @chat.id
json.content @chat.content 
json.date    @chat.created_at.strftime("%Y/%m/%d %H:%M")
json.user_name @chat.user.name
json.image   @chat.image.url