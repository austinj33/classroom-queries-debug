class CoursesController < ApplicationController
  def index
    @courses = Course.all.order({ :created_at => :desc })

    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @courses = Course.where({:id => the_id }).at(0)

    render({ :template => "courses/show" })
  end

  def create
    @courses = Course.new
    @courses.title = params.fetch("q_title")
    @courses.term_offered = params.fetch("query_term")
    @courses.department_id = params.fetch("query_department_id")

    if @courses.valid?
      @courses.save
      redirect_to("/courses", { :notice => "Course created successfully." })
    else
      redirect_to("/courses", { :notice => "Course failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @courses = Course.where({ :id => the_id }).at(0)

    @courses.title = params.fetch("query_title")
    @courses.term_offered = params.fetch("query_term_offered")
    @courses.department_id = params.fetch("query_department_id")

    if @courses.valid?
      @courses.save
      redirect_to("/courses/#{@courses.id}", { :notice => "Course updated successfully."} )
    else
      redirect_to("/courses/#{@courses.id}", { :alert => "Course failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @courses = Course.where({ :id => the_id }).at(0)

    @courses.destroy

    redirect_to("/courses", { :notice => "Course deleted successfully."} )
  end
end
