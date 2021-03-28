# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  name       :string
#  difficulty :string
#  condition  :text
#  direction  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_locations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
