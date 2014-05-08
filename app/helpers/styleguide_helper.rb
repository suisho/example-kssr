module StyleguideHelper

  def menu_list(sepalator=".")
    styleguide.sections.keys.map{ |s|
      s.split(sepalator).first
    }.uniq
  end

  def start_with_sections(section)
    styleguide.sections.keys.select{ |s|
      s.downcase.start_with?(section.downcase)
    }
  end

  def section_modifiers(section)
    styleguide.section(section).modifiers.map{ |m|
      m.class_name
    }
  end

  # show section with parent modifier
  def styleguide_extend_block(section, parent, &block)
    block_html = capture(&block)
    content =  section_modifiers(parent).map{ |m|
      block_html.gsub("$modifier_class", m +" $modifier_class").strip
    }.join("\n")
    @section = styleguide.section(section)
    render 'kss/shared/styleguide_block', :section => @section, :example_html => content
  end


end
