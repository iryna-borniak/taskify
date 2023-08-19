module ApplicationHelper  
  def active_link_to(name, path)
    link_to(name, path, class: link_classes_for(path))
  end

  private

  def link_classes_for(path)
    link_classes = 'btn border hover:border-rose-100 hover:text-black transition duration-300 ease-in-out'

    link_classes += if current_page?(path)
                      ' border-rose-200 text-black'
                    else
                      ' border-transparent'
                    end

    link_classes
  end
end
