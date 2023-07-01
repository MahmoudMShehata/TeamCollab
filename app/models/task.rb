# frozen_string_literal: true

class Task < ApplicationRecord
  has_one_attached :attachment
  validates :title, presence: true
  validates :progress, presence: true

  belongs_to :task_pool
  has_and_belongs_to_many :users

  def self.task_types
    {
      "BugReport": 'bug_report',
      "FeatureRequest": 'feature_request',
      "MarketingCampaign": 'marketing_campaign'
    }
  end
end
