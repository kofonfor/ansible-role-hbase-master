Eye.application 'hbase-master-{{ env_name }}' do
  working_dir '/etc/eye'
  stdall '/var/log/eye/hbase-master-{{ env_name }}-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes
  uid "{{ hadoop_user }}"

  process :master_{{ env_name }} do
    pid_file '{{ hbase_var_prefix }}/hbase_master.pid'
    start_command '{{ hbase_distr_prefix }}/bin/hbase master start'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
