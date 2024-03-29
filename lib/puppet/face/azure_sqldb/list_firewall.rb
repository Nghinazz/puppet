require 'tilt'

Puppet::Face.define :azure_sqldb, '1.0.0' do
  action :list_firewall do

    summary 'List firewall of SQL database servers.'
    arguments 'list'
    description <<-'EOT'
      The list_firewall action retrieves a list of all the server-level firewall rules for a
      SQL Database server that belongs to a subscription.
    EOT

    Puppet::SqlDatabase.add_delete_options(self)

    when_invoked do |options|
      Puppet::SqlDatabase.initialize_env_variable(options)
      db_server = Azure::SqlDatabaseManagementService.new

      firewalls = db_server.list_sql_server_firewall_rules(options[:server_name])
      puts Tilt.new(Puppet::SqlDatabase.views('server_firewalls.erb'), 1, :trim => '%').render(nil, :firewalls => firewalls)
    end

    examples <<-'EOT'
      $  puppet azure_sqldb list_firewall --management-certificate ~/exp/azuremanagement.pem\
         --azure-subscription-id=ID --management-endpoint=https://management.database.windows.net:8443/\
         --server-name=g2jxhsbk0w
        Listing Firewall

        Firewall: 1
          Rule name           : ClientIPAddress_2013-08-20_15:37:41
          Start IP address    : 207.46.55.27
          End Ip Address      : 207.46.55.27

        Firewall: 2
          Rule name           : ranjan
          Start IP address    : 10.10.0.0
          End Ip Address      : 10.10.0.0

        Firewall: 3
          Rule name           : rule2
          Start IP address    : 192.168.1.1
          End Ip Address      : 192.168.1.1

    EOT
  end
end
