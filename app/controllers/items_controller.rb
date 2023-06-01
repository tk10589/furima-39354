class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :move_to_new, only: :edit
  before_action :move_to_index, only: :edit

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_description, :category_id, :item_condition_id, :shipbase_id, :shiparea_id, :shipdate_id, :price).merge(user_id: current_user.id)
  end

  def move_to_new
    unless user_signed_in?
      redirect_to action: :new
    end
  end

  def move_to_index
    @item = Item.find(params[:id])
    unless @item.user.id == current_user.id
      redirect_to action: :index
    end
  end

end
