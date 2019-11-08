class HistoryEntry
  include ActiveModel::Model

  attr_accessor :created, :created_by

  def initialize(attrs = {})
    self.created    = Time.parse(attrs['created']) rescue nil
    self.created_by = attrs['created_by']
  end

  def to_s
    "[#{created}] #{created_by}"
  end
end
