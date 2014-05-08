module StyleguideHelper
=begin
  include Kss::ApplicationHelper
  def styleguide_block_with_rescue(section, &block)
    begin
      styleguide_block_without_rescue(section, &block)
    rescue ArgumentError => e
    end
  end
  alias_method_chain :styleguide_block , :rescue
=end

  def menu_list
    styleguide.sections.keys.map{ |section|
      section.split(".").first
    }.uniq
  end

end
