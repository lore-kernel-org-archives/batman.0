Return-Path: <andrew.lunn@ascom.ch>
Date: Fri, 17 Jul 2009 20:46:14 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090717184614.GE4656@ma.tech.ascom.ch>
References: <20090717172521.GB4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090717172521.GB4656@ma.tech.ascom.ch>
Subject: [B.A.T.M.A.N.] [batman-adv v2] packet.h coding style cleanup
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make packet.h clean with respect to the 2.6.29 checkpatch script.
Also adds one macro, BAT_PACKET_LEN, which is used in other patches
to follow.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: packet.h
===================================================================
--- packet.h	(revision 1349)
+++ packet.h	(working copy)
@@ -17,8 +17,6 @@
  *
  */
 
-
-
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
 #define BAT_PACKET    0x01
@@ -32,7 +30,6 @@
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 
-
 /* ICMP message types */
 #define ECHO_REPLY 0
 #define DESTINATION_UNREACHABLE 3
@@ -40,13 +37,11 @@
 #define TTL_EXCEEDED 11
 #define PARAMETER_PROBLEM 12
 
-
 /* vis defines */
 #define VIS_TYPE_SERVER_SYNC		0
 #define VIS_TYPE_CLIENT_UPDATE		1
 
-struct batman_packet
-{
+struct batman_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
@@ -58,11 +53,12 @@
 	uint8_t  num_hna;
 } __attribute__((packed));
 
-struct icmp_packet
-{
+#define BAT_PACKET_LEN sizeof(struct batman_packet)
+
+struct icmp_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  msg_type;   /* see ICMP message types above */
+	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  ttl;
 	uint8_t  dst[6];
 	uint8_t  orig[6];
@@ -70,31 +66,29 @@
 	uint8_t  uid;
 } __attribute__((packed));
 
-struct unicast_packet
-{
+struct unicast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  dest[6];
 	uint8_t  ttl;
 } __attribute__((packed));
 
-struct bcast_packet
-{
+struct bcast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  orig[6];
 	uint16_t seqno;
 } __attribute__((packed));
 
-struct vis_packet
-{
+struct vis_packet {
 	uint8_t  packet_type;
-	uint8_t  version;  			/* batman version field */
-	uint8_t  vis_type;			/* which type of vis-participant sent this? */
-	uint8_t  seqno;				/* sequence number */
-	uint8_t  entries;			/* number of entries behind this struct */
-	uint8_t  ttl;				/* TTL */
-	uint8_t  vis_orig[6];		/* originator that informs about its neighbours */
-	uint8_t  target_orig[6];	/* who should receive this packet */
-	uint8_t  sender_orig[6];	/* who sent or rebroadcasted this packet */
+	uint8_t  version;        /* batman version field */
+	uint8_t  vis_type;	 /* which type of vis-participant sent this? */
+	uint8_t  seqno;		 /* sequence number */
+	uint8_t  entries;	 /* number of entries behind this struct */
+	uint8_t  ttl;		 /* TTL */
+	uint8_t  vis_orig[6];	 /* originator that informs about its
+				  * neighbours */
+	uint8_t  target_orig[6]; /* who should receive this packet */
+	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __attribute__((packed));
