Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC63C001DF
	for <batman-adv@archiver.kernel.org>; Tue,  1 Aug 2023 02:17:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4116482F93
	for <batman-adv@archiver.kernel.org>; Tue,  1 Aug 2023 04:17:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690856224;
 b=KL5SC5AKLOQDle1aCcLHXjeiDuPUw8OreP2hW28XVsJbX0HlGeOnzHitwBbiiE5/X5Gyo
 Al31F/wKTBuiG3t0YJY5p9k3yQAR04s0318xsqeHF15YZiRAawHFtsz8UXRGSYAlmYHyjI6
 wxwBuIo0xWCkIltuBnwJqN63P/GXzqE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690856224; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IvhuJtFl9DAwONGO1Z8s83vJdRTQFLStXQVfm0R1zKc=;
 b=lfraHvWI2DKy7L3ehcJOHpSx0IU6HAhM+PMZeLLdNBjtRnVEZiYM8rXitTY1TChuESDBs
 uUm8vrfGTGrUUuxvwyago4MZ6L+jsLYs7Mg3F4G8kdvK+2vMy6m2WkaBG/+OoKqSJ5K4d2i
 6p6ugSiwwRyQ1EiMBiVUcY9YnugjPio=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 34F618097B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  1 Aug 2023 04:15:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690856149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IvhuJtFl9DAwONGO1Z8s83vJdRTQFLStXQVfm0R1zKc=;
	b=bu1R0DnYsetZWvJYV8xFTYX9q8quQZhaWFXIjyLP8F5TT8EH4QGQZPYs5HzSNpH1Z4va/d
	P475KbWxDcOyuR1m12xyCK8Vg6YO2CJ2pSNYqbzOdw8sRfhHxOg/Rf0BcTCvYDnuwG9pOV
	kZ8VrQiOhKICd5RwQSX1dq516WI5w7w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no
 SPF policy when checking 2a01:4f8:c2c:665b::1)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690856149; a=rsa-sha256;
	cv=none;
	b=mNmmcH+bCNhtydP/ZPMgoddBWOW2XL08l1LCpeSWV0SP3Qiw2CqAp2mcyFljR53JGlLKCq
	BFmpJvxNsgjo6G0BcHho2JBLfpuUXc89Krj0/sSoLHX//tUGcA13H9Z3hG1lEttVVeqKOa
	jHo4xnxdm2nIKrYNcXq/qlhs5i3G6rQ=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 31B1B49B04;
	Tue,  1 Aug 2023 04:15:46 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH 1/2] batctl: mcast_flags: update to current state
Date: Tue,  1 Aug 2023 04:15:36 +0200
Message-Id: <20230801021537.22036-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 4E74EH3YNKWXP4N7SNHAJ547EVZLEMUQ
X-Message-ID-Hash: 4E74EH3YNKWXP4N7SNHAJ547EVZLEMUQ
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4E74EH3YNKWXP4N7SNHAJ547EVZLEMUQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Add the new "P" flag, which signals support for the new batman-adv
multicast packet type, to the "batctl mcast_flags" and "batctl tcpdump"
outputs.

The examples in the README.rst are updated, too, including a description
for the R4 and R6 flags.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 README.rst      | 88 ++++++++++++++++++++++++++++---------------------
 batadv_packet.h | 45 +++++++++++++++++++++----
 genl_json.c     |  2 ++
 mcast_flags.c   |  8 +++--
 tcpdump.c       |  5 +--
 5 files changed, 100 insertions(+), 48 deletions(-)

diff --git a/README.rst b/README.rst
index 606d55721204..3495fba02e0e 100644
--- a/README.rst
+++ b/README.rst
@@ -323,15 +323,15 @@ Usage::
 
 Example::
 
-  Multicast flags (own flags: [U46])
+  Multicast flags (own flags: [U46R4R6.])
   * Bridged [U]                           U
   * No IGMP/MLD Querier [4/6]:            ./.
   * Shadowing IGMP/MLD Querier [4/6]:     4/6
   -------------------------------------------
          Originator Flags
-  02:04:64:a4:39:c1 [U..]
-  02:04:64:a4:39:c2 [U..]
-  02:04:64:a4:39:c3 [...]
+  02:04:64:a4:39:c1 [U... . .]
+  02:04:64:a4:39:c2 [...R4R6.]
+  02:04:64:a4:39:c3 [.... . P]
 
 where
 
@@ -348,6 +348,17 @@ U:
 6:
   wants all IPv6 multicast traffic, meaning other nodes need to always forward
   any IPv6 multicast traffic to it
+R4:
+  wants all routable IPv4 multicast traffic, meaning other nodes need to always
+  forward multicast traffic destined to 224.0.0.0/4 excluding 224.0.0.0/24 to
+  it
+R6:
+  wants all routable IPv6 multicast traffic, meaning other nodes need to always
+  forward multicast traffic destined to ffXY::/16 with Y > 2 (scope greater
+  than link-local) to it
+P:
+  the node either cannot handle batman-adv multicast packets with a multicast
+  tracker TVLV or one of its hard interfaces has an MTU smaller than 1280 bytes
 
 If a node does not have multicast optimizations available (e.g. old batman-adv
 version or optimizations not compiled in), therefore not announcing any
@@ -930,39 +941,42 @@ Example::
 
   $ batctl meshif bat0 mcast_flags_json | json_pp
   [
-      {
-          "mcast_flags": {
-              "all_unsnoopables": true,
-              "raw": 1,
-              "want_all_ipv4": false,
-              "want_all_ipv6": false,
-              "want_no_rtr_ipv4": false,
-              "want_no_rtr_ipv6": false
-          },
-          "orig_address": "9e:58:32:59:54:c3"
-      },
-      {
-          "mcast_flags": {
-              "all_unsnoopables": true,
-              "raw": 1,
-              "want_all_ipv4": false,
-              "want_all_ipv6": false,
-              "want_no_rtr_ipv4": false,
-              "want_no_rtr_ipv6": false
-          },
-          "orig_address": "32:12:17:0a:21:63"
-      },
-      {
-          "mcast_flags": {
-              "all_unsnoopables": true,
-              "raw": 1,
-              "want_all_ipv4": false,
-              "want_all_ipv6": false,
-              "want_no_rtr_ipv4": false,
-              "want_no_rtr_ipv6": false
-          },
-          "orig_address": "1a:34:8c:c4:fe:13"
-      },
+     {
+        "mcast_flags" : {
+           "all_unsnoopables" : true,
+           "have_mc_ptype_capa" : true,
+           "raw" : 57,
+           "want_all_ipv4" : false,
+           "want_all_ipv6" : false,
+           "want_no_rtr_ipv4" : true,
+           "want_no_rtr_ipv6" : true
+        },
+        "orig_address" : "02:04:64:a4:39:c1"
+     },
+     {
+        "mcast_flags" : {
+           "all_unsnoopables" : false,
+           "have_mc_ptype_capa" : true,
+           "raw" : 40,
+           "want_all_ipv4" : false,
+           "want_all_ipv6" : false,
+           "want_no_rtr_ipv4" : true,
+           "want_no_rtr_ipv6" : false
+        },
+        "orig_address" : "02:04:64:a4:39:c2"
+     },
+     {
+        "mcast_flags" : {
+           "all_unsnoopables" : false,
+           "have_mc_ptype_capa" : false,
+           "raw" : 24,
+           "want_all_ipv4" : false,
+           "want_all_ipv6" : false,
+           "want_no_rtr_ipv4" : true,
+           "want_no_rtr_ipv6" : true
+        },
+        "orig_address" : "02:04:64:a4:39:c3"
+     },
   [...]
   ]
 
diff --git a/batadv_packet.h b/batadv_packet.h
index 9204e4494b25..6e25753015df 100644
--- a/batadv_packet.h
+++ b/batadv_packet.h
@@ -116,6 +116,9 @@ enum batadv_icmp_packettype {
  * only need routable IPv4 multicast packets we signed up for explicitly
  * @BATADV_MCAST_WANT_NO_RTR6: we have no IPv6 multicast router and therefore
  * only need routable IPv6 multicast packets we signed up for explicitly
+ * @BATADV_MCAST_HAVE_MC_PTYPE_CAPA: we can parse, receive and forward
+ * batman-adv multicast packets with a multicast tracker TVLV. And all our
+ * hard interfaces have an MTU of at least 1280 bytes.
  */
 enum batadv_mcast_flags {
 	BATADV_MCAST_WANT_ALL_UNSNOOPABLES	= 1UL << 0,
@@ -123,6 +126,7 @@ enum batadv_mcast_flags {
 	BATADV_MCAST_WANT_ALL_IPV6		= 1UL << 2,
 	BATADV_MCAST_WANT_NO_RTR4		= 1UL << 3,
 	BATADV_MCAST_WANT_NO_RTR6		= 1UL << 4,
+	BATADV_MCAST_HAVE_MC_PTYPE_CAPA		= 1UL << 5,
 };
 
 /* tt data subtypes */
@@ -174,14 +178,16 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
  * @BATADV_TVLV_MCAST: multicast capability tvlv
+ * @BATADV_TVLV_MCAST_TRACKER: multicast tracker tvlv
  */
 enum batadv_tvlv_type {
-	BATADV_TVLV_GW		= 0x01,
-	BATADV_TVLV_DAT		= 0x02,
-	BATADV_TVLV_NC		= 0x03,
-	BATADV_TVLV_TT		= 0x04,
-	BATADV_TVLV_ROAM	= 0x05,
-	BATADV_TVLV_MCAST	= 0x06,
+	BATADV_TVLV_GW			= 0x01,
+	BATADV_TVLV_DAT			= 0x02,
+	BATADV_TVLV_NC			= 0x03,
+	BATADV_TVLV_TT			= 0x04,
+	BATADV_TVLV_ROAM		= 0x05,
+	BATADV_TVLV_MCAST		= 0x06,
+	BATADV_TVLV_MCAST_TRACKER	= 0x07,
 };
 
 #pragma pack(2)
@@ -487,6 +493,25 @@ struct batadv_bcast_packet {
 	 */
 };
 
+/**
+ * struct batadv_mcast_packet - multicast packet for network payload
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the general header
+ * @ttl: time to live for this packet, part of the general header
+ * @reserved: reserved byte for alignment
+ * @tvlv_len: length of the appended tvlv buffer (in bytes)
+ */
+struct batadv_mcast_packet {
+	__u8 packet_type;
+	__u8 version;
+	__u8 ttl;
+	__u8 reserved;
+	__be16 tvlv_len;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
+
 /**
  * struct batadv_coded_packet - network coded packet
  * @packet_type: batman-adv packet type, part of the general header
@@ -628,6 +653,14 @@ struct batadv_tvlv_mcast_data {
 	__u8 reserved[3];
 };
 
+/**
+ * struct batadv_tvlv_mcast_tracker - payload of a multicast tracker tvlv
+ * @num_dests: number of subsequent destination originator MAC addresses
+ */
+struct batadv_tvlv_mcast_tracker {
+	__be16	num_dests;
+};
+
 #pragma pack()
 
 #endif /* _UAPI_LINUX_BATADV_PACKET_H_ */
diff --git a/genl_json.c b/genl_json.c
index 2be533d064e0..4cb1bafca8ef 100644
--- a/genl_json.c
+++ b/genl_json.c
@@ -157,6 +157,8 @@ static void nljson_print_mcastflags(struct nlattr *attrs[], int idx)
 	       val & BATADV_MCAST_WANT_NO_RTR4 ? "true" : "false");
 	printf("\"want_no_rtr_ipv6\": %s,",
 	       val & BATADV_MCAST_WANT_NO_RTR6 ? "true" : "false");
+	printf("\"have_mc_ptype_capa\": %s,",
+	       val & BATADV_MCAST_HAVE_MC_PTYPE_CAPA ? "true" : "false");
 	printf("\"raw\": %"PRIu32, val);
 	putchar('}');
 }
diff --git a/mcast_flags.c b/mcast_flags.c
index 44344e0c1f61..7d4c1d69adfb 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -80,12 +80,13 @@ static int mcast_flags_callback(struct nl_msg *msg, void *arg)
 	if (attrs[BATADV_ATTR_MCAST_FLAGS]) {
 		flags = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS]);
 
-		printf("[%c%c%c%s%s]\n",
+		printf("[%c%c%c%s%s%c]\n",
 		       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
 		       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
 		       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.',
 		       !(flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
-		       !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
+		       !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
+		       !(flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.');
 	} else {
 		printf("-\n");
 	}
@@ -125,7 +126,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
         }
 
 	ret = asprintf(&header,
-		"Multicast flags (own flags: [%c%c%c%s%s])\n"
+		"Multicast flags (own flags: [%c%c%c%s%s%c])\n"
 		 "* Bridged [U]\t\t\t\t%c\n"
 		 "* No IGMP/MLD Querier [4/6]:\t\t%c/%c\n"
 		 "* Shadowing IGMP/MLD Querier [4/6]:\t%c/%c\n"
@@ -136,6 +137,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
 	         !(mcast_flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
 	         !(mcast_flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
+	         !(mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.',
 		 bridged ? 'U' : '.',
 		 querier4, querier6, shadowing4, shadowing6,
 		 "Originator", "Flags");
diff --git a/tcpdump.c b/tcpdump.c
index 9a830b2ba8b2..debcb0ae517a 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -231,12 +231,13 @@ static void batctl_tvlv_parse_mcast_v2(void *buff, ssize_t buff_len)
 
 	flags = tvlv->flags;
 
-	printf("\tTVLV MCASTv2: [%c%c%c%s%s]\n",
+	printf("\tTVLV MCASTv2: [%c%c%c%s%s%c]\n",
 	       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
 	       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
 	       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.',
 	       !(flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
-	       !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
+	       !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
+	       !(flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.');
 }
 
 typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len);
-- 
2.40.1

