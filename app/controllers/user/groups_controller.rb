class User::GroupsController < ApplicationController
  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @groups = Group.all
    if @group.save
      @current_user.groups << Group.find(@group.id)
      @current_user.save
      redirect_to user_groups_path, notice: "新しいグループを作成しました" 
    else 
      render :index
    end
  end

  def update 
    @group = Group.find(params[:id])
    if @group.update(group_params)
      @group.save
      redirect_to user_groups_path, notice: "グループを編集しました"
    else 
      render :edit
    end
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.includes(:groups).where('groups.id' => @group.id)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to user_groups_path, notice: "グループを削除しました"
  end

  private 
  def group_params
     params.require(:group).permit(:name, { :user_ids => [] })
  end  
end
