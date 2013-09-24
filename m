Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Sep 2013 20:40:34 +0200
Message-Id: <1380048034-13103-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add documentation for IPv6 translate
	feature
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

c760fb3c8029edf40657d283dc47af2fef9b3a6f ("batctl: Add support for IPv6 to
address resolver") added support for translating IPv6 addresses to mac adresses
but didn't update the documentation.

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README       | 12 +++++++-----
 man/batctl.8 | 20 ++++++++++----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/README b/README
index f3eb4b3..5af95c8 100644
--- a/README
+++ b/README
@@ -78,10 +78,10 @@ $ batctl statistics
 batctl translate
 ================
 
-Translates a destination (hostname, IPv4, MAC, bat_host-name) to the originator
-mac address responsible for it.
+Translates a destination (hostname, IPv4, IPv6, MAC, bat_host-name) to the
+originator mac address responsible for it.
 
-Usage: batctl translate mac|bat-host|host-name|IPv4-address
+Usage: batctl translate mac|bat-host|host-name|IP-address
 
 Example:
 
@@ -93,13 +93,15 @@ $ batctl translate 192.168.1.2
 02:ca:fe:af:fe:05
 $ batctl translate fe:fe:00:00:09:01
 02:ca:fe:af:fe:05
+$ batctl translate 2001::1
+02:ca:fe:af:fe:05
 
 batctl ping
 ============
 
 Sends a Layer 2 batman-adv ping to check round trip time and connectivity
 
-Usage: batctl ping [parameters] mac|bat-host|host-name|IPv4-address
+Usage: batctl ping [parameters] mac|bat-host|host-name|IP-address
 parameters:
          -c ping packet count
          -h print this help
@@ -125,7 +127,7 @@ batctl traceroute
 Traceroute sends 3 packets to each hop, awaits the answers and prints out the
 response times.
 
-Usage: batctl traceroute [parameters] mac|bat-host|host-name|IPv4-address
+Usage: batctl traceroute [parameters] mac|bat-host|host-name|IP-address
 
 Example:
 
diff --git a/man/batctl.8 b/man/batctl.8
index 157f96d..af2729b 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -201,9 +201,9 @@ List of debug tables:
 .RE
 .RE
 .br
-.IP "\fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIPv4_address\fP"
+.IP "\fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 
-Translates a destination (hostname, IPv4, MAC, bat_host-name) to the originator
+Translates a destination (hostname, IP, MAC, bat_host-name) to the originator
 mac address responsible for it.
 .br
 .IP "\fBstatistics\fP|\fBs\fP"
@@ -221,22 +221,22 @@ tt - translation table counters
 All counters without a prefix concern payload (pure user data) traffic.
 .RE
 .br
-.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIPv4_address\fP"
+.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
-not a MAC address. It can also try to guess the MAC address using an IPv4 address or a hostname when
-the IPv4 address was configured on top of the batman-adv interface of the destination device and both source and
-destination devices are in the same IPv4 subnet.
+not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
+the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
+destination devices are in the same IP subnet.
 The "\-c" option tells batctl how man pings should be sent before the program exits. Without the "\-c"
 option batctl will continue pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t" you can set the default
 interval between pings and the timeout time for replies, both in seconds. When run with "\-R", the route taken by the ping
 messages will be recorded. With "\-T" you can disable the automatic translation of a client MAC address to the originator
 address which is responsible for this client.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIPv4_address\fP"
+.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
-was not a MAC address. It can also try to guess the MAC address using an IPv4 address or a hostname when
-the IPv4 address was configured on top of the batman-adv interface of the destination device and both source and
-destination devices are in the same IPv4 subnet.
+was not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
+the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
+destination devices are in the same IP subnet.
 batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
 not replace the MAC addresses with bat\-host names in the output. With "\-T" you can disable the automatic translation
 of a client MAC address to the originator address which is responsible for this client.
-- 
1.8.4.rc3

