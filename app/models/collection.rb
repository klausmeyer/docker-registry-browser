class Collection
  include ActiveModel::Model
  include Enumerable

  attr_accessor :entries, :more

  delegate :each, to: :entries

  def last
    entries.last
  end

  def more?
    more
  end
end
