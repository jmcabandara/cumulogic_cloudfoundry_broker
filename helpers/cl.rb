require 'yaml'
require 'cumulogic_client'

module Cl
  def get_client()
    cnf = YAML::load(File.open(File.expand_path('~/.cumulogic_client.yml')))
    url = cnf['URL']
    user = cnf['USER']
    password = cnf['PASSWORD']
    ssl = (cnf['SSL']) || false
    debugon = (cnf['DEBUG']) || false
    CumulogicClient::Nosql.new(url, user, password, ssl, debugon)
  end

  def userid()
    cnf = YAML::load(File.open(File.expand_path('~/.cumulogic_client.yml')))
    cnf['USERID']
  end

end
