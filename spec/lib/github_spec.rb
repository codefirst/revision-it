require 'revision_it/service/github'

describe RevisionIt::Service::Github do
  describe 'invalid url' do
    it do expect {
        RevisionIt::Service::Github.commits('http://example.com')
      }.to raise_error(RevisionIt::Service::GithubError)
    end

    it do expect {
        RevisionIt::Service::Github.commits('http://github.com/a')
      }.to raise_error(RevisionIt::Service::GithubError)
    end
  end

  describe 'valid url' do
    before do
      @commits = double('commits')
      @repos   = double('repos')

      @repos.stub(:commits) { @commits }
      ::Github.stub(:repos) { @repos }
    end

    context "empty" do
      it 'should call ::Github' do
        @commits.should_receive(:all).with('codefirst', 'revision-it') { [] }
        RevisionIt::Service::Github.commits('http://github.com/codefirst/revision-it') {}
      end
    end

    describe'callback item' do
      before do
        @commits.should_receive(:all).with('codefirst', 'revision-it') do
          [
            OpenStruct.new(sha: 'foo',
                           html_url: 'http://example.com',
                           commit: OpenStruct.new(message: 'message',
                                                  author: OpenStruct.new(date: '2000-01-01',
                                                                         name: 'mzp')))
          ]
        end

        RevisionIt::Service::Github.commits('http://github.com/codefirst/revision-it') {|item|
          @item  = item
        }
      end

      subject { @item }

      its(:hash_code) { should == 'foo' }
      its(:url)    { should == 'http://example.com' }
      its(:author) { should == 'mzp' }
      its(:date)   { should == '2000-01-01' }
      its(:source) { should == 'github' }
      its(:project){ should == 'revision-it' }
    end
  end
end
