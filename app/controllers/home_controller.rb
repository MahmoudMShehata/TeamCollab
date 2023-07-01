# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :root, only: [:index]

  def index; end

  def dashboard; end
end
