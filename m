Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA4606A31C
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=XNgE9bYU
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9F6E784861
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:29:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794392983;
 b=mROCcCealY4Ywojiaccccgtr8BFDhF1Jp7uLtCAS6Ce5lF5XMZiB0sLblYWq5AnOyY1jX
 ihk97VsUcH2w+RZbpwRnmCBtMx8dqJD6i00ddgy79VFFqzxmBXylI8m4Fa8VLHJDuW6KGTi
 WThR3Iy40NdRzxC4k0+/Uug6vRgyXY4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794392983; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=StVT0aDN7ua5h8DSyA7kZ57nE3Qg1nYxCGZxl7QEwmg=;
 b=NAEd7wbFcENcHl48wnClAE7BAsWwWPeSUTtrZLVz3Q6Xaa14FFfo2MK0GZ1XTywaIEtkS
 y5f2ZV68yMPGPQUJrL6n35OSCjQ9GB+rMRiEnZY1eRBBAuA0jxWDVjXeSm4ddxUAKx5sOds
 3eV98n7QhK8phNvx3HbwLzitkUtgSqI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 69E9A81A7E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392864;
	b=yp5pTELqM/MZrv9zLvioans3RbweZaicYBN5MHv6Lg+dpvc9KwqYwrGpEt1Txvutd3nDkY
	Aqvbey9wcaW1YpJkHpZX8x26rYxljgOanPFOR3qvo1yBj3scweUlJYfipZb1r+7dsw1u37
	17Bh/ILVX7eOhr00iAL1UhsOIVL+vBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=StVT0aDN7ua5h8DSyA7kZ57nE3Qg1nYxCGZxl7QEwmg=;
	b=Gv1OyDDsywfj4Cu081u0/ZE3jsjxYAfBGke1uKx7Mr+EOU49Pl93RWSx/DuapWYd7XIKvv
	RcUGohSrVLnOnyhrUBcqs5nNhi9+T7cebc3ziswcBlph0kLL8iDJOqSUKmH5kxiMbiCb8D
	3fxtbn1/h3SkNIh1ekwEhVSJR28HU/4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=XNgE9bYU;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740deD843BE7e4a980E9c65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 7BDF1FA113;
	Wed, 11 Nov 2026 11:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StVT0aDN7ua5h8DSyA7kZ57nE3Qg1nYxCGZxl7QEwmg=;
	b=XNgE9bYU12UxbP/pTXnRxGQi0kQK7+Q3pl7a/e03AtxSAtt0wzsQxX6neMxTVQIx1n1/fq
	67q4qTQB+uRw5cQ9JP92rNDhEHyjs7lyDZ7uq4HbBDOrHsglU5dVrVHRjMehVpmwEg/37/
	f3PM3Jx7ascn4xqKCloiyjb4TjseXSIuUs/Lgh0QdvU7/MBz6me8JmOW4y3jr9XxdWQ4pW
	aWKbPbu5iaFrCjY4qACJFBO2G7LbwtPva0dvQhIcfQczOk6G//uHd/t+xi8v6XocBn+09z
	Xs4K6wzw4LecK3Y71J9+bKmdJ3gmiZA7LGyUg5r6MJFX/ig1MavJFLrT0OQq1g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: uapi: add note/clarification on
 access of reserved bytes/bits
Date: Wed, 11 Nov 2026 11:27:17 +0100
Message-ID: <20261111102729.2096241-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XZL2ETJEBPAKYKMUXBJHHRDMHSKKDKQW
X-Message-ID-Hash: XZL2ETJEBPAKYKMUXBJHHRDMHSKKDKQW
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XZL2ETJEBPAKYKMUXBJHHRDMHSKKDKQW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Linus Lüssing <linus.luessing@c0d3.blue>

Similar to the note in include/uapi/linux/ethtool.h, add a note regarding
reserved fields to include/uapi/linux/batadv_packet.h.

Userspace must not access these fields directly, as they may be renamed or
repurposed in the future. When creating packets, userspace should zero the
whole struct (e.g. via memset or a struct initializer). When parsing
packets, reserved fields must be ignored.

While at it, unify the kernel-doc text of all @reserved members.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 32436560ecc8b..67e2bad7407b6 100644
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
2.47.3

