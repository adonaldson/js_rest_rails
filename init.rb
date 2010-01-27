require File.join(File.dirname(__FILE__), 'lib', 'js_rest.rb')
ActionView::Base.send :include, JsRestHelper
