require 'spec_helper'
require 'ostruct'

describe GithubController do
  def commit(hash_code, url, log)
    OpenStruct.new(hash_code: hash_code,
                   url: url,
                   log: log)
  end

  describe "GET 'index'" do
    before do
      get 'index'
    end

    describe 'response' do
      subject { response }
      it { should be_success }
    end
  end

  describe "POST 'import'" do
    before do
      create(:revision, hash_code: 'bar')

      RevisionIt::Service::Github.
        stub(:commits).
        with('https://github.com/codefirst/revision-it').
        and_yield(commit("foo", "http://example.com", "this is text")).
        and_yield(commit("bar", "http://example.com", "this is text"))

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
    end

    describe 'update revision' do
      subject { Revision.where(hash_code: 'bar').first }
      its(:log) { should == 'this is text' }
      its(:url) { should == 'http://example.com' }
    end
  end

  describe "POST 'hook'" do
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
end

