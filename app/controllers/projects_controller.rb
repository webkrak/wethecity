# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = Project.active.order(sort_order: :asc).limit(20)
  end

  def search
    @projects = Project.search(params[:q])
    render :index
  end

  def show
    @project = Project.friendly.find(params[:id])
  end

  def new;
  end

  def create
    render plain: params[:article].inspect
  end
end
