class TasksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @task = @list.tasks.new
  end

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(task_params)
    @task.done = false
    if @task.save
      redirect_to list_path(@task.list)
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    render :edit
  end

  def update
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if params[:done] == "true"
      @task.done = true
      @task.save
      redirect_to list_path(@list)
    elsif params[:done] == "false"
        @task.done = false
        @task.save
        redirect_to list_path(@list)
    elsif @task.update(task_params)
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @task.destroy
    redirect_to list_path(@list)
  end

  private

  def task_params
    params.require(:task).permit(:description, :done)
  end
end
