require 'uri'
require 'github_api'

module RevisionIt
  module Service
    class GithubError < StandardError
      def initialize(message)
        super(message)
      end
    end

    class Github
      class << self
        def commits(url, &f)
          url = URI.parse url

          unless url.host == 'github.com'
            raise GithubError.new("not valid url")
          end
          unless url.path =~ %r!\A/([^/]*)/([^/]*)!
            raise GithubError.new("not valid url")
          end

          user  = $1
          repos = $2
          ::Github.repos.commits.all(user, repos).each(&f)
        end
      end
    end
  end
end
