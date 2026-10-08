Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F09CA6017
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 22:37:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6A1E2841D3
	for <batman@archiver.kernel.org>; Fri, 09 Oct 2026 00:37:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791499030;
 b=hJFKkZZsArzDJubVo9YIwGQh9dRbHNneRln/YVIBr9WJqS4YNOuaSoRWJUfvo0J90XDO+
 n516I5QeYQh4pFfA1O7UK4Rlu35rRJMOcxmSWfgyBrTagAXIDeVdW77bxvkAZnZgVCtLoA4
 WgLW/EgEaVTusg/pUJPOzWSWXYaIRaI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791499030; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0Mr43y9PhSuPkQANfRUcmjlFkLFrImUP3BJVAudRZFs=;
 b=hIN4e1MLVXXLcO3aaoWN35d820+ZZ5BGIewMI09PkJxUp/HbFt9wrshWzsNxoxsqyIqce
 3CsVAGeYYlfOSWEjfmOWOmd5tMyR3FpWq03ol8iL1xYI27gGbahZPreNyQe8w5x2UdzHMvs
 P/VwoENA4id7EQ5/GFIaoLsRP3RMzdo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9547B80DE9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 09 Oct 2026 00:36:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791499019;
	b=BjtxSOLck5QOdHklxoCCKTV+/NgEOp+GsU7gJC3A3ct+CpqKIbtibBKXkBvPGbfzNlLzhJ
	A192IOmpX/VDRupgi70unHU1OENmGZs/2KLoTmiQrkodhGmy4zJgBRpGnTlroFm+ZA7ZPp
	tcwuyyMxwC9xUdjU1hWwxZl5Y6XjEhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791499019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Mr43y9PhSuPkQANfRUcmjlFkLFrImUP3BJVAudRZFs=;
	b=F2a2UHjxeS0PgpEYda2zES5BkpD6AaKz6x9Jfe2aof7joWTNf7XjcpXzVQ4sUISA+znvgj
	vfOVQ9+ygQuzESbgT1BUZXtcjganCYOfK6Pu0AOGZ/lg48HSfP0WVdT44mGKZDygfu/EQO
	IqNR2Q1FhrzF7Ue37wmIgZRWyHloqFU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 042FB233A1;
	Fri, 09 Oct 2026 00:36:47 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv] batman-adv: uapi: add note/clarification on access of
 reserved bytes/bits
Date: Fri,  9 Oct 2026 00:36:45 +0200
Message-ID: <20261008223645.7114-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: CM3AEIA2S7BQT4VTJTCM5YW4FY2GNDBI
X-Message-ID-Hash: CM3AEIA2S7BQT4VTJTCM5YW4FY2GNDBI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CM3AEIA2S7BQT4VTJTCM5YW4FY2GNDBI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Similar to the note in include/uapi/linux/ethtool.h add a note regarding
reserved fields in include/uapi/linux/batadv_packet.h, too.

That is that userspace may not access these fields directly as they may
change in size or be renamed completely in the future.

While at it, unify @reserved kerneldocs text.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batadv_packet.h | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 32436560ecc8..5f60a0bcb1dd 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -12,6 +12,15 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+/*
+ * Note on reserved space:
+ * Userspace programs may not access reserved fields directly as they may
+ * change in size or may be renamed completely in the future. Instead
+ * userspace should memset the full struct containing it to zero or use
+ * static / struct initializations which automatically zero all unspecified
+ * fields.
+ */
+
 /**
  * batadv_tp_is_error() - Check throughput meter return code for error
  * @n: throughput meter return code
@@ -216,7 +225,7 @@ struct batadv_bla_claim_dst {
  * @seqno: sequence identification
  * @orig: address of the source node
  * @prev_sender: address of the previous sender
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @tq: transmission quality
  * @tvlv_len: length of tvlv data following the ogm header
  */
@@ -312,7 +321,7 @@ struct batadv_icmp_header {
  * @dst: address of the destination node
  * @orig: address of the source node
  * @uid: local ICMP socket identifier
- * @reserved: not used - useful for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: ICMP sequence number
  */
 struct batadv_icmp_packet {
@@ -433,7 +442,7 @@ struct batadv_unicast_packet {
  * @u: common unicast packet header
  * @src: address of the source
  * @subtype: packet subtype
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
@@ -454,7 +463,7 @@ struct batadv_unicast_4addr_packet {
  * @orig: originator of the fragment used when merging the packet
  * @no: fragment number within this sequence
  * @priority: priority of frame, from ToS IP precedence or 802.1p
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: sequence identification
  * @total_size: size of the merged packet
  */
@@ -484,7 +493,7 @@ struct batadv_frag_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: sequence identification
  * @orig: originator of the broadcast packet
  */
@@ -505,7 +514,7 @@ struct batadv_bcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @tvlv_len: length of the appended tvlv buffer (in bytes)
  */
 struct batadv_mcast_packet {
@@ -559,7 +568,7 @@ struct batadv_coded_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved field (for packet alignment)
+ * @reserved: reserved for alignment; also see note on reserved space
  * @dst: address of the destination
  * @src: address of the source
  * @tvlv_len: length of tvlv data following the unicast tvlv header
@@ -604,7 +613,7 @@ struct batadv_tvlv_gateway_data {
  *  the tt tvlv container
  * @crc: crc32 checksum of the entries belonging to this vlan
  * @vid: vlan identifier
- * @reserved: unused, useful for alignment purposes
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_tvlv_tt_vlan_data {
 	__be32 crc;
@@ -631,7 +640,7 @@ struct batadv_tvlv_tt_data {
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
  *  batadv_tt_client_flags)
- * @reserved: reserved field - useful for alignment purposes only
+ * @reserved: reserved for alignment; also see note on reserved space
  * @addr: mac address of non-mesh client that triggered this tt change
  * @vid: VLAN identifier
  */
@@ -655,7 +664,7 @@ struct batadv_tvlv_roam_adv {
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

