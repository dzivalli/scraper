require 'spec_helper'

describe WarrantyParser do
  let(:sn_on_warranty) { '013977000323877' }
  let(:sn_out_of_warranty) { '013896000639712' }
  let(:sn_unreal) { '12312312312' }

  describe '.success?' do
    it 'returns true if site is available' do
      expect(WarrantyParser.new(sn: sn_on_warranty).success?).to be_truthy
    end

    it 'returns false if site is unavailable' do
      expect(WarrantyParser.new(sn: sn_on_warranty, url: 'http://localhost:234234').success?).to be_falsey
    end
  end

  describe '.status' do
    it 'returns In Warranty if device is on warranty' do
      expect(WarrantyParser.new(sn: sn_on_warranty).status).to eq [true, 'In Warranty']
    end

    it 'returns Out Of Warranty if warranty is expired' do
      expect(WarrantyParser.new(sn: sn_out_of_warranty).status).to eq [true, 'Out Of Warranty']
    end

    it 'returns an error message if serial number cannot be found' do
      status = WarrantyParser.new(sn: sn_unreal).status

      expect(status[0]).to be_falsey
      expect(status[1]).to match('Please verify the number and try again')
    end

    it 'returns false if site is unavailable' do
      expect(WarrantyParser.new(sn: sn_on_warranty, url: 'http://localhost:234234').status).to be_falsey
    end
  end

  describe '.date' do
    it 'returns estimated expiration date' do
      expect(WarrantyParser.new(sn: sn_on_warranty).date).to eq 'August 10, 2016'
    end

    it 'returns false if site is unavailable' do
      expect(WarrantyParser.new(sn: sn_on_warranty, url: 'http://localhost:234234').date).to be_falsey
    end
  end
end