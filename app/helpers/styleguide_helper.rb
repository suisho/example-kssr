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

  def section_modifiers(*sections)
    sections.flatten.map{ |section|
      styleguide.section(section).modifiers.map{ |m|
        m.class_name
      }
    }.flatten
  end

  # show section with parent modifier
  # ex
  # <%= styleguide_extend_block "Button.Pattern.Emphasis", "Button.Basic" do -%>
  # or if some parents
  # <%= styleguide_extend_block "Button.Pattern.Emphasis", "Button.Basic", "Button.Size" do -%>
  def styleguide_extend_block(section, *parents, &block)
    block_html = capture(&block)
    content =  section_modifiers(parents).map{ |m|
      block_html.gsub("$modifier_class", m +" $modifier_class").strip
    }.join("\n")
    @section = styleguide.section(section)
    render 'kss/shared/styleguide_block', :section => @section, :example_html => content
  end

  def markdown(text)
    @markdown ||= begin
      renderer = Redcarpet::Render::HTML.new
      @markdown = Redcarpet::Markdown.new(renderer)
    end
    @markdown.render(text).html_safe
  end

end
