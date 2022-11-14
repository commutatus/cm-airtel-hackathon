module CmAdmin::CustomHelper
  def chatbot_collection(_model, _ctx)
    ::Chatbot.all.map{|cb| [cb.name.titleize, cb.id]}
  end

  def user_id(_model, _ctx)
    Current.user.id
  end
end
  