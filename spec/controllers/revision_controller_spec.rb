require 'spec_helper'

describe RevisionsController do
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
        100.times {|i|
          create(:revision, hash_code: "commit-#{i}")
        }
        get 'index'
      end

      describe 'response' do
        subject { response }
        it { should be_success }
      end

      describe 'assigns' do
        subject { assigns :revisions }
        it { should have(100).items }
      end
    end
  end

  describe "GET 'show'" do
    context 'success' do
      before do
        @revision = create(:revision)
        get 'show', hash: @revision.hash_code
      end

      describe 'response' do
        subject { response }
        it { should be_success }
      end

      describe 'assigns' do
        subject { assigns :revision }
        it { should == @revision }
      end
    end

    context 'not found' do
      before do
        @revision = create(:revision)
        get 'show', hash: '-'
      end

      describe 'response' do
        subject { response }
        it { should_not be_success }
      end
    end
  end

  describe "GET 'via_hash'" do
    context 'success' do
      before do
        @revision = create(:revision)
        get 'via_hash', hash: @revision.hash_code
      end

      describe 'response' do
        subject { response }
        it { should be_success }
      end

      describe 'assigns' do
        subject { assigns :revision }
        it { should == @revision }
      end
    end

    context 'not found' do
      describe 'small hash' do
        before do
          @revision = create(:revision)
          get 'via_hash', hash: '-'
        end

        describe 'response' do
          subject { response }
          it { should_not be_success }
          its(:status) { should == 400 }
        end
      end

      describe 'not found' do
        before do
          @revision = create(:revision)
          get 'via_hash', hash: 'a' * 30
        end

        describe 'response' do
          subject { response }
          it { should_not be_success }
          its(:status) { should == 404 }
        end
      end
    end
  end
end
