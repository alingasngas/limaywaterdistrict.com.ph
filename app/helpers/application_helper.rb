module ApplicationHelper

  def generate_breadcrumbs
    html = '<ol class="breadcrumb">' +
            '<li><a href='"#{admin_path}"'><span class="fa fa-home"></span> Dashboard</a></li>' +
            '<li><a href='"#{url_for(:controller => controller_name, :action => 'index')}"'>' + controller_name.capitalize + '</a></li>' +
            '<li class="active">' + action_name.capitalize + '</li>' +
            '</ol>'

    raw(html)
  end



  def build_navs
    nav_menu = content_tag :ul, id: 'main_nav', class: 'nav navbar-nav navbar-right' do
      sections + news_articles_menu + contact_menu
    end
    return nav_menu
  end

  def sections
    navs = []
    page_sections = Page.sections.order('display_order ASC')
    page_sections.collect {|section| navs << content_tag(:li, children(section), class: (section.has_child? ? 'dropdown':'')) }
    return navs.join('').html_safe
  end

  def children(section)
    elem = ''
    if section.has_child?
      elem += link_to ("#{section.page_title} <b class='caret'></b>").html_safe, "/#{section.page_url}", class: 'dropdown-toggle', 'data-toggle' => 'dropdown'
      elem += '<ul class="dropdown-menu">'
      section.pages.active.in_menu.each do |p|
      elem += content_tag(:li, link_to(p.page_title, "/#{p.page_url}", title: p.page_title))
      end
      elem += '</ul>'
    else
      elem += link_to section.page_title, pages_path(section.page_url)
    end
    return elem.html_safe
  end

  def news_articles_menu
    nav = <<-NAV
    <li><a href="/posts" title="News and Updates">News and Updates</a></li>
    NAV
    return nav.html_safe
  end

  def contact_menu
    contact = Page.where(is_contact: true).first
    contact = content_tag(:li, link_to('Contact Us', pages_path(contact.page_url), title: 'Contact Us'))
    contact.html_safe
  end

  def sub_pages(section)
    pages = section.pages
  end

  def short_description(description, length = nil)
    desc = sanitize(description)
    desc = strip_tags(description)
    desc = desc.gsub('&nbsp;', ' ').strip
    desc = desc.gsub('&ldquo;', '“').strip
    desc = desc.gsub('&rdquo;', '”').strip
    # desc = desc.gsub(/([.,!?;:])+/i, '\1 ').strip
    desc = desc.gsub('  ', ' ').strip
    if length
      desc = truncate(desc, length: length)
    end
    return desc
  end

  def brand_logo_src
    Contact.first.logo.url(:thumb)
  end

  def country_name(country_code)
    country = Carmen::Country.coded(country_code)
    country.name
  end

  def company_info_footer
    info = "#{@contact.company_name}<br>"
    if @contact.street.present?
      info += "#{@contact.street}<br>"
    end
    if @contact.city.present?
      info += "#{@contact.city}, "
    end
    if @contact.province.present?
      info += "#{@contact.province}, "
    end
    if @contact.country.present?
      info += "#{@contact.country}, "
    end
    info += '<br>'
    info += "Telephone: #{@contact.phone1}<br>"
    if @contact.fax.present?
    info += "Fax: #{@contact.fax}<br>"
    end
    info += "Email: #{mail_to @contact.email}"
    return info
  end

  def fancy_date(date)
    date.strftime('%B %d, %Y')
  end

  def yes_or_no(bool)
    bool ? 'Yes' : 'No'
    return 'No' unless bool

  end

end
