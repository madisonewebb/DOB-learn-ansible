Vagrant.require_version ">= 1.8.0"

# Load .env if present to populate ENV for provisioning
env_file = File.join(File.dirname(__FILE__), '.env')
if File.exist?(env_file)
  File.readlines(env_file).each do |line|
    line = line.strip
    next if line.empty? || line.start_with?('#')
    key, value = line.split('=', 2)
    next unless key && value
    ENV[key] ||= value
  end
end

Vagrant.configure(2) do |config|

  config.vm.box = "bento/ubuntu-20.04"

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "playbook.yaml"
    ansible.compatibility_mode = "2.0"
    # Pass the GitHub Personal Access Token from host environment
    ansible.extra_vars = {
      'github_pat' => ENV['GITHUB_PAT']
    }
  end
end