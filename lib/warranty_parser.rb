class WarrantyParser
  APPLE_WARRANTY_URL = URI('https://selfsolve.apple.com/wcResults.do')

  def initialize(args)
    @sn = args[:sn]
    @num = rand(10000..50000)
    @url = args[:url] || APPLE_WARRANTY_URL
    get_warranty
  end

  def success?
    !!@response
  end

  private

  def get_warranty
    begin
      @response = Net::HTTP.post_form(@url, { sn: @sn, num: @num })
    rescue Exception
      # log error
    end
  end
end