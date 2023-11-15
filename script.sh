if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be executed as root or using sudo"
  exit 99
fi

systemd="$(ps --no-headers -o comm 1)"
if [ ! "${systemd}" = "systemd" ]; then
  echo "This system is not running systemd.  Exiting..."
  exit 100
fi

pwd
ls
cd ~/Downloads
