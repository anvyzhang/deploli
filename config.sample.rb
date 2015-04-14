set :bind, '0.0.0.0'
set :port, 4567

APPS = {
  'apps_abc1' => {
    'envs' => {
      'staging' => {
        'deploy' => 'cd ~/proj/apps_abc1 && mina stage=staging deploy',
        'start' => 'cd ~/proj/apps_abc1 && mina stage=staging unicorn:start',
        'stop' => 'cd ~/proj/apps_abc1 && mina stage=staging unicorn:stop',
        'restart' => 'cd ~/proj/apps_abc1 && mina stage=staging unicorn:restart',
      },
      'production' => {
        'deploy' => 'cd ~/proj/apps_abc1 && mina stage=production deploy',
        'start' => 'cd ~/proj/apps_abc1 && mina stage=production unicorn:start',
        'stop' => 'cd ~/proj/apps_abc1 && mina stage=production unicorn:stop',
        'restart' => 'cd ~/proj/apps_abc1 && mina stage=production unicorn:restart',
      },
    },
  },
  'apps_xyz2' => {
    'envs' => {
      'production' => {
        'deploy' => 'cd ~/proj/apps_xyz2 && cap production deploy',
        'start' => 'cd ~/proj/apps_xyz2 && cap production unicorn:start',
        'stop' => 'cd ~/proj/apps_xyz2 && cap production unicorn:stop',
        'restart' => 'cd ~/proj/apps_xyz2 && cap production unicorn:restart',
      },
    },
  },
}
