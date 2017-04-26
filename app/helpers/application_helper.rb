module ApplicationHelper
  # make external urls valid for the link_to method even when http, etc. is not included
  def url_to_external(text)
    /\Ahttp(s)?:\/\//.match(text) ? text : text.gsub(/\A(http(s)?:\/\/)?(www\.)?(.*)/,"http\\2://www.\\4")
  end
end
