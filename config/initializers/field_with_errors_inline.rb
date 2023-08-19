ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  if html_tag =~ /<(input|textarea|select|label)[^>]+class=/
    class_attribute = html_tag =~ /class=['"]/
    if class_attribute
      html_tag.insert(class_attribute + 7,
                      'inline ')
    else
      html_tag.insert(html_tag.index(/>/) - 1, " class='inline'")
    end
  else
    html_tag
  end
end
