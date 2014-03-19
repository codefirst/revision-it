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
          user, repos = parse_url url

         ::Github.repos.commits.all(user, repos).each do|commit|
            f[make("#{user}/#{repos}", commit)]
          end
        end

        private
        def parse_url(url)
          url = URI.parse url

          unless url.host == 'github.com'
            raise GithubError.new("not valid url")
          end
          unless url.path =~ %r!\A/([^/]*)/([^/]*)!
            raise GithubError.new("not valid url")
          end

          [$1, $2]
        end

        def make(repos, commit)
          OpenStruct.new(hash_code: commit.sha,
                         url: commit.html_url,
                         log: commit.commit.message,
                         date: commit.commit.author.date,
                         author: commit.commit.author.name,
                         project: repos,
                         source: 'github')
        end
      end
    end
  end
end
