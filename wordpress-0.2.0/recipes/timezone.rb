include_recipe "ntp"

default_attributes(
  'ntp' => {
    'servers' => ['0.amazon.pool.ntp.org', '1.amazon.pool.ntp.org','2.amazon.pool.ntp.org', '3.amazon.pool.ntp.org', 'waztest.poo.ntp.org']
  }
)


