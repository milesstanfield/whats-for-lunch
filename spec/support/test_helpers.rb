module TestHelpers
  def it_has_attributes(*attributes)
    record = described_class.new
    attributes.each do |attribute|
      it "has #{attribute}" do
        expect{record.send(attribute)}.to_not raise_error
      end
    end
  end

  def login(email = 'user@example.com', password = 'password')
    visit '/users/sign_in'
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button 'Log in'
  end

  def fill_and_submit_new_restaurant_form(name = 'Chick-fil-a')
    fill_in 'restaurant_name', with: name
    click_button 'Create Restaurant'
  end
end
