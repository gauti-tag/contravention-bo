require 'rails_helper'
require_relative '../support/devise'

RSpec.describe "Main management", type: :request do

  context "from login admin user" do
    login_admin
    
    describe 'GET main#index' do

      it 'should render a successful response' do
        get root_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end

    end

    describe 'GET main#audit' do
      it 'should render a successful response' do
        create_list(:audit_log, 10)
        get audit_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:logs)).to eq(AuditLog.order(created_at: :desc))
        expect(response).to render_template(:audit)
      end
    end

    describe 'GET main#show_log' do
      let(:log) { create(:audit_log) }
      it 'should render a successful response' do
        get audit_log_path(id: log.identifier)
        expect(response).to have_http_status(:ok)
        expect(assigns(:log)).to eq(log)
        expect(response).to render_template(:show_log)
      end
    end

  end

end