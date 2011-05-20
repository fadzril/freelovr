class UsersController < ApplicationController
  def index
    @users = User.order('created_at ASC').paginate :page => params[:page], :per_page => 10
    @statistic = User.select("COUNT(1) as total, designation").order('COUNT(1) DESC').group("designation")
    @status = User.select("availability")

    respond_to do |format|
      format.html #index.html.haml
      format.xml { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html #new.html.erb
      format.xml { render :xml => @user }
    end
  end

  def show
    @user = User.find(params[:id])
    @rate = Rate.find_by_user_id(@user.id)

#    respond_to do |format|
#      format.html #show.html.haml
#      format.xml { render :xml => @user }
#    end

    render :layout => false
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(params[:user])
    @rate = @user.rates.create(params[:rate])

    respond_to do |format|
      if @user.save!
        format.html {
          redirect_to(user_path, :notice => 'Successfully Created!')
        }
      else
        format.html { render :action => 'new'}
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @rate = Rate.find_by_user_id(@user.id)

    p @rate
    p @user.rates.last

    if @user.update_attributes(params[:user])
      format.html { redirect_to(@user, :notice => 'Successfully Updated!') }
      head :ok
    else
      format.html { render :action => 'edit'}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def avatar
    @user = User.find(params[:id])
    send_file @user.avatar.path, :type => @user.avatar_content_type
  end

  def rate
    @user = User.find(params[:id])
    @user.rates
  end

end
