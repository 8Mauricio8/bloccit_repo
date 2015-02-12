class PostPolicy < ApplicationPolicy

  class Scope < Scope
   attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present? && (user.admin? || user.moderator?)
        scope.all
      elsif user.present?
        scope.where(user: user)
      else
        raise Pundit::NotAuthorizedError.new("Naughty one! You must sing in in order to see posts")
      end
    end
  end


  
  
  
  
  def index?
    true
  end
 end 
 