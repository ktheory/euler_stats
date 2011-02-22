class Problem < ActiveRecord::Base

  def self.crawl!
    agent = Mechanize.new
    start_page = agent.get 'http://projecteuler.net/index.php?section=problems'
    parse_page(start_page)
    # Use a hash for uniq page links
    other_pages = start_page.links_with(:href => /page/).inject({}){|hash,link| hash[link.href] ||= link; hash}
    other_pages.values.each {|link| parse_page(link.click) }
  end

  def self.parse_page(page)
    rows = page.search('table.bg_table tr')

    # Skip header row
    rows.shift

    rows.each do |row|
      cells = row.search('td')
      id, title, solved_by = cells[0..2].map{|c| c.content}
      puts "Found #{id}"
      problem = self.find_or_create_by_id(id)
      problem.update_attributes(:title => title, :solved_by => solved_by)
    end
  end

  def euler_url
    "http://projecteuler.net/index.php?section=problems&id=#{id}"
  end
end
