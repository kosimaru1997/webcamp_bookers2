class RelationshipsController < ApplicationController
    
    def create
      follow = current_user.active_relationships.build(followed_id: params[:user_id])
      follow.save
      redirect_to request.referer
    end
    
    def destroy
      unfollow = current_user.active_relationships.find_by(followed_id: params[:user_id]).destroy
      unfollow.destroy
      redirect_to request.referer
    end
    
end
