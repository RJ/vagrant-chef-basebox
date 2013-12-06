## So we know which environemnt this machine is in, for bash prompt
file "/etc/chef_environment" do
    owner "root"
    group "root"
    mode 0755
    action :create
    content "CHEF_ENVIRONMENT=\"#{node.chef_environment}\""
end

cookbook_file "/etc/skel/.bashrc" do
    source "skel-bashrc"
    owner "root"
    mode "0644"
end

cookbook_file "/etc/bashrc_global" do
    source "bashrc"
    owner "root"
    mode "0644"
end
