class ResponsesController < ApplicationController

  # GET /responses
  # GET /responses.xml
  def index
    @responses = Response.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.xml
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.xml
  # see bottom of this page for question_answer examples
  def new
    @question_answers = [ #if we want a likert scale (0-4) when we place 'likert' in the array
      ['As a student I prefer to work independently.', ['likert']],
      ['I often finish projects and assignments when they are due.', ['likert']],
      ['I am willing to ask an instructor or another student for help if I have trouble understanding a topic, or need clarification.', ['likert']],
      ['I am comfortable navigating the internet using a browser like Internet Explorer or Firefox.', ['likert']],
      ['I am confident that I will have access to a reliable computer and Internet connection to complete my coursework.', ['likert']],
      ['I am comfortable communicating actively and electronically with my instructor and other students.', ['likert']],
      ['It is likely that I will be able to follow a routine and check my course email and discussion forums daily.', ['likert']],
      ['I am motivated to spend the necessary time to learn the process of downloading, uploading and/or installing software, even those that are new to me.', ['likert']],
      ['I will commit the time and patience required to learn to navigate unfamiliar web sites.', ['likert']],
      ['I feel that online learning is equal in quality to traditional classroom learning.', ['likert']],
      ['I do well following written directions.', ['likert']],
      ['I am confident in my ability to learn and understand materials (textbooks, articles and web sites) by reading or viewing them on my own.', ['likert']],
      ['When studying, I consider myself self-disciplined. For example, I find it easy to set aside reading and homework time each day.', ['likert']],
      ['Are you willing and able to communicate with your instructor and classmates almost entirely through writing?', ['Yes','No']],
      ['Do you know how to send and receive email, and can you attach a file to an email message?', ['Yes','No']],
      ['Do you use word processing software, like Microsoft Word?', ['Yes','No']],
      ['Do you have Microsoft Office or a similar suite of programs that includes a word processor?', ['Yes','No']],
      ['Do you know how to save and locate files on your computer or a flash drive?', ['Yes','No']],
    ]

    @response = Array.new
    @question_answers.each do |q|
      @response.push Response.new :question_and_answers => q
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/1/edit
  def edit
    @response = Response.find(params[:id])
  end

  # POST /responses
  # POST /responses.xml
  def create
    @uuid = UUIDTools::UUID.random_create.to_s
    @results = params[:response]
    @responses = params[:response].values.collect do |response|
      r = Response.new(response)
      r.uuid = @uuid
      r
    end
   if @responses.all?(&:valid?)
     @responses.each(&:save!)
   else
     redirect_to responses_path, :notice => "Oops! Something bad happened."
   end
  end

  # PUT /responses/1
  # PUT /responses/1.xml
  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to(@response, :notice => 'Response was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.xml
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(responses_url) }
      format.xml  { head :ok }
    end
  end

  def mail_results
    @email = params[:email]
    @name = params[:name]
    @result = params[:result]
    @uuid = params[:uuid]
    ResponseMailer.email_response(@name, @email, @result, @uuid).deliver
  end
end

=begin
      ['What is your name?', ['Jim','Jack','Jon','Wintas']],
      ['What is your quest?', ['To take this assessment','To find the holy grail','To please the president','To rule the world']],
      ['Are you handy with a sword?', ['Yes','No']],
      ['What is your favorite color?', ['Blue','Red','Purple','Gold']],
      ['What is the average air speed of an unlaiden swallow?', ['99','24','63','An African Swallow or a European swallow?']]
=end
