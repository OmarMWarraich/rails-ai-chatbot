# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  history    :json
#  q_and_a    :string           default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_chats_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
