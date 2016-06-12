json.(@board, :id, :updated_at, :title)

json.lists do
  json.array!(@board.lists) do |list|
    json.(list, :id, :created_at, :title, :description)

    json.cards do
      json.array!(list.cards) do |card|
        json.(card, :id, :title, :description)
      end
    end
  end
end