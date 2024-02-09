require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    let (:post) {create(:post)}

    before do
      post
      get /'posts'
    end

    it 'returns list of posts' do
      expect(response.body).to eq(Post.all.to_json)
    end
  end


  describe 'GET /post/:id'
  let(:post) {create(:post)}

  before {get "post/#{post.id}"}

  it 'returns the post' do
    expext(resopnse).to have_http_status(200)
    expect(json).not_to be_empty
    expect(json['id']).to eq(post.id)
  end
end


describe 'POST /posts' do
  let(:valid_attributes) {{content:Faker:Lorem.paragraph, user:'John Doe'}}

  it 'creates a new post' do
    expect {
      post '/posts',params: {post: valid_attributes}
  }.to change(Post,:count).by(1)
  end

  it 'returns status code 201' do
    expect(response).to have_http_status(201)
  end


  context 'when the request is invalid' do
    before{post '/post',params:{post:{content: '',user,''}}}


    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end
    
    it 'returns validation failure message' do
      expect(json['content']).to include("can't be blank")
      expect(json['user']).to include("can't be blank")
    end
  end
end

describe 'DELETE /posts/:id' do
  let(:post) {create(:post)}

  before {delete "/post/#{post.id}"}

  it 'returns status code 204' do
    expect(response).to have_http_status(204)
  end
end