require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#managers' do
  let(:acting_manager) { FactoryGirl.create(:user, :manager) }

  subject(:manager_ability) { Ability.new(acting_manager) }

  describe 'on Manager' do
    let(:user) { FactoryGirl.create(:user) }

    it { is_expected.to be_able_to(:manage, acting_manager) }
    it { is_expected.to_not be_able_to(:manage, user) }
    it { is_expected.to_not be_able_to(:destroy, user) }
  end
end
