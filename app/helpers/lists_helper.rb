module ListsHelper
  def authors_items
    Item.where("list_id = ?", @list.id).select("user_id").group("user_id")

  end

end
