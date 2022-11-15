module CmAdmin::CustomHelper
  def chatbot_collection(_model, _ctx)
    if Current.user.super_admin?
      ::Chatbot.all.map{|cb| [cb.name.titleize, cb.id]}
    else
      ::Chatbot.where(user: Current.user).map{|cb| [cb.name.titleize, cb.id]}
    end
  end

  def user_id(_model, _ctx)
    Current.user.id
  end
end
  