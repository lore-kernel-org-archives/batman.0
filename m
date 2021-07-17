Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4/9] batctl: man: Use native list support
Date: Sat, 17 Jul 2021 13:01:24 +0200
Message-Id: <20210717110129.25539-5-sven@narfation.org>
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

The lists were manually implemented by shifting the content to the right and
then adding a prefix to it. This turned out to be the source of various
errors which affected the whole document after the "list".

The .IP list macro can be used instead to simplify these kind of lists.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 110 +++++++++++++++++++++------------------------------
 1 file changed, 44 insertions(+), 66 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 39fac88..831a7e8 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -263,33 +263,24 @@ is printed.
 The local and global translation tables also support the "\-u" and "\-m" option to only display unicast or multicast translation table announcements respectively.
 
 List of debug tables:
-.RS 10
-\- neighbors|n
-.RE
-.RS 10
-\- originators|o
-.RE
-.RS 10
-\- gateways|gwl
-.RE
-.RS 10
-\- translocal|tl
-.RE
-.RS 10
-\- transglobal|tg
-.RE
-.RS 10
-\- claimtable|cl (compile time option)
-.RE
-.RS 10
-\- backbonetable|bbt (compile time option)
-.RE
-.RS 10
-\- dat_cache|dc (compile time option)
-.RE
-.RS 10
-\- mcast_flags|mf (compile time option)
-.RE
+.IP \(bu 2
+neighbors|n
+.IP \(bu 2
+originators|o
+.IP \(bu 2
+gateways|gwl
+.IP \(bu 2
+translocal|tl
+.IP \(bu 2
+transglobal|tg
+.IP \(bu 2
+claimtable|cl (compile time option)
+.IP \(bu 2
+backbonetable|bbt (compile time option)
+.IP \(bu 2
+dat_cache|dc (compile time option)
+.IP \(bu 2
+mcast_flags|mf (compile time option)
 .RE
 .br
 .br
@@ -303,45 +294,32 @@ the freeform debug tables or the native netlink messages.
 
 .RS 7
 List of available JSON queries:
-.RS 10
-\- bla_backbone_json|bbj
-.RE
-.RS 10
-\- bla_claim_json|clj
-.RE
-.RS 10
-\- dat_cache_json|dcj
-.RE
-.RS 10
-\- gateways_json|gwj
-.RE
-.RS 10
-\- hardif_json|hj
-.RE
-.RS 10
-\- hardifs_json|hj
-.RE
-.RS 10
-\- mcast_flags_json|mfj
-.RE
-.RS 10
-\- mesh_json|mj
-.RE
-.RS 10
-\- neighbors_json|nj
-.RE
-.RS 10
-\- originators_json|oj
-.RE
-.RS 10
-\- transtable_global_json|tgj
-.RE
-.RS 10
-\- transtable_local_json|tlj
-.RE
-.RS 10
-\- vlan_json|vj
-.RE
+.IP \(bu 2
+bla_backbone_json|bbj
+.IP \(bu 2
+bla_claim_json|clj
+.IP \(bu 2
+dat_cache_json|dcj
+.IP \(bu 2
+gateways_json|gwj
+.IP \(bu 2
+hardif_json|hj
+.IP \(bu 2
+hardifs_json|hj
+.IP \(bu 2
+mcast_flags_json|mfj
+.IP \(bu 2
+mesh_json|mj
+.IP \(bu 2
+neighbors_json|nj
+.IP \(bu 2
+originators_json|oj
+.IP \(bu 2
+transtable_global_json|tgj
+.IP \(bu 2
+transtable_local_json|tlj
+.IP \(bu 2
+vlan_json|vj
 .RE
 .TP
 [\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP
-- 
2.30.2

