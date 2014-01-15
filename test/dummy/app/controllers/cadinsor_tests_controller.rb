class CadinsorTestsController < ApplicationController

  before_filter :check_request_with_cadinsor, except: [:inside_method_check, :do_not_check]

  def default_check
    respond_to do  |format|
      format.json {render :action => 'do_not_check', :format => 'json'}
      format.xml {render :action => 'do_not_check', :format => 'xml'}
    end
  end

  def inside_method_check
    check_request_with_cadinsor
    respond_to do  |format|
      format.json {render :action => 'do_not_check', :format => 'json'}
      format.xml {render :action => 'do_not_check', :format => 'xml'}
    end
  end

  def do_not_check
    respond_to do  |format|
      format.json {render :action => 'do_not_check', :format => 'json'}
      format.xml {render :action => 'do_not_check', :format => 'xml'}
    end
  end
end
