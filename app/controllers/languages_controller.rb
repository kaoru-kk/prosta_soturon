# frozen_string_literal: true

class LanguagesController < ApplicationController
  def new
    @language = Language.new
  end

  def create
    language = Language.new(language_params)
    language.save
    redirect_to language_path(language.id)
  end

  def show; end

  private

  def language_params
    params.require(:language).permit(:lang_name)
  end
end
