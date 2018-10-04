# This file has download function using NcFTP software.
# This file is for mac.
#
# Acquire files via FTP from public sites for each site
# Compression after completion of download
# If there is notification setting,
# use the crul command to Chatwork's room Post
#
# Download Path　~/Desktop/DownloadFile/
# Download File Path DownloadFile/SITENAME/DATE.zip
#
# Requirement
# NcFtp
#
# ncftp Syntax
# -u username / -p password / -R Recursive processing
# With ftp path with -R option set as directory will download per folder
# ncftpget -u USERNAME -p PASSWORD ftp://HOST/DIRNAME/FILENAME
# ncftpget -u USERNAME -p PASSWORD -R ftp://HOST/DIRNAME
############################################################


# Setting
############################################################
# FTP
# Syntax
# "SITENAME USERNAME PASSWORD HOST DOWNLOAD_DIR"
# When retrieving from "/" Do not specify DOWNLOAD_DIR
downloadsite=(
  # Example Path: RootDir/html/
  #'ExampleSite account_hoge pass_fuga exhosts.ne.jp html'

  # Example2 Path: RootDir
  #'ExampleSite2 account2_hoge pass2_fuga ex2hosts.ne.jp'
)

# End notification
# YES=0 / No=1
mgsFlag=0

# ChatWork Token
cwToken=""

# ChatWork RoomID
cwRoomId=""


# Download
##############################################################
# Start Message
read -p "Start of site data download processing? [y/N]" yn
sleep 2s

case $yn in
  [yY]* );;
  *) echo "Exit"; exit ;;
esac

# Change directory to Desktop
cd ~/Desktop

# Create directory
if [ -e DownloadFile ]; then
  # If backUpDownloadFile exists, delete it for initialization
  # Create directory for download file again
  rm -fr DownloadFile
  mkdir DownloadFile
else
  mkdir DownloadFile
fi

cd DownloadFile

# Main
for i in "${downloadsite[@]}"; do
  data=(${i[@]})
  name=${data[0]}
  user=${data[1]}
  pass=${data[2]}
  host=${data[3]}
  dir=${data[4]}

  # Create storage directory for each site
  mkdir $name
  cd $name
    # Get date (yyyymm)
    bkday=`date "+%Y%m"`
    mkdir $bkday
    cd $bkday

  # File Download
  ncftpget -u $user -p $pass -R ftp://$host/$dir

  cd ..

  # Compression file（Zip）
  # Delete download directory after compression
  zip -r -q $bkday $bkday
  rm -fr $bkday

  cd ..

done

# Post message to ChatWork
if [ "$mgsFlag" -gt 0 ]; then

  if [ -n "$cwToken" ] && [ -n "$cwRoomId" ]; then
    curl -X POST -H "X-ChatWorkToken:$cwToken" \
    -d "body=[info][title]Notification: AutoDownload[/title]Download Finish[/info]&self_unread=0" \
    "https://api.chatwork.com/v2/rooms/$cwRoomId/messages"
  else
    echo "Although it ended normally, it could not be sent to ChatWork."
    read -p "Please check the token and room ID setting."
  fi

else

  read -p "Download Finish [PressEnter]"
fi

exit
