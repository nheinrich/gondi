module ApplicationHelper

  # modal --------------------------------------------------------------------

  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture_haml(&block))
    render(:partial => partial_name, :locals => options)
  end

  def lifted_box(style = "", options = {}, &block)
    block_to_partial('common/lifted_box', options.merge(:style => style), &block)
  end

  # patterns -----------------------------------------------------------------

  def fancy_input(name, style='', title='', value='')
    capture_haml do
      title = name.capitalize if title.empty?
      style = name if style.empty?
      type = name.include?('password') ? 'password' : 'text'

      haml_tag :div, {:class => 'fancy_input ' + style} do
        haml_tag :span, {:class  => 'input'} do
          haml_tag :input, {:type => type, :name => name, :title => title, :value => value}
        end
        haml_tag :span, {:class => 'tail'}
      end
    end
  end

  def bevel_button(text, style='', path='')
    capture_haml do
      path = '#'+text if path.empty?
      haml_tag :a, {:class => 'bevel_button ' + style} do
        haml_tag :span, text, {:class => 'text'}
        haml_tag :span, {:class => 'tail'}
      end
    end
  end

  def tag_link(text, style='', path='')
    capture_haml do
      haml_tag :a, {:href => path, :class => 'tag ' + style} do
        haml_tag :span, text, {:class => 'text'}
        haml_tag :span, {:class => 'option'}
      end
    end
  end

  # minor --------------------------------------------------------------------

  def videos_total(num)
    capture_haml do
      haml_tag :span, :class => 'total' do
        haml_tag :span, '('
        haml_tag :span, num, :class => 'number'
        haml_tag :span, ')'
      end
    end
  end

  def save_or_submit
    controller.action_name == 'new' ? 'submit' : 'save'
  end

end
