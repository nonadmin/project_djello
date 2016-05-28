class BoardsController < ApplicationController

  def index
    @boards = current_user.boards

    respond_to do |format|
      format.json { render json: @boards }
    end
  end

  def show
    @board = current_user.boards.find_by_id(params[:id])

    respond_to do |format|
      format.json { render json: @board }
    end
  end

  def create
    @board = Board.new(board_params)
    @board.members << current_user

    respond_to do |format|
      if @board && @board.save
        format.json { render json: @board }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def update
    @board = current_user.boards.find_by_id(params[:id])

    respond_to do |format|
      if @board && @board.update(board_params)
        format.json { render json: @board }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board = current_user.boards.find_by_id(params[:id])

    respond_to do |format|
      if @board && @board.destroy
        format.json { render json: @board }
      else
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  private


  def board_params
    if params[:board] && !params[:board].blank?
      params.require(:board).permit(:title)
    end
  end

end
