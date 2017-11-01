class DocController < ActionController::Base
  def root
    render file: 'doc/doc.html'
  end
end
