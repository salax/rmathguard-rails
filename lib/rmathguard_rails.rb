require 'digest/sha1'

module RMathGuardHelper
  def rmathguard(options = {})
    opts = {}
    opts[:row_count] = options[:row_count] || 5
    opts[:column_count] = options[:col_count] || options[:column_count] || 3
    opts[:sep_size]  = options[:sep_size]  || 2 

    input_opts = {}
    input_opts[:class] = options[:input_class]
    input_opts[:size]  = options[:input_size] || 3

    guard = RMathGuard::Expression.new(opts)
    out = ""
    out << hidden_field_tag(:rmg, Digest::SHA1.hexdigest(Rails.root.to_s + guard.result.to_s))
    out << "<table><tr><td>"
    out << content_tag(:pre, guard.show, :style => options[:style])
    out << %{</td><td style="vertical-align: middle">}
    out << text_field_tag("rmathguard", '', input_opts)
    out << "</td></tr></table>"
    out
  end
end

module RMathGuard
  module Validation
    def guard_valid?
      if params[:rmg] == Digest::SHA1.hexdigest(Rails.root.to_s + params[:rmathguard])
        true
      else
        flash[:error] = t("rmathguard_input_failed")
        false
      end
    end

    def guard_invalid?
      !rmg_valid?
    end
  end
end

ActionView::Base.send :include, RMathGuardHelper