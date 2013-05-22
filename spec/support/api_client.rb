module ApiClient
  def init_api_data
    @status = response.status
    data = ActiveSupport::JSON.decode(response.body)
    if data.is_a?Hash
      data = HashWithIndifferentAccess.new(data)
    elsif data.is_a?Array
      tmps = []
      data.each { |hash| tmps << HashWithIndifferentAccess.new(hash) }
      data = tmps
    end
    data
  end

  def request_api(method, path, querys = {}, request_env = {})
    send(method, path, querys, request_env)
    @status = response.status
    data = ActiveSupport::JSON.decode(response.body)
    if data.is_a?(Hash)
      HashWithIndifferentAccess.new(data)
    elsif data.is_a?(Array)
      data.map{ |hash| HashWithIndifferentAccess.new(hash) }
    else
      data
    end
  end
end