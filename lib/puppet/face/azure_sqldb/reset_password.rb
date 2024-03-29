
Puppet::Face.define :azure_sqldb, '1.0.0' do
  action :reset_password do

    summary 'Reset password of sql database server.'

    description <<-'EOT'
      The reset_passowrd action reset password of sql database server.
    EOT

    Puppet::SqlDatabase.add_reset_password_options(self)

    when_invoked do |options|
      Puppet::SqlDatabase.initialize_env_variable(options)
      db = Azure::SqlDatabaseManagementService.new
      db.reset_password(options[:server_name], options[:password])
      nil
    end

    examples <<-'EOT'
      $ puppet azure_sqldb reset_password --management-certificate ~/exp/azuremanagement.pem\
        --azure-subscription-id=368a3762-fce0 --management-endpoint=https://management.database.windows.net:8443/\
        --server-name hc786mm0l8 --password Ranjan@1234
    EOT
  end
end
