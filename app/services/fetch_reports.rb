class FetchReports < FetchRecords
  
  def dataset_endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/reports"
  end

end