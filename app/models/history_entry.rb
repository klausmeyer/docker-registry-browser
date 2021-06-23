class HistoryEntry
  include ActiveModel::Model

  attr_accessor :created, :comment, :created_by

  def initialize(attrs = {})
    self.created    = Time.parse(attrs['created']) rescue nil
    self.comment    = attrs['comment']
    self.created_by = attrs['created_by']
  end

  def to_s
    "[#{created}] #{created_by || comment}"
  end
end
