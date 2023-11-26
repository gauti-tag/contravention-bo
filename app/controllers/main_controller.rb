class MainController < ApplicationController
  
  def index
    @agents = Agent.count
    @notebooks = ContraventionNotebook.count
    @groups = ContraventionGroup.count
    @types = ContraventionType.count

    @data = DatatablesManager::FetchStats.call({model_name: 'ticket_payments'})['data']
  end

  def audit
    @logs = AuditLog.order(created_at: :desc)
  end

  def show_log
    @log = AuditLog.find_by(identifier: params[:id])
  end
end