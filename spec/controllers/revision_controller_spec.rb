require 'spec_helper'

describe RevisionsController do

  describe "GET 'index'" do
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
      before do
        @revision = create(:revision)
        get 'via_hash', hash: '-'
      end

      describe 'response' do
        subject { response }
        it { should_not be_success }
      end
    end
  end
end
