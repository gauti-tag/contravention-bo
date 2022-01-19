class MainController < ApplicationController
  
  def index
    @agents = Agent.count
    @notebooks = ContraventionNotebook.count
  end

  def audit
    @logs = AuditLog.order(created_at: :desc)
  end

  def show_log
    @log = AuditLog.find_by(identifier: params[:id])
  end
end