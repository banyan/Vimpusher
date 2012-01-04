class PluginsController < ApplicationController
  def index
    @popular = Group.popular
    @recent  = Group.recent

    respond_to do |format|
      format.html
    end
  end

  def show
    @plugin = Plugin.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @plugin = Plugin.find(params[:id])
  end

  def update
    @plugin = Plugin.find(params[:id])

    respond_to do |format|
      if @plugin.update_attributes(params[:plugin])
        format.html { redirect_to @plugin, notice: 'Plugin was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @plugin.errors, status: :unprocessable_entity }
      end
    end
  end
end
