require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#managers' do
  let(:acting_manager) { FactoryGirl.create(:user, :manager) }
  subject(:manager_ability) { Ability.new(acting_manager) }

#   # Define your ability tests thus;
#   describe 'on Manager' do
#     let(:manager) { FactoryGirl.create(manager) }
#
#     it { is_expected.to be_able_to(:index,   Manager) }
#     it { is_expected.to be_able_to(:show,    manager) }
#     it { is_expected.to be_able_to(:read,    manager) }
#     it { is_expected.to be_able_to(:new,     manager) }
#     it { is_expected.to be_able_to(:create,  manager) }
#     it { is_expected.to be_able_to(:edit,    manager) }
#     it { is_expected.to be_able_to(:update,  manager) }
#     it { is_expected.to be_able_to(:destroy, manager) }
#   end
#   # on Manager
end
