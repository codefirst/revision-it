require 'spec_helper'
require 'ostruct'

describe GithubController do
  def commit(opt)
    OpenStruct.new({ project: "codefirst/revision-it" }.merge(opt))
  end

  describe "GET 'index'" do
    context "not signin" do
      before { get 'index' }
      subject { response }
      it { should redirect_to(new_user_session_path) }
    end

    context "signin" do
      before do
        user = User.create!
        user.save
        sign_in user
      end

      before do
        get 'index'
      end

      describe 'response' do
        subject { response }
        it { should be_success }
      end
    end
  end

  describe "POST 'import'" do
    context "not signin" do
      before { get 'index' }
      subject { response }
      it { should redirect_to(new_user_session_path) }
    end

    context "signin" do

      before do
        @user = User.create!
        @user.save
        sign_in @user
      end

      context 'success' do
        before do
          create(:revision, hash_code: 'bar')
          @project = create(:project, owner: 'codefirst', repos: 'revision-it')
          @project.save!

          RevisionIt::Service::Github.
            stub(:commits).
            with('https://github.com/codefirst/revision-it').
            and_yield(commit(hash_code: "foo", url: "http://example.com", log: "this is text")).
            and_yield(commit(hash_code: "bar", url: "http://example.com", log: "this is text", project: "mzp/hoge" ))

          post 'import_all', url: 'https://github.com/codefirst/revision-it'
        end

        describe 'response' do
          subject { response }
          it { should redirect_to(github_path) }
        end

        describe 'new revision' do
          subject { Revision.where(hash_code: 'foo').first }
          its(:log) { should == 'this is text' }
          its(:url) { should == 'http://example.com' }
          its(:project) { should == @project }

          describe 'project' do
            subject { Project.where(id: @project.id).first.users }
            it { should include(@user) }
          end
        end

        describe 'update revision' do
          subject { Revision.where(hash_code: 'bar').first }
          its(:log) { should == 'this is text' }
          its(:url) { should == 'http://example.com' }
          its(:project) { should == Project.where(owner: "mzp", repos: "hoge").first }

          describe 'project' do
            subject { Project.where(owner: "mzp", repos: "hoge").first.users }
            it { should include(@user) }
          end

        end
      end

      context 'error' do
        describe 'invalid url' do
          before {
            post 'import_all', url: 'https://example.com'
          }

          subject { response }
          it { should_not be_success }
          its(:status) { should == 400 }
        end
      end
    end
  end

  describe "POST 'hook'" do
    context 'success' do
      before do
        RevisionIt::Service::Github.
          stub(:commits).
          with('https://example.com')

        post 'hook', payload: { repository: { url: 'https://example.com' } }.to_json
      end

      describe 'response' do
        subject { response }
        it { should be_success }
      end
    end

    context 'error' do
      describe 'invalid url' do
        before {
          post 'hook', payload: { repository: { url: 'https://example.com' } }.to_json
        }

        subject { response }
        it { should_not be_success }
        its(:status) { should == 400 }
      end

      describe 'invalid payload' do
        before {
          post 'hook'
        }

        subject { response }
        it { should_not be_success }
        its(:status) { should == 400 }
      end
    end
  end
end

