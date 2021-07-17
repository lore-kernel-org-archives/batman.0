Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5/9] batctl: man: Use tbl groff preprocessor for tables
Date: Sat, 17 Jul 2021 13:01:25 +0200
Message-Id: <20210717110129.25539-6-sven@narfation.org>
In-Reply-To: <20210717110129.25539-1-sven@narfation.org>
References: <20210717110129.25539-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

Instead of emulating tables with manual identations, it is easier to just
use the groff standard preprocessor tbl to build a table and let it
automatically render.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 74 ++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 831a7e8..079cc0a 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -332,15 +332,17 @@ Retrieve traffic counters from batman-adv kernel module. The output may vary dep
 into the kernel module.
 .br
 Each module subsystem has its own counters which are indicated by their prefixes:
-.RS 15
-mgmt - mesh protocol counters
-.RE
-.RS 17
-tt - translation table counters
-.RE
-.RS 7
+.TS
+tab (@);
+r lx.
+mgmt@T{
+mesh protocol counters
+T}
+tt@T{
+translation table counters
+T}
+.TE
 All counters without a prefix concern payload (pure user data) traffic.
-.RE
 .TP
 [\fBmeshif <netdev>\fP] \fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
@@ -368,33 +370,37 @@ are available: To only print packets that match the compatibility number of batc
 option. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output. To filter
 the shown packet types you can either use "\-p" (dump only specified packet types) or "\-x" (dump all packet types
 except specified). The following packet types are available:
-.RS 17
-1 - batman ogm packets
-.RE
-.RS 17
-2 - batman icmp packets
-.RE
-.RS 17
-4 - batman unicast packets
-.RE
-.RS 17
-8 - batman broadcast packets
-.RE
-.RS 16
-16 - batman unicast tvlv packets
-.RE
-.RS 16
-32 - batman fragmented packets
-.RE
-.RS 16
-64 - batman tt / roaming packets
-.RE
-.RS 15
-128 - non batman packets
-.RE
-.RS 7
+
+.TS
+tab (@);
+r lx.
+1@T{
+batman ogm packets
+T}
+2@T{
+batman icmp packets
+T}
+4@T{
+batman unicast packets
+T}
+8@T{
+batman broadcast packets
+T}
+16@T{
+batman unicast tvlv packets
+T}
+32@T{
+batman fragmented packets
+T}
+64@T{
+batman tt / roaming packets
+T}
+128@T{
+non batman packets
+T}
+.TE
 Example: batctl td <interface> \-p 129 \-> only display batman ogm packets and non batman packets
-.RE
+
 .TP
 \fBbisect_iv\fP [\fB\-l MAC\fP][\fB\-t MAC\fP][\fB\-r MAC\fP][\fB\-s min\fP [\fB\- max\fP]][\fB\-o MAC\fP][\fB\-n\fP] \fBlogfile1\fP [\fBlogfile2\fP ... \fBlogfileN\fP]
 Analyses the B.A.T.M.A.N. IV logfiles to build a small internal database of all sent sequence numbers and routing table
-- 
2.30.2

