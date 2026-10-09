Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22408CA6017
	for <batman@archiver.kernel.org>; Fri,  9 Oct 2026 00:31:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4DA33845E6
	for <batman@archiver.kernel.org>; Fri, 09 Oct 2026 02:31:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791505874;
 b=lJYM/Xe1Kfcx7f9XUAyv2P5CyzsP4WPCMFDiSsOQxnqdjRyGHMj9/MrpxDBGjJYsGGhQQ
 rpUenAJhNwBQg06g82jwY9iVIlRdfxtvz7a8m6YjqDydJHkArBLWI50RZgyn0Z6bLlyqDOs
 E0oVoARNWX2YNwo9ORq105GTYw/ZC/k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791505874; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NBOjtx3RTP8hhfEjvFm6MhINFPoKnTei279SXtRxVIk=;
 b=1hft1AG/8tIf8fFzZJsrkN4VMOCldQauRs5J0kUZXlnx9xwytC5XkpTRmkiRdM6PFMXOH
 j+gVt2lZKqa2Kp7Ke+59P/YSqxZVNgWkyDFO0H2MZywOyIkzPyVNOB8OAFkKHEEKXy3G5or
 SEweu5egP6rEvA6cU5sBsPID5BynYOQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 585DC811EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 09 Oct 2026 02:31:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791505864;
	b=P7fwwKn8ykUHbrcrCQlYuzndF5PNxLQVAMHI4RC61KxqByS88eaW4AmMoqUsP3E7xExopc
	dSZqx+l/jnOHIv6cQstjfNPBbevyBPeIxe15WBrAuOtF58GoWIS17IFJtKUfSFGi+b/0I3
	HKGsH/hAAUxpBXf5ihLrR5C4IDaqd1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791505864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NBOjtx3RTP8hhfEjvFm6MhINFPoKnTei279SXtRxVIk=;
	b=Ta8dRBSyata3T9gB8+yIZr/oM2Gv/gbFHEKuNfn/pDGd9jfMkxydajxXSG7cxVM+gwtq/n
	FKSu5R71kMm7JH+AfaNIP/66eMkGnXC4VlXE6eQaV/0yhcqPjcv8IdI8+dduYLd+CSSiV4
	2YMeopp89IwoppBdAkRX5LFmgAVLkiI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7AE0D23568;
	Fri, 09 Oct 2026 02:31:01 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH batadv v2] batman-adv: uapi: add note/clarification on access
 of reserved bytes/bits
Date: Fri,  9 Oct 2026 02:30:57 +0200
Message-ID: <20261009003057.12357-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: S4JK6N4IFBKDUGE63Y2P5F3ZGCPS52UU
X-Message-ID-Hash: S4JK6N4IFBKDUGE63Y2P5F3ZGCPS52UU
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S4JK6N4IFBKDUGE63Y2P5F3ZGCPS52UU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Similar to the note in include/uapi/linux/ethtool.h, add a note regarding
reserved fields to include/uapi/linux/batadv_packet.h.

Userspace must not access these fields directly, as they may be renamed or
repurposed in the future. When creating packets, userspace should zero the
whole struct (e.g. via memset or a struct initializer). When parsing
packets, reserved fields must be ignored.

While at it, unify the kernel-doc text of all @reserved members.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batadv_packet.h | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 32436560ecc8..67e2bad7407b 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -12,6 +12,14 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+/* Note on reserved space.
+ * Reserved fields must not be accessed directly by user space because
+ * they may be replaced by a different field in the future. They must
+ * be initialized to zero before making the request, e.g. via memset
+ * of the entire structure or implicitly by not being set in a structure
+ * initializer.
+ */
+
 /**
  * batadv_tp_is_error() - Check throughput meter return code for error
  * @n: throughput meter return code
@@ -216,7 +224,7 @@ struct batadv_bla_claim_dst {
  * @seqno: sequence identification
  * @orig: address of the source node
  * @prev_sender: address of the previous sender
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @tq: transmission quality
  * @tvlv_len: length of tvlv data following the ogm header
  */
@@ -312,7 +320,7 @@ struct batadv_icmp_header {
  * @dst: address of the destination node
  * @orig: address of the source node
  * @uid: local ICMP socket identifier
- * @reserved: not used - useful for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: ICMP sequence number
  */
 struct batadv_icmp_packet {
@@ -433,7 +441,7 @@ struct batadv_unicast_packet {
  * @u: common unicast packet header
  * @src: address of the source
  * @subtype: packet subtype
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
@@ -454,7 +462,7 @@ struct batadv_unicast_4addr_packet {
  * @orig: originator of the fragment used when merging the packet
  * @no: fragment number within this sequence
  * @priority: priority of frame, from ToS IP precedence or 802.1p
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: sequence identification
  * @total_size: size of the merged packet
  */
@@ -484,7 +492,7 @@ struct batadv_frag_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: sequence identification
  * @orig: originator of the broadcast packet
  */
@@ -505,7 +513,7 @@ struct batadv_bcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @tvlv_len: length of the appended tvlv buffer (in bytes)
  */
 struct batadv_mcast_packet {
@@ -559,7 +567,7 @@ struct batadv_coded_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved field (for packet alignment)
+ * @reserved: reserved for alignment; also see note on reserved space
  * @dst: address of the destination
  * @src: address of the source
  * @tvlv_len: length of tvlv data following the unicast tvlv header
@@ -604,7 +612,7 @@ struct batadv_tvlv_gateway_data {
  *  the tt tvlv container
  * @crc: crc32 checksum of the entries belonging to this vlan
  * @vid: vlan identifier
- * @reserved: unused, useful for alignment purposes
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_tvlv_tt_vlan_data {
 	__be32 crc;
@@ -631,7 +639,7 @@ struct batadv_tvlv_tt_data {
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
  *  batadv_tt_client_flags)
- * @reserved: reserved field - useful for alignment purposes only
+ * @reserved: reserved for alignment; also see note on reserved space
  * @addr: mac address of non-mesh client that triggered this tt change
  * @vid: VLAN identifier
  */
@@ -655,7 +663,7 @@ struct batadv_tvlv_roam_adv {
 /**
  * struct batadv_tvlv_mcast_data - payload of a multicast tvlv
  * @flags: multicast flags announced by the orig node
- * @reserved: reserved field
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_tvlv_mcast_data {
 	__u8 flags;
-- 
2.55.0

