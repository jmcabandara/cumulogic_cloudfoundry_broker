class String
  def is_integer?
    self.to_i.to_s == self
  end
end

module General

  def json(hash)
    MultiJson.dump(hash, pretty: true)
  end

  def parsed_params
    if request.get? || request.form_data?
      parsed = params
    else
      parsed = MultiJson.load(request.body, symbolize_keys: true)
    end

    parsed = {} unless parsed.is_a?(Hash)

    return parsed
  end

  def good_api_version(versionstring)
    verarr = versionstring.split(".")
    if verarr.length == 2 &&
      verarr[0].is_integer? &&
      verarr[1].is_integer? &&
      verarr[0].to_i == 2 &&
      verarr[1].to_i >= 0

      return true
    end
    halt 412, "{ 'description': 'Unknown API version provided in X-Broker-Api-Version header: #{versionstring}' }"
    return false
  end

end
