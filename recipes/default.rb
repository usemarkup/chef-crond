if !node[:crond].empty?
  node[:crond].each do |name, config|
    configset = Chef::Mixin::DeepMerge.hash_only_merge(
      {
        'day' => '*',
        'hour' => "*",
        'minute' => "*",
        'user' => "root",
        'shell' => "/bin/bash",
        'environment' => { 'PATH' => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin" }
      },
      config
    )
  
    unless configset.has_key? 'command'
      raise "Config must include the command"
    end
  
    cron_d "#{name}" do
      command configset['command']
      day configset['day']
      hour configset['hour']
      minute configset['minute']
      user configset['user']
      shell configset['shell']
      environment configset['environment']
    end
  end
end
