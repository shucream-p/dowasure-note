# frozen_string_literal: true

module TurboFrameHelper
  def wait_for_turbo_frame(selector = 'turbo-frame', timeout = nil)
    return unless has_selector?("#{selector}[busy]", visible: true, wait: 0.25.seconds)

    has_no_selector?("#{selector}[busy]", wait: timeout.presence || 5.seconds)
  end

  def wait_for_turbo(timeout = nil)
    return unless has_css?('.turbo-progress-bar', visible: true, wait: 0.25.seconds)

    has_no_css?('.turbo-progress-bar', wait: timeout.presence || 5.seconds)
  end
end
