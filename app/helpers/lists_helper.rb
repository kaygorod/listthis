module ListsHelper
  def authors_items

    @user_items = @list.items.group(:user_id)

  end

end
