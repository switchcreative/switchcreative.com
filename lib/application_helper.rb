module ApplicationHelper

  # Page Titles - Set individual page title elements
  # Accepts a String or Array.
  # Sets yield(:title) to a String for use in <title>.
  # 
  #   --Array--
  #   title ["Example", "Nashville, TN"]
  #   => "Example - Page - Title"
  # 
  #   --String--
  #   title "Example Page Title"
  #   => "Example Page Title"
  # 
  def title title_partials
    title = if title_partials.is_a? String
      title_partials
    elsif title_partials.is_a? Array
      title_partials.reject(&:blank?).join(' - ')
    end
    content_for(:title) { title }
  end


  # Has Images
  # 
  def has_images data
    if data.images && data.images.size > 0
      true
    else
      false
    end
  end
  

  # Portfolio Image
  # 
  def portfolio_image data, image
    "portfolio/#{data.slug}/#{image}"
  end
  

  # Featured Image
  # 
  def featured_image data
    if data.featured_image
      portfolio_image(data, data.featured_image)
    else
      portfolio_image(data, data.images[0])
    end
  end
  

  # Image Set
  # 
  def image_set data
    if data.images && data.images.size > 0
      if data.featured_image
        data.images
      else
        data.images.drop(1)
      end
    else
      []
    end
  end


  # Markup for async images with noscript fallback
  # 
  def async_image img
    el =  "<div data-behavior='delayedImage' data-src='#{img}' style='display:none;'></div>"
    el += "<noscript><img src='#{img}'></noscript>"
    el
  end
  

  # Display IcoMoon font icon
  # 
  def icon key
    "<i data-icon=&#x#{h(key)}></i>"
  end
  

  # Date: November 5, 2013
  # 
  def date_full(date)
    date.strftime("%B %e, %Y") unless date.blank?
  end


  # Date: Nov 5, 2013
  # 
  def date_short(date)
    date.strftime("%b %e, %Y") unless date.blank?
  end


  # Date: 11/5/2013
  # 
  def date_compact(date)
    date.strftime("%-m/%-d/%Y") unless date.blank?
  end

end
