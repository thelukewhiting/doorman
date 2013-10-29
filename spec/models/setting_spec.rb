require 'spec_helper'

describe Setting do
  let(:setting) { Setting.create(user_id: 1,
      autounlock: false,
      message: "asdf",
      recipient: "+12345678900",
      unlock_digits: "0") }

  it 'should have a user_id' do
    setting.should respond_to(:user_id)
    setting.user_id.should == 1
  end

  it 'autounlock should be set' do
    setting.should respond_to(:autounlock)
    setting.autounlock.should == false
  end

  it 'should have a message' do
    setting.should respond_to(:message)
    setting.message.should == "asdf"
  end

  it 'should have a recipient' do
    setting.should respond_to(:recipient)
    setting.recipient.should == "+12345678900"
  end

  it 'should have unlock digits' do
    setting.should respond_to(:unlock_digits)
    setting.unlock_digits.should == "0"
  end

end