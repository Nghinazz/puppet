
Puppet::Face.define :azure_vnet, '1.0.0' do
  action :list do

    summary 'List virtual networks.'
    arguments 'list'
    description <<-'EOT'
      The list action obtains a list of virtual networks and
      displays them on the console output.
    EOT

    Puppet::VirtualNetwork.add_default_options(self)

    when_invoked do |options|
      Puppet::VirtualNetwork.initialize_env_variable(options)
      virtual_network_service = Azure::VirtualNetworkManagementService.new

      virtual_networks = virtual_network_service.list_virtual_networks
      puts Tilt.new(Puppet::VirtualNetwork.views('virtual_networks.erb'), 1, :trim => '%').render(nil, :vnets => virtual_networks)
    end

    returns 'Array of virtual network objets.'

    examples <<-'EOT'
      $ puppet azure_vnet list --management-certificate ~/exp/azuremanagement.pem\
        --azure-subscription-id=368a3-dcd0-4cd3 --management-endpoint=https://management.core.windows.net                                 Listing virtual networks

      Virtual Network: 1
        Server Name         : vnet-AG
        Address Space       : 172.16.0.0/12, 10.0.0.0/8, 192.168.0.0/24

        Subnets:             Name              Address Prefix
                             Subnet-1          172.16.0.0/12
                             Subnet-2          10.0.0.0/8
                             Subnet-4          192.168.0.0/26

        Dns Servers:         Name              Ip Address
                             google            8.8.8.8
                             google-2          8.8.4.4

        EOT
  end
end
