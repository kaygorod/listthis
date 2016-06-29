module ListsHelper
  def authors_items
    Item.where("list_id = ?", @list.id).group(:user_id)


  end

end
