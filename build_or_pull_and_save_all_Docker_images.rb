# dataspectsSystem$ VERSION=181018a ruby build_or_pull_and_save_all_Docker_images.rb

sVersion = ENV["VERSION"]

aDockerImages = [
  {
    directory: "docker_image_factory/dataspects",
    tag: "dataspects/dataspects:#{sVersion}",
    git_repositories: [
      {
        url: "git@github.com:dataspects/dataspects_lib.git",
        name: "dataspects_lib"
      },
      {
        url: "git@github.com:dataspects/dataspects_api.git",
        name: "dataspects_api"
      }
    ]
  },
  {
    directory: "docker_image_factory/Apache_HTTP_Server/7.2",
    tag: "dataspects/apache_http_server7.2:#{sVersion}"
  },
  {
    directory: "docker_image_factory/duplicity",
    tag: "dataspects/duplicity:#{sVersion}"
  },
  {
    directory: nil,
    tag: "mariadb:10.3.6"
  },
  {
    directory: nil,
    tag: "docker.elastic.co/elasticsearch/elasticsearch-oss:6.3.1"
  },
  {
    directory: nil,
    tag: "docker.elastic.co/kibana/kibana-oss:6.3.1"
  },
  {
    directory: nil,
    tag: "logicalspark/docker-tikaserver"
  },
  {
    directory: nil,
    tag: "redis:3.2.12"
  },
  { # https://hub.docker.com/r/rediscommander/redis-commander/
    directory: nil,
    tag: "rediscommander/redis-commander"
  },
  { # https://store.docker.com/images/memcached
    directory: nil,
    tag: "memcached"
  },
  { # https://store.docker.com/images/tomcat
    directory: nil,
    tag: "tomcat"
  },
  { # https://store.docker.com/images/node
    directory: nil,
    tag: "node"
  },
  { # https://www.mediawiki.org/wiki/Parsoid/Setup#Docker
    directory: nil,
    tag: "benhutchins/parsoid"
  }
]

sPwd = Dir.pwd

def sanitize_Docker_image_name_for_filename sDockerImageName
  return "#{sDockerImageName.gsub(/\//, '_').gsub(/:/, '_')}"
end

# BUILDING
aDockerImages.each do |hDockerImage|
  unless(hDockerImage[:directory].nil?)
    Dir.chdir(hDockerImage[:directory])
    if(hDockerImage.has_key?(:git_repositories))
      hDockerImage[:git_repositories].each do |hGitRepository|
        if File.directory?(hGitRepository[:name])
          Dir.chdir(hGitRepository[:name])
          STDOUT.puts "Pulling #{hGitRepository[:name]}..."
          `git pull`
          STDOUT.puts "Pulled #{hGitRepository[:name]}."
          Dir.chdir("..")
        else
          STDOUT.puts "Cloning #{hGitRepository[:url]}..."
          `git clone #{hGitRepository[:url]}`
          STDOUT.puts "Cloned #{hGitRepository[:url]}."
        end
      end
    end
    STDOUT.puts "Building #{hDockerImage[:tag]}..."
    `sudo docker build --tag #{hDockerImage[:tag]} .`
    STDOUT.puts "Built #{hDockerImage[:tag]}."
    Dir.chdir(sPwd)
  end
end

# SAVING
Dir.chdir(sPwd)
unless File.directory?('docker_images')
  Dir.mkdir('docker_images')
end
aDockerImages.each do |hDockerImage|
  sFilename = "docker_images/#{sanitize_Docker_image_name_for_filename(hDockerImage[:tag])}.tar"
  if(hDockerImage[:directory].nil?)
    STDOUT.puts "Pulling #{hDockerImage[:tag]}..."
    `sudo docker pull #{hDockerImage[:tag]}`
    STDOUT.puts "Pulled #{hDockerImage[:tag]}."
  end
  STDOUT.puts "Saving #{sFilename}..."
  `sudo docker save --output #{sFilename} #{hDockerImage[:tag]}`
  `sudo chmod 777 #{sFilename}`
  STDOUT.puts "Saved #{sFilename}."
end
