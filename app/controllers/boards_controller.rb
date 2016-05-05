class BoardsController < ApplicationController

  def index
    @boards = current_user.boards

    respond_to do |format|
      format.json { render json: @boards.to_json }
    end
  end

  def show
    @board = current_user.boards.find_by_id(params[:id])

    respond_to do |format|
      format.json { render json: @board.to_json }
    end
  end

  def create
    @board = current_user.boards.new(board_params)

    respond_to do |format|
      if @board && @board.save
        format.json { render json: @board.to_json }
      else
        format.json { render nothing: true, status: :unprocessable_entry }
      end
    end
  end


  private

  def board_params
    if params[:board]
      params.require(:board).permit(:title)
    end
  end

end
