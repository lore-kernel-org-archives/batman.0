Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  4 Jun 2011 11:26:00 +0200
Message-Id: <1307179560-24626-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Use enums for related constants
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
To: b.a.t.m.a.n@lists.open-mesh.org

CodingStyle "Chapter 12: Macros, Enums and RTL" recommends to use enums
for several related constants. Internal states can be used without
defining the actual value, but all values which are visible to the
outside must be defined as before. Normal values are assigned as usual
and flags are defined by shifts of a bit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
These patches are based on ordex's patches to reduce the amount of rebase
related heart attacks for him.


 hard-interface.h |   14 ++++++-----
 main.h           |   18 +++++++++-----
 packet.h         |   65 +++++++++++++++++++++++++++++++++--------------------
 3 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/hard-interface.h b/hard-interface.h
index 79e25cb..442eacb 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -22,12 +22,14 @@
 #ifndef _NET_BATMAN_ADV_HARD_INTERFACE_H_
 #define _NET_BATMAN_ADV_HARD_INTERFACE_H_
 
-#define IF_NOT_IN_USE 0
-#define IF_TO_BE_REMOVED 1
-#define IF_INACTIVE 2
-#define IF_ACTIVE 3
-#define IF_TO_BE_ACTIVATED 4
-#define IF_I_WANT_YOU 5
+enum hard_if_state {
+	IF_NOT_IN_USE,
+	IF_TO_BE_REMOVED,
+	IF_INACTIVE,
+	IF_ACTIVE,
+	IF_TO_BE_ACTIVATED,
+	IF_I_WANT_YOU
+};
 
 extern struct notifier_block hard_if_notifier;
 
diff --git a/main.h b/main.h
index 82cf523..7fbda20 100644
--- a/main.h
+++ b/main.h
@@ -80,9 +80,11 @@
 #define RESET_PROTECTION_MS 30000
 #define EXPECTED_SEQNO_RANGE	65536
 
-#define MESH_INACTIVE 0
-#define MESH_ACTIVE 1
-#define MESH_DEACTIVATING 2
+enum mesh_state {
+	MESH_INACTIVE,
+	MESH_ACTIVE,
+	MESH_DEACTIVATING
+};
 
 #define BCAST_QUEUE_LEN		256
 #define BATMAN_QUEUE_LEN	256
@@ -97,10 +99,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 /* all messages related to routing / flooding / broadcasting / etc */
-#define DBG_BATMAN 1
-#define DBG_ROUTES 2	/* route added / changed / deleted */
-#define DBG_TT 4	/* translation table operations */
-#define DBG_ALL 7
+enum dbg_level {
+	DBG_BATMAN = 1 << 0,
+	DBG_ROUTES = 1 << 1, /* route added / changed / deleted */
+	DBG_TT	   = 1 << 2, /* translation table operations */
+	DBG_ALL    = 7
+};
 
 
 /*
diff --git a/packet.h b/packet.h
index 5e3e778..0c3e44d 100644
--- a/packet.h
+++ b/packet.h
@@ -24,44 +24,59 @@
 
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
-#define BAT_PACKET       0x01
-#define BAT_ICMP         0x02
-#define BAT_UNICAST      0x03
-#define BAT_BCAST        0x04
-#define BAT_VIS          0x05
-#define BAT_UNICAST_FRAG 0x06
-#define BAT_TT_QUERY     0x07
-#define BAT_ROAM_ADV     0x08
+enum bat_packettype {
+	BAT_PACKET       = 0x01,
+	BAT_ICMP         = 0x02,
+	BAT_UNICAST      = 0x03,
+	BAT_BCAST        = 0x04,
+	BAT_VIS          = 0x05,
+	BAT_UNICAST_FRAG = 0x06,
+	BAT_TT_QUERY     = 0x07,
+	BAT_ROAM_ADV     = 0x08
+};
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 14
-#define DIRECTLINK 0x40
-#define VIS_SERVER 0x20
-#define PRIMARIES_FIRST_HOP 0x10
+
+enum batman_flags {
+	PRIMARIES_FIRST_HOP = 1 << 4,
+	VIS_SERVER	    = 1 << 5,
+	DIRECTLINK	    = 1 << 6
+};
 
 /* ICMP message types */
-#define ECHO_REPLY 0
-#define DESTINATION_UNREACHABLE 3
-#define ECHO_REQUEST 8
-#define TTL_EXCEEDED 11
-#define PARAMETER_PROBLEM 12
+enum icmp_packettype {
+	ECHO_REPLY		= 0,
+	DESTINATION_UNREACHABLE = 3,
+	ECHO_REQUEST		= 8,
+	TTL_EXCEEDED		= 11,
+	PARAMETER_PROBLEM	= 12
+};
 
 /* vis defines */
-#define VIS_TYPE_SERVER_SYNC		0
-#define VIS_TYPE_CLIENT_UPDATE		1
+enum vis_packettype {
+	VIS_TYPE_SERVER_SYNC   = 0,
+	VIS_TYPE_CLIENT_UPDATE = 1
+};
 
 /* fragmentation defines */
-#define UNI_FRAG_HEAD 0x01
-#define UNI_FRAG_LARGETAIL 0x02
+enum unicast_frag_flags {
+	UNI_FRAG_HEAD	   = 1 << 0,
+	UNI_FRAG_LARGETAIL = 1 << 1
+};
 
 /* TT_QUERY flags */
-#define TT_RESPONSE     0x01
-#define TT_REQUEST      0x02
-#define TT_FULL_TABLE   0x04
+enum tt_query_flags {
+	TT_RESPONSE   = 1 << 0,
+	TT_REQUEST    = 1 << 1,
+	TT_FULL_TABLE = 1 << 2
+};
 
 /* TT_CHANGE flags */
-#define TT_CHANGE_DEL   0x01
-#define TT_CLIENT_ROAM  0x02
+enum tt_change_flags {
+	TT_CHANGE_DEL  = 0x01,
+	TT_CLIENT_ROAM = 0x02
+};
 
 struct batman_packet {
 	uint8_t  packet_type;
-- 
1.7.5.3

