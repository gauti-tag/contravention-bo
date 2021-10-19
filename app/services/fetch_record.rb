class FetchRecord < FetchRecords

  def dataset_endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/admin/retrieve"
  end

end