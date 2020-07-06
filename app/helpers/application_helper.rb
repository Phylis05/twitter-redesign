module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.username.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar')
  end

  def like_or_dislike_btn(review)
    like = Like.find_by(review: review, user: current_user)
    if like
      link_to('Dislike', review_like_path(id: like.id, review_id: review.id), method: :delete)
    else
      link_to('Like', review_likes_path(review_id: review.id), method: :review)
    end
  end

  def current_user_following?(user)
    return nil unless current_user.id != @user.id

    if current_user.following?(user)

      link_to followings_path,  { controller: 'followings', action: 'destroy', user_id: @user.id },
                { method: :delete, class: 'fas fa-minus-circle fa-2x ml-2' }
    else
      link_to followings_path, { controller: 'followings', action: 'create', user_id: @user.id },
                { method: :post, class: 'fas fa-plus-circle fa-2x ml-2' }

    end
  end

  def current_user_gravatar(user)
    if user[:Photo].nil?
      gravatar_for user, size: 60
      
    else
      image_tag user.Photo.thumb.url
    end
  end
end
