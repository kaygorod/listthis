class StaticPagesController < ApplicationController
  def home
    @lists = List.all
  end

  def help
  end
end
