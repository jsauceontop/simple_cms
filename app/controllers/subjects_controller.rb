class SubjectsController < ApplicationController
layout 'landing'

def list
	@subjects = Subject.order("subjects.name ASC")
end

def show
	@subject = Subject.find(params[:id])
end

def update
	@subject = Subject.find(params[:id])
	@subject.update_attributes(params[:subject])
	if @subject.save
		redirect_to(:action => 'list')
	else
		render('edit')
	end
end

def edit
	@subject = Subject.find(params[:id])
end


def delete
	@subject = Subject.find(params[:id])
	@subject.destroy
	redirect_to(:action => 'list')
end

def create
	@subject = Subject.new(params[:subject])
	if @subject.save
		redirect_to(:action => 'list')
	else
		render('new')
	end
end


end
