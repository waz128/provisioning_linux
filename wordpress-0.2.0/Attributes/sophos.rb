


default['smbfs']['mounts']['/mnt/sophos-share'] =
  {
    'cifs_path' => '//apse2-0001sec.aws.server-noc.com/APSE2SophosUpdates',
    'username' => 'savaws',
    'password' => '88837cm20ncmMNC-3&^@)C',
    'options' =>
      {
        'rw' => nil,
        'dir_mode' => '0755',
        'file_mode' => '0755',
        'noserverino' => nil,
        'uid' => 'root',
        'gid' => 'root'
      }
  }
