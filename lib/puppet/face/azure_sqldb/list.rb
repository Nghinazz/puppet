require 'tilt'

Puppet::Face.define :azure_sqldb, '1.0.0' do
  action :list do

    summary 'List SQL database servers.'
    arguments 'list'
    description <<-'EOT'
      The list action obtains a list of sql database servers and
      displays them on the console output.
    EOT

    Puppet::SqlDatabase.add_default_options(self)

    when_invoked do |options|
      Puppet::SqlDatabase.initialize_env_variable(options)
      db_server = Azure::SqlDatabaseManagementService.new

      servers = db_server.list_servers
      puts Tilt.new(Puppet::SqlDatabase.views('servers.erb'), 1, :trim => '%').render(nil, :db_servers => servers)
    end

    returns 'Array of database server objets.'

    examples <<-'EOT'
      $ puppet azure_sqldb list --management-certificate ~/exp/azuremanagement.pem\
        --azure-subscription-id=368a3-dcd0-4cd3 --management-endpoint=https://management.database.windows.net:8443/

    Listing Servers

      Server: 1
        Server Name         : esinlp9bav
        Administrator login : puppet3
        Location            : West US

      Server: 2
        Server Name         : estkonosnv
        Administrator login : puppet
        Location            : West US

      Server: 3
        Server Name         : ezprthvj9w
        Administrator login : puppet
        Location            : West US

    EOT
  end
end
