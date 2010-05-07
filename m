Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:31 +0200
Message-Id: <1273261651-21378-27-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 26/26] Staging: batman-adv: updating README
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/README |  275 +++++++++++++++++++++++--------------
 1 files changed, 173 insertions(+), 102 deletions(-)

diff --git a/drivers/staging/batman-adv/README b/drivers/staging/batman-adv/README
index e2a7271..14244a2 100644
--- a/drivers/staging/batman-adv/README
+++ b/drivers/staging/batman-adv/README
@@ -1,169 +1,240 @@
-[state: 22-03-2010]
+[state: 03-05-2010]
 
 BATMAN-ADV
 ----------
 
-Batman-advanced is a new approach to wireless networking which does no longer
-operate on the IP basis. Unlike B.A.T.M.A.N, which exchanges information
-using UDP packets and sets routing tables, batman-advanced operates on ISO/OSI
-Layer 2 only and uses and routes (or better: bridges) Ethernet Frames. It
-emulates a virtual network switch of all nodes participating. Therefore all
-nodes appear to be link local, thus all higher operating protocols won't be
-affected by any changes within the network. You can run almost any protocol
-above B.A.T.M.A.N. Advanced, prominent examples are: IPv4, IPv6, DHCP, IPX.
+Batman  advanced  is  a new approach to wireless networking which
+does no longer operate on the IP basis. Unlike the batman daemon,
+which  exchanges  information  using UDP packets and sets routing
+tables, batman-advanced operates on ISO/OSI Layer 2 only and uses
+and  routes  (or  better: bridges) Ethernet Frames. It emulates a
+virtual network switch of all nodes participating.  Therefore all
+nodes  appear  to be link local, thus all higher operating proto-
+cols won't be affected by any changes within the network. You can
+run almost any protocol above batman advanced, prominent examples
+are: IPv4, IPv6, DHCP, IPX.
 
-This is batman-advanced implemented as Linux kernel driver. It does not depend
-on any network (other) driver, and can be used on wifi as well as ethernet,
-vpn, etc ... (anything with ethernet-style layer 2).
+Batman advanced was implemented as a Linux kernel driver  to  re-
+duce the overhead to a minimum. It does not depend on any (other)
+network driver, and can be used on wifi as well as ethernet  lan,
+vpn,  etc ... (anything with ethernet-style layer 2).
 
-USAGE
------
+CONFIGURATION
+-------------
 
-insmod the batman-adv.ko in your kernel:
+Load the batman-adv module into your kernel:
 
 # insmod batman-adv.ko
 
-the module is now waiting for activation. You must add some interfaces
-on which batman can operate. Each interface must be added separately:
+The  module  is now waiting for activation. You must add some in-
+terfaces on which batman can operate. After  loading  the  module
+batman  advanced  will scan your systems interfaces to search for
+compatible interfaces. Once found, it will create  subfolders  in
+the /sys directories of each supported interface, e.g.
 
-# echo wlan0 > /proc/net/batman-adv/interfaces
+# ls /sys/class/net/eth0/batman_adv/
+# iface_status  mesh_iface
 
-( # echo wlan1 > /proc/net/batman-adv/interfaces )
-( # echo eth0 > /proc/net/batman-adv/interfaces )
-( ... )
+If an interface does not have the "batman_adv" subfolder it prob-
+ably is not supported. Not supported  interfaces  are:  loopback,
+non-ethernet and batman's own interfaces.
 
-Now batman starts broadcasting on this interface.
-You can now view the table of originators (mesh participants) with:
+Note:  After the module was loaded it will continuously watch for
+new interfaces to verify the compatibility. There is no  need  to
+reload the module if you plug your USB wifi adapter into your ma-
+chine after batman advanced was initially loaded.
 
-# cat /proc/net/batman-adv/originators
+To activate a  given  interface  simply  write  "bat0"  into  its
+"mesh_iface" file inside the batman_adv subfolder:
 
-The module will create a new interface "bat0", which can be used as a
-regular interface:
+# echo bat0 > /sys/class/net/eth0/batman_adv/mesh_iface
 
-# ifconfig bat0 inet 192.168.0.1 up
-# ping 192.168.0.2
-...
+Repeat  this step for all interfaces you wish to add.  Now batman
+starts using/broadcasting on this/these interface(s).
 
----
-If you want topology visualization, your meshnode must be configured
-as VIS-server:
+By reading the "iface_status" file you can check its status:
 
-# echo "server" > /proc/net/batman-adv/vis_server
+# cat /sys/class/net/eth0/batman_adv/iface_status
+# active
 
-Each node is either configured as "server" or as "client" (default:
-"client"). Clients send their topology data to the server next to them,
-and server synchronize with other servers. If there is no server
-configured (default) within the mesh, no topology information will be
-transmitted. With these "synchronizing servers", there can be 1 or
-more vis servers sharing the same (or at least very similar) data.
+To deactivate an interface you have  to  write  "none"  into  its
+"mesh_iface" file:
 
-When configured as server, you can get a topology snapshot of your mesh:
+# echo none > /sys/class/net/eth0/batman_adv/mesh_iface
 
-# cat /proc/net/batman-adv/vis_data
 
-This raw output is intended to be easily parsable and convertable with
-other tools. Have a look at the batctl README if you want a vis output
-in dot or json format for instance and how those outputs could then be
-visualised in an image.
+All  mesh  wide  settings  can be found in batman's own interface
+folder:
+
+#  ls  /sys/class/net/bat0/mesh/
+#  aggregate_ogm   originators        transtable_global  vis_mode
+#  orig_interval   transtable_local   vis_data
+
+
+Some of the files contain all sort of status information  regard-
+ing  the  mesh  network.  For  example, you can view the table of
+originators (mesh participants) with:
+
+# cat /sys/class/net/bat0/mesh/originators
+
+Other files allow to change batman's behaviour to better fit your
+requirements.  For instance, you can check the current originator
+interval (value in milliseconds which determines how often batman
+sends its broadcast packets):
+
+# cat /sys/class/net/bat0/mesh/orig_interval
+# status: 1000
+
+and also change its value:
+
+# echo 3000 > /sys/class/net/bat0/mesh/orig_interval
 
-The raw format consists of comma seperated values per entry where each
-entry is giving information about a certain source interface. Each entry
-can/has to have the following values:
--> "mac" -> mac address of an originator's source interface
-           (each line begins with it)
--> "TQ mac value" -> src mac's link quality towards mac address of a neighbor
-                     originator's interface which is being used for routing
--> "HNA mac" -> HNA announced by source mac
--> "PRIMARY" -> this is a primary interface
--> "SEC mac" -> secondary mac address of source (requires preceeding
--> PRIMARY)
-
-The TQ value has a range from 4 to 255 with 255 being the best.
-The HNA entries are showing which hosts are connected to the mesh via bat0
-or being bridged into the mesh network.
-The PRIMARY/SEC values are only applied on primary interfaces
-
----
 In very mobile scenarios, you might want to adjust the originator
-interval to a lower value. This will make the mesh more responsive to
-topology changes, but will also increase the overhead. Please make sure
-that all nodes in your mesh use the same interval. The default value
-is 1000 ms (1 second).
+interval to a lower value. This will make the mesh  more  respon-
+sive to topology changes, but will also increase the overhead.
+
+
+USAGE
+-----
+
+To  make use of your newly created mesh, batman advanced provides
+a new interface "bat0" which you should use from this  point  on.
+All  interfaces  added  to  batman  advanced are not relevant any
+longer because batman handles them for you. Basically, one "hands
+over" the data by using the batman interface and batman will make
+sure it reaches its destination.
 
-# echo 1000 > /proc/net/batman-adv/orig_interval
+The "bat0" interface can be used like any  other  regular  inter-
+face.  It needs an IP address which can be either statically con-
+figured or dynamically (by using DHCP or similar services):
 
-To deactivate batman, do:
+# NodeA: ifconfig bat0 192.168.0.1
+# NodeB: ifconfig bat0 192.168.0.2
+# NodeB: ping 192.168.0.1
+
+Note:  In  order to avoid problems remove all IP addresses previ-
+ously assigned to interfaces now used by batman advanced, e.g.
+
+# ifconfig eth0 0.0.0.0
+
+
+VISUALIZATION
+-------------
+
+If you want topology visualization, at least one mesh  node  must
+be configured as VIS-server:
+
+# echo "server" > /sys/class/net/bat0/mesh/vis_mode
+
+Each  node  is  either configured as "server" or as "client" (de-
+fault: "client").  Clients send their topology data to the server
+next to them, and server synchronize with other servers. If there
+is no server configured (default) within the  mesh,  no  topology
+information   will  be  transmitted.  With  these  "synchronizing
+servers", there can be 1 or more vis servers sharing the same (or
+at least very similar) data.
+
+When  configured  as  server,  you can get a topology snapshot of
+your mesh:
+
+# cat /sys/class/net/bat0/mesh/vis_data
+
+This raw output is intended to be easily parsable and convertable
+with  other tools. Have a look at the batctl README if you want a
+vis output in dot or json format for instance and how those  out-
+puts could then be visualised in an image.
+
+The raw format consists of comma separated values per entry where
+each entry is giving information about a  certain  source  inter-
+face.  Each  entry can/has to have the following values:
+-> "mac" - mac address of an originator's source interface
+           (each line begins with it)
+-> "TQ mac  value"  -  src mac's link quality towards mac address
+                       of a neighbor originator's interface which
+                       is being used for routing
+-> "HNA mac" - HNA announced by source mac
+-> "PRIMARY" - this  is a primary interface
+-> "SEC mac" - secondary mac address of source
+               (requires preceding PRIMARY)
+
+The TQ value has a range from 4 to 255 with 255 being  the  best.
+The HNA entries are showing which hosts are connected to the mesh
+via bat0 or being bridged into the mesh network.  The PRIMARY/SEC
+values are only applied on primary interfaces
 
-# echo "" > /proc/net/batman-adv/interfaces
 
 LOGGING/DEBUGGING
 -----------------
 
-All error messages, warnings and information messages are sent to the
-kernel log. Depending on your operating system distribution this can be
-read in one of a number of ways. Try using the commands: dmesg,
-logread, or looking in the files /var/log/kern.log or
-/var/log/syslog. All batman-adv messages are prefixed with
+All error messages, warnings and information messages are sent to
+the kernel log. Depending on your operating  system  distribution
+this  can  be read in one of a number of ways. Try using the com-
+mands: dmesg, logread, or looking in the files  /var/log/kern.log
+or  /var/log/syslog.  All  batman-adv  messages are prefixed with
 "batman-adv:" So to see just these messages try
 
-dmesg | grep batman-adv
+# dmesg | grep batman-adv
 
-When investigating problems with your mesh network it is sometimes
-necessary to see more detail debug messages. This must be enabled when
-compiling the batman-adv module. Use "make menuconfig" and enable the
+When investigating problems with your mesh network  it  is  some-
+times  necessary  to see more detail debug messages. This must be
+enabled when compiling the batman-adv module. When building  bat-
+man-adv  as  part of kernel, use "make menuconfig" and enable the
 option "B.A.T.M.A.N. debugging".
 
-The additional debug output is by default disabled. It can be enabled
-either at kernel module load time or during run time. To enable debug
-output at module load time, add the module parameter debug=<value>.
-<value> can take one of four values.
+The additional debug output is by default disabled. It can be en-
+abled  either  at kernel modules load time or during run time. To
+enable debug output at module load time, add the module parameter
+debug=<value>.  <value> can take one of four values.
 
-0 - All debug output disabled
+0 - All  debug  output  disabled
 1 - Enable messages related to routing / flooding / broadcasting
 2 - Enable route or hna added / changed / deleted
 3 - Enable all messages
 
 e.g.
 
-modprobe batman-adv debug=2
+# modprobe batman-adv debug=2
 
-will load the module and enable debug messages for when routes or HNAs
-change.
+will load the module and enable debug messages for when routes or
+HNAs change.
 
-The debug output can also be changed at runtime using the file
+The debug output can also be changed at runtime  using  the  file
 /sys/module/batman-adv/parameters/debug. e.g.
 
-echo 2 > /sys/module/batman-adv/parameters/debug
+# echo 2 > /sys/module/batman-adv/parameters/debug
 
 enables debug messages for when routes or HNAs
 
-The debug output is sent to the kernel logs. So try dmesg, logread etc
-to see the debug messages.
+The  debug  output  is sent to the kernel logs. So try dmesg, lo-
+gread, etc to see the debug messages.
+
 
 BATCTL
 ------
 
-B.A.T.M.A.N.  advanced operates on layer 2 and thus all hosts
-participating in the virtual switch are completely transparent for all
-protocols above layer 2. Therefore the common diagnosis tools do not
-work as expected. To overcome these problems batctl was created. At
-the moment the batctl contains ping, traceroute, tcpdump and
+As batman advanced operates on layer 2 all hosts participating in
+the  virtual switch are completely transparent for all  protocols
+above layer 2. Therefore the common diagnosis tools do  not  work
+as  expected.  To  overcome these problems batctl was created. At
+the  moment the  batctl contains ping,  traceroute,  tcpdump  and
 interfaces to the kernel module settings.
 
 For more information, please see the manpage (man batctl).
 
-batctl is available on http://www.open-mesh.net/
+batctl is available on http://www.open-mesh.org/
+
 
 CONTACT
 -------
 
 Please send us comments, experiences, questions, anything :)
 
-IRC:             #batman on irc.freenode.org
-Mailing-list:    b.a.t.m.a.n@open-mesh.net
-(subscription at https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n )
+IRC:            #batman   on   irc.freenode.org
+Mailing-list:   b.a.t.m.a.n@open-mesh.net (optional  subscription
+          at https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
 
 You can also contact the Authors:
 
-Marek Lindner <lindner_marek@yahoo.de>
-Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
+Marek  Lindner  <lindner_marek@yahoo.de>
+Simon  Wunderlich  <siwu@hrz.tu-chemnitz.de>
+
-- 
1.7.1

