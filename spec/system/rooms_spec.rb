require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    sign_in(@room_user.user)
    click_on(@room_user.room.name)
    FactoryBot.create_list(:message, 5, user_id: @room_user.user.id, room_id: @room_user.room.id )
    expect{
      click_on('チャットを終了する')
    }.to change { @room_user.room.messages.count }.by(-5)
    expect(current_path).to eq(root_path)
  end  
end
