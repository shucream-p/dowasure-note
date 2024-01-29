# frozen_string_literal: true

module SwipeHelper
  def swipe(size, element)
    execute_script("arguments[0].style.transform = 'translateX(#{size}px)';", element)
  end
end
