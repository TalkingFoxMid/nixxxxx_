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

      # Увеличиваем размер кеша до 10GB для работы с большими файлами
      cache_size 10240

      # Принудительная синхронизация при закрытии файла
      sync_on_close 1

      # Быстрое обновление метаданных
      dir_refresh 30
      file_refresh 30

      # Разумные таймауты
      connect_timeout 10
      read_timeout 30

      # Автоматическая очистка кеша при достижении 80% от лимита
      cache_dir /tmp/davfs2
      backup_dir /tmp/davfs2/backup

      # Ограничиваем количество одновременно открытых файлов
      max_upload_attempts 3
      max_retry 3

      # Настройки для работы с большими файлами
      if_match_bug 1
      drop_weak_etags 1
      allow_cookie 1
      precheck 1
      ignore_dav_header 1
    '';
  };

  # Создание systemd сервиса для автоматической очистки кеша WebDAV
  systemd.services.webdav-cache-cleanup = {
    description = "Clean up WebDAV cache when it gets too large";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = pkgs.writeShellScript "webdav-cache-cleanup" ''
        #!/bin/bash

        CACHE_DIR="/tmp/davfs2"
        BACKUP_DIR="/tmp/davfs2/backup"
        MAX_CACHE_SIZE_MB=8192  # Очищаем при достижении 8GB (80% от 10GB)
        CRITICAL_CACHE_SIZE_MB=9216  # Критический размер 9GB (90% от 10GB)

        if [ -d "$CACHE_DIR" ]; then
          # Получаем размер кеша в мегабайтах
          CACHE_SIZE=$(du -sm "$CACHE_DIR" 2>/dev/null | cut -f1)

          if [ "$CACHE_SIZE" -gt "$CRITICAL_CACHE_SIZE_MB" ]; then
            echo "CRITICAL: WebDAV cache size ($CACHE_SIZE MB) is critically high! Aggressive cleanup..."

            # Агрессивная очистка - удаляем файлы старше 1 дня
            find "$CACHE_DIR" -type f -mtime +1 -delete 2>/dev/null || true
            find "$BACKUP_DIR" -type f -mtime +1 -delete 2>/dev/null || true

            # Удаляем большие файлы (больше 100MB) старше 12 часов
            find "$CACHE_DIR" -type f -size +100M -mmin +720 -delete 2>/dev/null || true

            echo "CRITICAL cleanup completed"

          elif [ "$CACHE_SIZE" -gt "$MAX_CACHE_SIZE_MB" ]; then
            echo "WebDAV cache size ($CACHE_SIZE MB) exceeds limit ($MAX_CACHE_SIZE_MB MB). Cleaning up..."

            # Обычная очистка - удаляем файлы старше 3 дней
            find "$CACHE_DIR" -type f -mtime +3 -delete 2>/dev/null || true
            find "$BACKUP_DIR" -type f -mtime +2 -delete 2>/dev/null || true

            echo "Regular cleanup completed"
          fi

          # Удаляем пустые директории в любом случае
          find "$CACHE_DIR" -type d -empty -delete 2>/dev/null || true
        fi
      '';
    };
  };

  # Systemd timer для запуска очистки кеша каждые 30 минут
  systemd.timers.webdav-cache-cleanup = {
    description = "Timer for WebDAV cache cleanup";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/10";  # Каждые 10 минут для активного использования
      Persistent = true;
      RandomizedDelaySec = "5m";  # Добавляем случайную задержку до 5 минут
    };
  };

  # Создание директорий кеша при загрузке системы
  systemd.tmpfiles.rules = [
    "d /tmp/davfs2 0755 root root -"
    "d /tmp/davfs2/backup 0755 root root -"
  ];

  # Экстренный сервис для немедленной очистки кеша
  systemd.services.webdav-emergency-cleanup = {
    description = "Emergency WebDAV cache cleanup";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = pkgs.writeShellScript "webdav-emergency-cleanup" ''
        #!/bin/bash

        CACHE_DIR="/tmp/davfs2"
        BACKUP_DIR="/tmp/davfs2/backup"

        echo "Emergency cleanup: Clearing ALL WebDAV cache..."

        # Останавливаем WebDAV монтирование
        umount /mnt/webdav 2>/dev/null || true

        # Полная очистка кеша
        rm -rf "$CACHE_DIR"/* 2>/dev/null || true
        rm -rf "$BACKUP_DIR"/* 2>/dev/null || true

        # Пересоздаем директории
        mkdir -p "$CACHE_DIR" "$BACKUP_DIR"

        # Перемонтируем WebDAV
        mount /mnt/webdav 2>/dev/null || true

        echo "Emergency cleanup completed"
      '';
    };
  };
}