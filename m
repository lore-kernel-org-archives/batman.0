Return-Path: <andrew.lunn@ascom.ch>
Date: Wed, 19 Aug 2009 21:42:43 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090819194243.GJ20229@ma.tech.ascom.ch>
References: <20090819183556.GI20229@ma.tech.ascom.ch>
	<200908192038.58775.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <200908192038.58775.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] tcpdump patch for batman-adv
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2009 at 08:38:53PM +0200, Sven Eckelmann wrote:
> > Attached is a patch for tcpdump which adds support for dissecting
> > batman-adv messages.
> I think you've forgot to attach it.

Grrr. I keep saying i will write an extension to mutt so that it
searches for the pattern *[Aa]ttach* and complains if there is none...

         Andrew

--WIyZ46R2i8wDzkSu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="tcpdump.diff"

diff --git a/Makefile.in b/Makefile.in
index 633c59d..cfe9852 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -70,6 +70,7 @@ CSRC =	addrtoname.c af.c checksum.c cpack.c gmpls.c oui.c gmt2local.c ipproto.c
         nlpid.c l2vpn.c machdep.c parsenfsfh.c \
 	print-802_11.c print-ap1394.c print-ah.c print-arcnet.c \
 	print-aodv.c print-arp.c print-ascii.c print-atalk.c print-atm.c \
+	print-batman.c \
 	print-beep.c print-bfd.c print-bgp.c print-bootp.c print-bt.c \
 	print-cdp.c print-cfm.c print-chdlc.c print-cip.c print-cnfp.c \
 	print-dccp.c print-decnet.c \
@@ -115,6 +116,7 @@ HDR = \
 	arcnet.h \
 	atm.h \
 	atmuni31.h \
+	batman.h \
 	bootp.h \
 	bgp.h \
 	chdlc.h \
diff --git a/batman.h b/batman.h
new file mode 100644
index 0000000..2e802bb
--- /dev/null
+++ b/batman.h
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Marek Lindner, Simon Wunderlich
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that: (1) source code distributions
+ * retain the above copyright notice and this paragraph in its entirety, (2)
+ * distributions including binary code include the above copyright notice and
+ * this paragraph in its entirety in the documentation or other materials
+ * provided with the distribution, and (3) all advertising materials mentioning
+ * features or use of this software display the following acknowledgement:
+ * ``This product includes software developed by Paolo Abeni.''
+ * The name of author may not be used to endorse or promote products derived
+ * from this software without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
+
+#define BAT_PACKET    0x01
+#define BAT_ICMP      0x02
+#define BAT_UNICAST   0x03
+#define BAT_BCAST     0x04
+#define BAT_VIS       0x05
+
+/* ICMP message types */
+
+#define COMPAT_VERSION 7
+
+struct batman_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  flags;
+#define DIRECTLINK 0x40
+#define VIS_SERVER 0x20
+	uint8_t  tq;
+	uint16_t seqno;
+	uint8_t  orig[6];
+	uint8_t  old_orig[6];
+	uint8_t  ttl;
+	uint8_t  num_hna;
+} __attribute__((packed));
+
+#define BAT_PACKET_LEN sizeof(struct batman_packet)
+
+struct icmp_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  msg_type;
+#define ECHO_REPLY 0
+#define DESTINATION_UNREACHABLE 3
+#define ECHO_REQUEST 8
+#define TTL_EXCEEDED 11
+#define PARAMETER_PROBLEM 12
+	uint8_t  ttl;
+	uint8_t  dst[6];
+	uint8_t  orig[6];
+	uint16_t seqno;
+	uint8_t  uid;
+} __attribute__((packed));
+
+struct unicast_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  dest[6];
+	uint8_t  ttl;
+} __attribute__((packed));
+
+struct bcast_packet {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  orig[6];
+	uint16_t seqno;
+} __attribute__((packed));
+
+/* vis defines */
+struct vis_packet {
+	uint8_t  packet_type;
+	uint8_t  version;        /* batman version field */
+	uint8_t  vis_type;	 /* which type of vis-participant sent this? */
+#define VIS_TYPE_SERVER_SYNC		0
+#define VIS_TYPE_CLIENT_UPDATE		1
+	uint8_t  seqno;		 /* sequence number */
+	uint8_t  entries;	 /* number of entries behind this struct */
+	uint8_t  ttl;		 /* TTL */
+	uint8_t  vis_orig[6];	 /* originator that informs about its
+				  * neighbours */
+	uint8_t  target_orig[6]; /* who should receive this packet */
+	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
+} __attribute__((packed));
+
+struct vis_info_entry {
+        uint8_t  dest[ETH_ALEN];
+        uint8_t  quality;       /* quality = 0 means HNA */
+} __attribute__((packed));
+
+/*
+ * Local Variables:
+ * c-style: whitesmith
+ * c-basic-offset: 8
+ * End:
+ */
diff --git a/ethertype.h b/ethertype.h
index 900bd38..d8ba023 100644
--- a/ethertype.h
+++ b/ethertype.h
@@ -61,6 +61,9 @@
 #ifndef ETHERTYPE_TRAIL
 #define ETHERTYPE_TRAIL		0x1000
 #endif
+#ifndef ETHERTYPE_BATMAN
+#define ETHERTYPE_BATMAN        0x4305 /* unofficial/not registered Ethertype */
+#endif
 #ifndef	ETHERTYPE_MOPDL
 #define	ETHERTYPE_MOPDL		0x6001
 #endif
diff --git a/interface.h b/interface.h
index afeaee9..5581496 100644
--- a/interface.h
+++ b/interface.h
@@ -323,6 +323,7 @@ extern void sip_print(const u_char *, u_int);
 extern void syslog_print(const u_char *, u_int);
 extern u_int bt_if_print(const struct pcap_pkthdr *, const u_char *);
 extern u_int usb_linux_print(const struct pcap_pkthdr *, const u_char *);
+extern void batman_print(const u_char *, u_int);
 
 #ifdef INET6
 extern void ip6_print(const u_char *, u_int);
diff --git a/print-batman.c b/print-batman.c
new file mode 100644
index 0000000..ccb310e
--- /dev/null
+++ b/print-batman.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright (c) 2009 Andrew Lunn <andrew@lunn.ch 
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that: (1) source code distributions
+ * retain the above copyright notice and this paragraph in its entirety, (2)
+ * distributions including binary code include the above copyright notice and
+ * this paragraph in its entirety in the documentation or other materials
+ * provided with the distribution, and (3) all advertising materials mentioning
+ * features or use of this software display the following acknowledgement:
+ * ``This product includes software developed by Paolo Abeni.''
+ * The name of author may not be used to endorse or promote products derived
+ * from this software without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Support for the batman advanced meshing protocol:
+ * http://www.open-mesh.org/wiki/batman-adv
+ */
+
+#ifndef lint
+static const char rcsid[] _U_ =
+    "@(#) $Header: /tcpdump/master/tcpdump/print-batman.c,v 1.0";
+#endif
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <tcpdump-stdinc.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <net/ethernet.h>
+
+#include "addrtoname.h"
+#include "interface.h"
+#include "extract.h"			/* must come after interface.h */
+#include "batman.h"
+
+const struct tok battype2str[] = {
+        { BAT_PACKET,    "OGM" },
+        { BAT_ICMP,      "ICMP" },
+        { BAT_UNICAST,   "uni" },
+        { BAT_BCAST,     "bcast" },
+        { BAT_VIS,       "VIS" },
+        { 0,             NULL }
+};
+
+const struct tok OGM_flags2str[] = {
+        { DIRECTLINK, "D" },
+        { VIS_SERVER, "V" },
+        { 0,           NULL }
+};
+
+/* Print an OGM message */
+static void
+OGM_print(const u_char *bp, u_int length)
+{
+        const struct batman_packet *OGM;
+        const char * orig;
+        const char * old_orig;
+        int i;
+        
+        if (length < sizeof(struct batman_packet)) {
+                printf("[|OGM]");
+                return;
+        }
+        OGM = (struct batman_packet *)bp;
+        if (OGM->version != 7) {
+                printf("Unsupported version");
+                return;
+        }
+
+        printf("v7 Flags[%s] tq %d seqno %d ttl %d ", 
+               bittok2str(OGM_flags2str, " ", OGM->flags),
+               OGM->tq, EXTRACT_16BITS(&OGM->seqno), OGM->ttl);
+
+        orig = etheraddr_string(OGM->orig);
+        old_orig = etheraddr_string(OGM->old_orig);
+        printf("orig %s old_orig %s num_hna %d HNAs:", 
+               orig, old_orig, OGM->num_hna);
+
+        /* That was the basic header, now print the HNA list. */
+        if ((sizeof(*OGM) + (OGM->num_hna * ETH_ALEN)) > length) {
+                printf("HNA list truncated");
+                return;
+        }
+                        
+        bp += sizeof(*OGM);
+        for (i=0; i < OGM->num_hna; i++) {
+                printf("%s ", etheraddr_string(bp));
+                bp += ETH_ALEN;
+        }
+}
+
+const struct tok icmptype2str[] = {
+        { ECHO_REPLY,              "reply" },
+        { DESTINATION_UNREACHABLE, "unreachable" },
+        { ECHO_REQUEST,            "request" },
+        { TTL_EXCEEDED,            "ttl exceeded" },
+        { PARAMETER_PROBLEM,       "parameter problem" },
+        { 0,                       NULL },
+};
+
+/* Print a batman ICMP message */
+static void
+bat_ICMP_print(const u_char *bp, u_int length)
+{
+        const struct icmp_packet * icmp;
+        const char * orig;
+        const char * dst;
+        
+        if (length < sizeof(struct icmp_packet)) {
+                printf("[|ICMP]");
+                return;
+        }
+        icmp = (struct icmp_packet *)bp;
+        if (icmp->version != 7) {
+                printf("Unsupported version");
+                return;
+        }
+        printf("v7 %s", tok2str(icmptype2str, "unknown", icmp->msg_type));
+
+        orig = etheraddr_string(icmp->orig);
+        dst = etheraddr_string(icmp->dst);
+        printf("orig %s dest %d seq %d ttl %d uid %d",
+               orig, dst, EXTRACT_16BITS(&icmp->seqno), icmp->ttl, 
+               icmp->uid);
+}
+
+/* Print a batman unicast data packet, which includes an encapsulated
+   ethernet packet */
+static void
+unicast_print(const u_char *bp, u_int length)
+{
+        const struct unicast_packet * unicast;
+        const char * dest;
+        
+        if (length < sizeof(struct unicast_packet)) {
+                printf("[|unicast]");
+                return;
+        }
+        unicast = (struct unicast_packet *)bp;
+        if (unicast->version != 7) {
+                printf("Unsupported version");
+                return;
+        }
+        dest = etheraddr_string(unicast->dest);
+        printf("v7 dest %s ttl %d ", dest, unicast->ttl);
+        
+        ether_print(bp+sizeof(*unicast), length - sizeof(*unicast), 
+                    length - sizeof(*unicast));
+}
+
+/* Print a batman broadcast data packet, which includes an encapsulated
+   ethernet packet */
+static void
+bcast_print(const u_char *bp, u_int length)
+{
+        const struct bcast_packet * bcast;
+        const char * orig;
+        
+        if (length < sizeof(struct bcast_packet)) {
+                printf("[|bcast]");
+                return;
+        }
+        bcast = (struct bcast_packet *)bp;
+        if (bcast->version != 7) {
+                printf("Unsupported version");
+                return;
+        }
+        orig = etheraddr_string(bcast->orig);
+        printf("v7 dest %s ", orig);
+        
+        ether_print(bp+sizeof(*bcast), length - sizeof(*bcast), 
+                    length - sizeof(*bcast));
+}
+
+const struct tok vistype2str[] = {
+        { VIS_TYPE_SERVER_SYNC,   "server" },
+        { VIS_TYPE_CLIENT_UPDATE, "client" },
+        { 0,                      NULL }
+};
+
+/* Print a batman visualization packet. */
+static void
+vis_print(const u_char *bp, u_int length)
+{
+        const struct vis_packet * vis;
+        const struct vis_info_entry * vis_entry;
+        const char * vis_orig;
+        const char * target_orig;
+        const char * sender_orig;
+        const char * dest;
+        int i;
+        
+        if (length < sizeof(struct vis_packet)) {
+                printf("[|vis]");
+                return;
+        }
+        vis = (struct vis_packet *)bp;
+        if (vis->version != 7) {
+                printf("Unsupported version");
+                return;
+        }
+        vis_orig = etheraddr_string(vis->vis_orig);
+        target_orig = etheraddr_string(vis->target_orig);
+        sender_orig = etheraddr_string(vis->sender_orig);
+        
+        printf("v7 type %s seqno %d entries %d ttl %d ",
+               tok2str(vistype2str, "unknown", vis->vis_type),
+               vis->seqno, vis->entries, vis->ttl);
+        printf("orig %s target %s sender %s VIS:",
+               vis_orig, target_orig, sender_orig);
+        
+        /* That was the header, now the VIS list */
+        if ((sizeof(*vis) + (vis->entries * sizeof(*vis_entry))) > length) {
+                printf("VIS list truncated");
+                return;
+        }
+        
+        bp += sizeof(*vis);
+        for (i=0; i < vis->entries; i++) {
+                vis_entry = (struct vis_info_entry *)bp;
+                dest = etheraddr_string(vis_entry->dest);
+                if (vis_entry->quality == 0) {
+                        printf("[HNA %s]", dest);
+                } else {
+                        printf("[%s %d]", dest, vis_entry->quality);
+                }
+                bp += sizeof(*vis_entry);
+        }
+}
+
+/*
+ * print an BATMAN datagram.
+ */
+void
+batman_print(const u_char *bp, u_int length)
+{
+        if (length < 1) {
+                (void)printf("truncated-batman %u", length);
+		return;
+        }
+        
+        printf("batman %s ", tok2str(battype2str, "unknown", *bp));
+        
+        switch (*bp) {
+                case BAT_PACKET: 
+                        OGM_print(bp, length); 
+                        break;
+                case BAT_ICMP:
+                        bat_ICMP_print(bp, length);
+                        break;
+                case BAT_UNICAST:
+                        unicast_print(bp, length);
+                        break;
+                case BAT_BCAST:
+                        bcast_print(bp, length);
+                        break;
+                case BAT_VIS:
+                        vis_print(bp, length);
+                        break;
+        }
+}
+
+/*
+ * Local Variables:
+ * c-style: whitesmith
+ * c-basic-offset: 8
+ * End:
+ */
diff --git a/print-ether.c b/print-ether.c
index 20a2a65..d954ed0 100644
--- a/print-ether.c
+++ b/print-ether.c
@@ -79,6 +79,7 @@ const struct tok ethertype_values[] = {
     { ETHERTYPE_CFM_OLD,        "CFM (old)" },
     { ETHERTYPE_CFM,            "CFM" },
     { ETHERTYPE_LLDP,           "LLDP" },
+    { ETHERTYPE_BATMAN,         "BATMAN" },
     { 0, NULL}
 };
 
@@ -335,6 +336,10 @@ ether_encap_print(u_short ether_type, const u_char *p,
 		mpls_print(p, length);
 		return (1);
 
+        case ETHERTYPE_BATMAN:
+                batman_print(p, length);
+                return (1);
+                
 	case ETHERTYPE_LAT:
 	case ETHERTYPE_SCA:
 	case ETHERTYPE_MOPRC:

--WIyZ46R2i8wDzkSu--
