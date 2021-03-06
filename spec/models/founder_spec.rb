# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Founder, type: :model do
  describe 'Founder' do
    let(:project) { build(:project) }
    let(:user) { create(:user) }
    let(:account) { create(:account) }

    let(:valid_data_with_user) do
      {
        project: project,
        role: 'leader',
        member_type: User,
        member_id: user.id
      }
    end

    let(:valid_data_with_account) do
      {
        project: project,
        role: 'ambassador',
        member_type: Account,
        member_id: account.id
      }
    end

    it 'can be created with valid data using User as member' do
      founder = Founder.new(valid_data_with_user)

      expect(founder.save).to eq(true)
    end

    it 'can not be created with invalid data (no role)' do
      founder = Founder.new(valid_data_with_user)
      founder.role = nil

      expect(founder.save).to eq(false)
      expect(founder.errors.messages[:role].first).to eq("can't be blank")
    end

    it 'can not be created with invalid data (no project)' do
      founder = Founder.new(valid_data_with_user)
      founder.project = nil

      expect(founder.save).to eq(false)
      expect(founder.errors.messages[:project].first).to eq('must exist')
    end

    it 'can not be created with invalid data (no user)' do
      founder = Founder.new(valid_data_with_user)
      founder.member_id = nil

      expect(founder.save).to eq(false)
      expect(founder.errors.messages[:member].first).to eq('must exist')
    end

    it 'can not be created with invalid data (no account)' do
      founder = Founder.new(valid_data_with_account)
      founder.member_id = nil

      expect(founder.save).to eq(false)
      expect(founder.errors.messages[:member].first).to eq('must exist')
    end

    it 'can not be created twice with the same data' do
      Founder.create!(valid_data_with_user)

      expect { Founder.create!(valid_data_with_user) }
        .to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Project has already been taken/)
    end

    it 'can be created with valid data using Account as member' do
      founder = Founder.new(valid_data_with_account)

      expect(founder.save).to eq(true)
    end

    it 'project will be assigned to correct user' do
      Founder.create(valid_data_with_user)
      expect(user.projects.first == project).to eq(true)
    end

    it 'project will be assigned to correct account' do
      Founder.create(valid_data_with_account)
      expect(account.projects.first == project).to eq(true)
    end
  end
end
