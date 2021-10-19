class UpdateRecord < SaveRecord

  def endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/admin/update"
  end

end