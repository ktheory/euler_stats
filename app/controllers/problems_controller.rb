class ProblemsController < ApplicationController
  def index
    @problems = Problem.order('solved_by DESC')
  end

end
