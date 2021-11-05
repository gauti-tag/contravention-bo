class FetchExportData< FetchRecords

  def dataset_endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/dataset/export"
  end

end