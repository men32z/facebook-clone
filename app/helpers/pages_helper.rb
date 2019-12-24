# frozen_string_literal: true

module PagesHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def full_title(page_title = '')
    base_title = 'Facebook Clone'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
