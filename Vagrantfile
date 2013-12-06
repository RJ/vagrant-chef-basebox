# NB, do this:
# vagrant plugin install vagrant-omnibus
# vagrant plugin install vagrant-berkshelf
# 
BOXNAME="opscode-ubuntu-13.10"
BOXURL="http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-13.10_chef-provisionerless.box"
HOSTNAME="vagrant"
RAM=512
IP="10.1.2.3"

Vagrant.configure("2") do |config|
    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = "cookbooks/Berksfile"
    config.vm.define :demobox do |n|
        n.omnibus.chef_version = :latest
        n.vm.box = BOXNAME
        n.vm.box_url = BOXURL
        n.vm.hostname = HOSTNAME
        n.vm.network :private_network, ip: IP
        n.ssh.forward_agent = true
        n.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", RAM]
        end
        n.vm.provision :shell, :inline => <<END
        ## Just run once, first time box is deployed
        grep "#{IP} #{HOSTNAME}" /etc/hosts && exit 0
        echo "#{IP} #{HOSTNAME}" >> /etc/hosts
        apt-get update
END
        n.vm.synced_folder "application", "/home/vagrant/application"
    end
    config.vm.provision :chef_solo do |chef|
        # This path will be expanded relative to the project directory
        chef.add_recipe("basebox")
    end
end
