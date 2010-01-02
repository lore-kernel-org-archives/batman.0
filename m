Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  2 Jan 2010 18:51:46 +0100
Message-Id: <1262454706-6137-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
References: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman: Correct typographical errors
	detected by lintian
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

Debian's Lintian detected different smaller typographical errors in the source
code and manpages of batctl.

 * seperate -> separate
 * orginator -> originator
 * modus -> mode
 * deamon -> daemon

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/man/batmand.8 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batman/man/batmand.8 b/batman/man/batmand.8
index 8801a33..dd2c970 100644
--- a/batman/man/batmand.8
+++ b/batman/man/batmand.8
@@ -66,7 +66,7 @@ Note that debug level 5 can be disabled at compile time.
 .RE
 .TP
 .B \-g gateway class
-The gateway class is used to tell other nodes in the network your available internet bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the daemon will guess your appropriate gateway class. Use "/" to seperate the down\(hy and upload rates. You can omit the upload rate and batmand will assume an upload of download / 5.
+The gateway class is used to tell other nodes in the network your available internet bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the daemon will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload rate and batmand will assume an upload of download / 5.
 .RS 17
 default: 0 \-> gateway disabled
 .RE
@@ -85,7 +85,7 @@ allowed values: 5000
 .TP
 .B \-H verbose help
 .TP
-.B \-o orginator interval in ms
+.B \-o originator interval in ms
 A node transmits broadcast messages (we call them originator message or OGM) to inform the neighboring nodes about it's existence.
 Originator interval is the time to wait after sending one message and before sending the next message. The default value is 1000 ms (1 second).
 In a mobile network, you may want to detect network changes very quickly, so you need to send message very often, for example, use a value of 500 ms.
@@ -93,10 +93,10 @@ In a static network, you can save bandwidth by using a higher value.
 This option is only available in daemon mode.
 .TP
 .B \-p preferred gateway
-Set the internet gateway by yourself. Note: This automatically switches your daemon to "internet search modus" with "\-r 1" unless "\-r" is given. If the preferred gateway is not found the gateway selection will use the current routing class to choose a gateway.
+Set the internet gateway by yourself. Note: This automatically switches your daemon to "internet search mode" with "\-r 1" unless "\-r" is given. If the preferred gateway is not found the gateway selection will use the current routing class to choose a gateway.
 .TP
 .B \-r routing class
-The routing class can be set to four values \(hy it enables "internet search modus". The deamon will choose an internet gateway based on certain criteria (unless "\-p" is specified):
+The routing class can be set to four values \(hy it enables "internet search mode". The daemon will choose an internet gateway based on certain criteria (unless "\-p" is specified):
 .RS 17
 default: 0 \-> set no default route
 .RE
-- 
1.6.5.7

