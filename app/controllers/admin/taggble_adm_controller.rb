class Admin::TaggbleAdmController < ApplicationController
  def tags_for
    @taggble_mod = params[:modul]
    unless @taggble_mod.blank?
      @taggblemod = @taggble_mod.constantize
    else
      render :text=>"Не найдено тэгов для данного модуля"
    end
  end

end
