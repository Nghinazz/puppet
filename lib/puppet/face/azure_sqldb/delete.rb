
Puppet::Face.define :azure_sqldb, '1.0.0' do
  action :delete do

    summary 'Delete Windows Azure sql database server'

    description <<-'EOT'
      The delete action delete windows azure sql server.
    EOT

    Puppet::SqlDatabase.add_delete_options(self)

    when_invoked do |options|
      Puppet::SqlDatabase.initialize_env_variable(options)
      db = Azure::SqlDatabaseManagementService.new
      db.delete_server(options[:server_name])
      nil
    end

    returns 'NONE'

    examples <<-'EOT'
      $  puppet azure_sqldb delete --management-certificate ~/exp/azuremanagement.pem\
         --azure-subscription-id=ABCD123 --server-name=ezprthvj9w\
         --management-endpoint=https://management.database.windows.net:8443/
    EOT
  end
end
