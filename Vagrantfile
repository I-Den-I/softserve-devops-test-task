Vagrant.configure("2") do |config|
  # Apple Silicon or Intel/AMD
  is_arm = RUBY_PLATFORM.include?("arm64") || RUBY_PLATFORM.include?("aarch64")

  if is_arm
    # bento/debian12 for arm64
    config.vm.box = "bento/debian-12"
  else
    # standart box for x64 
    config.vm.box = "generic/debian12"
  end

  # arm64
  config.vm.provider "vmware_desktop" do |v|
    v.gui = false
    v.cpus = 2
    v.memory = 4096
    v.vmx["ethernet0.virtualDev"] = "vmxnet3" if is_arm
  end

  # x86_64
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.memory = 4096
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  # network
  if is_arm
    config.vm.network "forwarded_port", guest: 8200, host: 8200 # Vault 
    config.vm.network "forwarded_port", guest: 8080, host: 8080 # Jenkins
    config.vm.network "forwarded_port", guest: 80, host: 8081   # Zabbix 
  else
    config.vm.network "private_network", ip: "192.168.56.10"
  end

  # Ansible Local
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.install = true
    ansible.compatibility_mode = "2.0"
  end
end