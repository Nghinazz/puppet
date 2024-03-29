<h1>Microsoft Open Technologies manifest files for Puppet</h1>
              
<p>Microsoft Open Technologies is providing a Windows Azure Cloud Provisioner Module for Puppet that streamlines provisioning Windows Azure services like, virtual machines, virtual networks and SQL database services.
</p>

<h2>Requirements</h2>

<p>To enable bootstrapping Puppet agent, the following Windows Remote Management (WinRM) settings need to be updated.</p>

<p>To update these settings run these commands.</p>

<pre><code>$ winrm set winrm/config/service @{AllowUnencrypted="true"}

$ winrm set winrm/config/service/auth @{Basic="true"}
</code></pre>

<p>The following gems are also required.</p>

<p><li>azure (>= 0.6.0)</li>
<li>net-ssh (>= 2.1.4)</li>
<li>net-scp (>= 1.0.4)</li>
</p>

<h2>Manifest files</h2>

<p>Manifest files are collections of definitions, references (Including other manifest files.) and commands that enable you to quickly and repeatably deploy a configured virtual machine, virtual network or SQL database. 
There are five provided manifest files listed below, the parameters they use and their defaults. Parameters with the value "undef" require you to supply the appropriate value.</p>

<p><strong>bootstrap.pp</strong><br />
Bootstrap.pp allows you to create a new instance with Puppet already installed and configured. This manifest takes the following parameters.</p>

<pre><code>$homedir = undef,
$azure_management_certificate,
$azure_subscription_id,
$puppet_master_ip,
$node_ipaddress,
$ssh_user = undef,
$winrm_user = undef,
$private_key_file = undef,
$winrm_port = undef,
$password = undef,
$ssh_port = 22,
$winrm_transport = 'http'</code></pre>

<p><strong>db.pp</strong><br />
db.pp allows you to create a new instance of SQL server. This manifest takes the following parameters.</p>

<pre><code>$azure_management_certificate,
$azure_subscription_id,
$login,
$password,
$location</code></pre>

<p><strong>init.pp</strong><br />
init.pp defines the windowsazure class which will allow you to easily deploy to your Windows Azure account. This manifest takes the following parameters.</p>

<pre><code>$location = 'West US',
$vm_name = undef,
$vm_user = undef,
$image = undef,
$password = undef</code></pre>

<p><strong>vm.pp</strong><br />
vm.pp allows you to create a new virtual machine instance. This manifest takes the following parameters.</p>

<pre><code>$vm_name,
$vm_user,
$image,
$location,
$homedir = undef,
$azure_management_certificate,
$azure_subscription_id,
$vm_size = 'Small',
$puppet_master_ip = undef,
$private_key_file = undef,
$certificate_file = undef ,
$storage_account_name = undef,
$cloud_service_name = undef,
$password = undef</code></pre>

<p><strong>vnet.pp</strong><br />
vnet.pp allows you to create a new virtual network instance. This manifest takes the following parameters.</p>

<pre><code>$azure_management_certificate,
$azure_subscription_id,
$virtual_network_name,
$affinity_group_name,
$address_space,
$subnets = undef,
$dns_servers = undef</code></pre>
