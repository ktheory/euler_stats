class Problem < ActiveRecord::Base
  def self.crawl!
    agent = Mechanize.new
  end
end
