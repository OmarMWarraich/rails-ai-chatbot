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
class Chat < ApplicationRecord
  belongs_to :user

  attr_accessor :message

  def message=(message)
    self.history = { 'prompt' => message, 'history' => [] } if history.blank?

    messages = [
      { 'role' => 'system', 'content' => history['prompt'] }
    ]
    q_and_a.each do |question, answer|
      messages << { 'role' => 'user', 'content' => question }
      messages << { 'role' => 'assistant', 'content' => answer }
    end
    messages << { 'role' => 'user', 'content' => message } if messages.size > 1


    response_raw = client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages:,
        temperature: 0.7,
        max_tokens: 500,
        top_p: 1,
        frequency_penalty: 0.0,
        presence_penalty: 0.6
      }
    )


    self.history['history'] << response_raw

    Rails.logger.debug response_raw
    response = JSON.parse(response_raw.to_json, object_class: OpenStruct)

    self.q_and_a << [message, response.choices[0].message.content]
  end

  private

  def client
    OpenAI::Client.new
  end

end
