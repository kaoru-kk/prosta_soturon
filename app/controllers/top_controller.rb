# frozen_string_literal: true

class TopController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def top; end
end
