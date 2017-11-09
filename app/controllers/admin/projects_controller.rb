# frozen_string_literal: true

module Admin
  class ProjectsController < Admin::ApplicationController
    before_action :set_project, only: [:create, :edit, :delete]
    
    def create
    end

    def edit
    end

    def delete
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def resource_params
      permitted_attributes = dashboard.permitted_attributes + [{ account_ids: [] }]
      custom_params = params.require(:project).permit(permitted_attributes)
      custom_params[:account_ids].delete('') if custom_params[:account_ids].size > 1
      custom_params
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
