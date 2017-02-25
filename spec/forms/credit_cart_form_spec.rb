require 'rails_helper'

def format_expiration_date(date)
  date.strftime(CreditCardForm::DATE_FORMAT)
end

RSpec.describe CreditCardForm do
  let(:attributes) do
    attrs = attributes_for(:credit_card)
    attrs[:expiration_date] = format_expiration_date(attrs[:expiration_date])
    attrs
  end

  subject { CreditCardForm.from_params(attributes) }

  describe 'expiration date' do
    it 'valid' do
      is_expected.to be_valid
    end

    it 'parse date from ##/## form' do
      subject.expiration_date = '02/18'
      is_expected.to be_valid
      date = subject.expiration_date
      expect(date.year).to  eq(2018)
      expect(date.month).to eq(2)
      expect(date.day).to   eq(1)
    end

    it 'is invalid if month is greater than 12' do
      subject.expiration_date = '13/18'
      is_expected.not_to be_valid
      expect(subject.expiration_date).to be nil
    end

    describe 'expiration validator' do
      it 'is invalid when in past' do
        subject.expiration_date = format_expiration_date(Time.current - 1.year)
        is_expected.not_to be_valid
      end
      it 'is valid when in future' do
        subject.expiration_date = format_expiration_date(Time.current + 1.year)
        is_expected.to be_valid
      end
    end
  end

  describe 'subject number' do
    it 'is invalid if number is not real' do
      subject.number = '1234 5678 8765 4321'
      expect(subject).not_to be_valid
    end
  end
end
