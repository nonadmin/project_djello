class ListsController < ApplicationController
  respond_to :json
  before_action :find_board
  before_action :find_list, only: [:update, :destroy]


  def index
    respond_with @board.lists
  end


  def create
    if list = @board.lists.create
      respond_with list, location: nil
    else
      respond_with list.errors
    end
  end


  def update
    if @list.update(list_params)
      # HTTP spec says PUT should return 204 and nothing else
      # so respond_with needs some goofy options to force it to return
      # our updated object
      respond_with nil, json: @list
    else
      respond_with nil, json: @list.errors
    end
  end


  def destroy
    if @list.destroy
      respond_with nil
    else
      respond_with nil
    end
  end


  private


  def find_board
    unless @board = current_user.boards.find_by_id(params[:board_id])
      render nothing: true, status: :not_found
    end
  end


  def find_list
    unless @list = current_user.boards.try(:find_by_id, params[:board_id])
                               .lists.find_by_id(params[:id])
      render nothing: true, status: :not_found
    end
  end


  def list_params
    params.require(:list).permit(:title, :description)
  end

end
