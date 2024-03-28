require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    user_seller = FactoryBot.create(:user)
    user_buyer = FactoryBot.create(:user)
    item = FactoryBot.build(:item, user_id: user_seller.id)
    item.image.attach(io: File.open('app/assets/images/test.jpg'), filename: 'test.jpg')
    item.save
    @order_delivery = FactoryBot.build(:order_delivery, user_id: user_buyer.id, item_id: item.id)
  end

  describe '商品の購入' do
    context '購入できるとき' do
      it '全てのカラムにデータが存在すれば購入できる' do
        expect(@order_delivery).to be_valid
      end

      it 'building_nameが空でも購入できる' do
        @order_delivery.building_name = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '購入できないとき' do
      it 'postal_codeが空では購入できない' do
        @order_delivery.postal_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeにハイフンが含まれないと購入できない' do
        @order_delivery.postal_code = @order_delivery.postal_code.gsub("-", "")
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'postal_codeが半角数値でないと購入できない' do
        @order_delivery.postal_code = 'a00-0000'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが空では購入できない' do
        @order_delivery.prefecture_id = 0
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空では購入できない' do
        @order_delivery.municipality = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'house_numberが空では購入できない' do
        @order_delivery.house_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("House number can't be blank")
      end

      it 'telephone_numberが空では購入できない' do
        @order_delivery.telephone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Telephone number can't be blank")
      end

      it 'telephone_numberが半角数値でないと購入できない' do
        @order_delivery.telephone_number = 'a0000000000'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Telephone number is invalid. Only 10 or 11 numbers")
      end

      it 'telephone_numberが10桁未満では購入できない' do
        @order_delivery.telephone_number = @order_delivery.telephone_number.to_s.slice(0..-3)
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Telephone number is invalid. Only 10 or 11 numbers")
      end

      it 'telephone_numberが11桁を超えると購入できない' do
        @order_delivery.telephone_number = @order_delivery.telephone_number.to_s + "00"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Telephone number is invalid. Only 10 or 11 numbers")
      end
    end
  end
end
