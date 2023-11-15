if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be executed as root or using sudo"
  exit 99
fi

systemd="$(ps --no-headers -o comm 1)"
if [ ! "${systemd}" = "systemd" ]; then
  echo "This system is not running systemd.  Exiting..."
  exit 100
fi

echo "Do you want to install ETC Softwares?"
read -r -p "$1 [y/N] " response < /dev/tty
if [[ $response =~ ^(yes|y|Y)$ ]]; then
    echo "Greats ! The installation has started."
else
    echo "OK. Exiting"
    exit
fi


pwd
ls
cd ~/Downloads

echo "TeamViewerQS indiriliyor..."

wget https://www.erybilisim.com/wp-content/vmwarehorizon/TeamViewerQS.tar.gz

echo "TeamViewerQS cikartiliyor ve kuruluyor..."

sudo tar -xvzf /home/ery/Downloads/TeamViewerQS.tar.gz

echo "TeamViewerQS kisayol olusturuluyor..."

cp /home/ery/Downloads/TeamViewerQS/teamviewerqs/teamviewer.desktop ~/Desktop
gio set ~/Desktop/teamviewer.desktop metadata::trusted true
chmod a+x ~/Desktop/teamviewer.desktop

echo "TeamViewerQS kurulumu tamamlandi."

pwd

echo "VMware Horizon Client indiriliyor..."

https://download3.vmware.com/software/CART24FQ3_LIN64_2309/VMware-Horizon-Client-2309-8.11.0-22660930.x64.bundle

echo "VMware Horizon Client cikartiliyor ve kuruluyor..."

echo "VMware Horizon Client kisayol olusturuluyor..."
cp /usr/share/applications/vmware-view.desktop ~/Desktop
gio set ~/Desktop/vmware-view.desktop metadata::trusted true
chmod a+x ~/Desktop/vmware-view.desktop

echo "VMware Horizon Client  kurulumu tamamlandi."

pwd