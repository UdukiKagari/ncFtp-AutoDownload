# ncFtp-autoDownload

This file has download function using NcFTP software.
This file is for mac.

## Description
Based on the information you have set up, download the website data file by directory via FTP connection.
The download file is saved on the desktop and compressed with the filename of the execution month and day.
By setting chat work token and room ID, you can post a completion notice to the specified room.

## Requirement
- NcFTP

## Requirement Install
It is assumed that homebrew is installed...
```
brew install ncftp
```

## Usage
1.Open the command file with a text editor.

2.Configuration ftp data(Multiple setting possible).
```
# Syntax
# 'SITENAME USERNAME PASSWORD HOST DOWNLOAD_DIR'

downloadsite=(
  # Example Path: RootDir/html/
  #'ExampleSite account_hoge pass_fuga exhosts.ne.jp html'

  # Example2 Path: RootDir
  #'ExampleSite2 account2_hoge pass2_fuga ex2hosts.ne.jp'

)
```

3.To set the end notification, change the flag to 1 and set the API token and room ID.
```
mgsFlag=1

# Chatwork Token
cwToken="xxxxxxxxxxxxxxxxxxxx"

# Room ID
cwRoomId="0123456789"
```

4.When you finish setting, save and execute the command file.

## Author
@UdukiKagari
