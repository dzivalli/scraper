require 'spec_helper'

describe WarrantyParser do
  describe '.success?' do
    it 'returns false if site is unavailable' do
      expect(WarrantyParser.new(sn: '013977000323877', url: 'http://localhost:234234').success?).to be_falsey
    end

    it 'returns true if site is available' do
      expect(WarrantyParser.new(sn: '013977000323877').success?).to be_truthy
    end
  end
end