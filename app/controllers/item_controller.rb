class ItemController < ApplicationController

  def index
    @items = Item.all
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new
    @item.title = params[:item][:title]
    @item.category = params[:item][:category]
    @item.description = params[:item][:description]
    @item.price = params[:item][:price]
    @item.save
    redirect_to root_path
  end
def show
end

def edit
  @item = Item.find(params[:id])
	render :new
end
end
