class MainController < ApplicationController
  
  def index
    @data = FetchStats.call(request: {target: 'dashboard'}).result.data
  end

  def audit
    @logs = AuditLog.order(created_at: :desc)
  end

  def show_log
    @log = AuditLog.find_by(identifier: params[:id])
  end
end