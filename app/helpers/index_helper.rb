module IndexHelper
  def modal_text(obj)
    if obj.class.name == 'Company'
      modal_text = obj.category.name unless obj.category_id.nil?
      modal_text = obj.subcategory.name unless obj.subcategory_id.nil?
    else
      modal_text = obj.name
    end
    modal_text
  end

  def position(n, m)
    position = {}
    divmod = n.divmod m
    position[:top] = divmod[1].odd? ? divmod[0] * 270 : (2 * divmod[0] + 1) * 135
    position[:left] = divmod[1] * 235.5
    position
  end

  def search_result_height(length)
    divmod = length.divmod 4
    height = (divmod[0] + 1) * 270 if divmod[1] == 0
    height = (divmod[0] + 2) * 270 unless divmod[1] == 0
    height
  end

  def set_title(title)
    new_title = if title.length > 17
                  title[0..14] + '...'
                else
                  title
                end
    new_title
  end

  def url_code(url)
    code_url = url.gsub(/\s+/, '-')
    # code_url.downcase!
    code_url
  end
end
