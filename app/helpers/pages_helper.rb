# frozen_string_literal: true

module PagesHelper
  def full_title(page_title = '')
    base_title = 'Facebook Clone'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
