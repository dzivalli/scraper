class WarrantyParser
  APPLE_WARRANTY_URL = URI('https://selfsolve.apple.com/wcResults.do')

  def initialize(args)
    @sn = args[:sn]
    @num = rand(10000..50000)
    @url = args[:url] || APPLE_WARRANTY_URL

    get_warranty
    @hw_info = @response.body.scan(/displayHWSupportInfo\((.*)\)/) if success?
  end

  def success?
    !!@response
  end

  def status
    return nil unless success?
    return check_errors if check_errors

    warranty_info
  end

  def date
    @hw_info[0][0].scan(/Estimated Expiration Date: (.*)<br/)[0][0] if success?
  end


  private

  def get_warranty
    begin
      @response = Net::HTTP.post_form(@url, { sn: @sn, num: @num })
    rescue Exception
      # logger.warn(Exception)
    end
  end

  def warranty_info
    if @hw_info
      msg = case @hw_info[0][0].split(',')[0]
              when 'true' then 'In Warranty'
              when 'false' then 'Out Of Warranty'
            end
      [true, msg]
    else
      'Parser error'
    end

  end

  def check_errors
    if @response.body.scan(/hasErrors = (.*)\;$/).last[0] == 'true'
      [false, @response.body.scan(/errorMsg = (.*)/).last[0]]
    end
  end
end