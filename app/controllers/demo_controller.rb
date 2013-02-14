class DemoController < ApplicationController
  def index
  	#render('hello')
  	redirect_to(:action => 'hello_other')
  end
  def hello
  end

  def hello_other
  	render(:text => 'hello')
 end
end
