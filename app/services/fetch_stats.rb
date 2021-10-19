class FetchStats < FetchRecords
  
  def dataset_endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/loto/stats"
  end

end