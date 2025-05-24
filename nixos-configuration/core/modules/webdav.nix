{ config, pkgs, lib, ... }:
{
  # Install the davfs2 package
  environment.systemPackages = with pkgs; [
    davfs2
  ];

  fileSystems."/mnt/webdav" = {
    device = "http://192.168.18.18/uploads";
    fsType = "davfs";
    options = [ 
      "rw"                # Чтение-запись
      "user"              # Разрешить пользователю монтировать
      "_netdev"           # Сетевое устройство
    ];
  };

  # Enable the davfs2 service
  services.davfs2.enable = true;

  # Path to SSH keys for agenix decryption
  age.identityPaths = [ "/etc/ssh/ssh_host_rsa_key" ];
  
  # Reference the agenix secret
  age.secrets.webdav = {
    file = "/home/talkingfoxmid/nix-state/secrets/webdav-credentials.age";
    path = "/etc/davfs2/secrets";
    mode = "0600";
  };

  # Переопределяем стандартную конфигурацию davfs2 для немедленной загрузки
  environment.etc."davfs2/davfs2.conf" = lib.mkForce {
    text = ''
      # Убираем задержку загрузки (по умолчанию 10 секунд!)
      delay_upload 0
      
      # Отключаем блокировки файлов
      use_locks 0
      
      # Уменьшаем кэш для быстрой синхронизации
      cache_size 50
      
      # Принудительная синхронизация при закрытии файла
      sync_on_close 1
      
      # Быстрое обновление метаданных
      dir_refresh 30
      file_refresh 30
      
      # Разумные таймауты
      connect_timeout 10
      read_timeout 30
    '';
  };
}