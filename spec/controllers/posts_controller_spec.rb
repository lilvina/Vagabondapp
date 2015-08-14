require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	before do
		current_user = FactoryGirl.create(:user)
		session[:user_id] = current_user.id
	end
	describe "#new" do
	    before do
	      get :new
	    end

	    it "should respond with 200 success" do
	      expect(response.status).to be(200)
	    end

	    it "should assign @post" do
	      expect(assigns(:post)).to be_instance_of(Post)
	    end

	    it "should render the :new view" do
	      expect(response).to render_template(:new)
	    end
 	end

 	describe "#create" do
 	   context "success" do
 	     before do
 	       @posts_count = Post.count
 	       post :create, post: {title: "Hello World", city_id: 1, body: "hi"}
 	     end

 	     it "should add new post" do
 	       expect(Post.count).to eq(@posts_count + 1)
 	     end

 	     it "should respond with 302 found" do
 	       expect(response.status).to be(302)
 	     end

 	     it "should redirect_to 'post_path'" do
 	       expect(response.location).to match(/\/posts\/\d+/)
 	     end
 	   end

 	   context "failure" do
 	     before do
 	       post :create, post: {title: nil, city_id: nil, body: nil}
 	     end

 	     it "should respond with 302 found" do
 	       expect(response.status).to be(302)
 	     end

 	     it "should redirect to 'new_post_path'" do
 	       expect(response).to redirect_to(new_post_path)
 	     end

 	     it "should flash an error message" do
 	       expect(flash[:error]).to be_present
 	     end
 	   end
 	end
end
