Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0130CD6E6B
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:26:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41A2C841E6
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:26:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644382;
 b=GG8PjKj9aktWGYgUSgxmnYFrHx1aYAghKI0kuS0KGSr5w6Sfzw8aI+GCn5XVFQ4Lreog3
 b835hZVlU1KotnC5By3CKg2Acj8tvu6Odz0Fy8qSBkwOM+PkPc78ods+5oBWe529h4Ea+FP
 OoV/UCmF4Qmp322OKwEpoBv4IjgdapQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644382; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eoYEIYbvnyhBcDmR6uf7zB0wO4FVOJZsykYBKJGC6fY=;
 b=XiS22+EJ7IJMzLdfXQrs/soc9u7Z5ujagJyExuAiWlCSSgki1aUSRPcBaj777a/zBxvYR
 O/d7jsL12CT8oMIwdDXA7PNUGmW3OqorRHq20WU6Esp/VOVYzFZTfr0qwZ6VFNALcImwD3x
 P5N5uKLYvLCP8zixmqNZw1a7cZUUPTw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EF50981124
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644019;
	b=hpfDr5qhCNtbjPj96mhG32udeJFBcKDQyxQW7+BSsW6pwvGCnB3np4LhPae2JtjaGz4KZO
	z3YPz+yfPvkp2uXDDnAZ4Z61aMtOFqcCU6OAuOP1Wj8iYS8CMrh0hNk7zzEQIMhs6177zq
	W8v+XVUwdmzJqjifpqul/e7Sm4kBPWY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Xzqz3z2M;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eoYEIYbvnyhBcDmR6uf7zB0wO4FVOJZsykYBKJGC6fY=;
	b=tSn+s7BHndpYFV8dRy6NaPYEee6dkukOTxJQdLSYpuLWFGuio5weNxZkvrVgAE6psYdL9y
	hyAioi0GTRHzRL5dTd7x3zAR3sQREBydblIeLi2bTI2BrkK06cseO4R+aMFVMvW1Pf0hcM
	LgpzCSEJCxNxyrvF/HiP5Ljtrp0JpAA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoYEIYbvnyhBcDmR6uf7zB0wO4FVOJZsykYBKJGC6fY=;
	b=Xzqz3z2M3l+xKDXgC+r/XWHafAyV7pqqz5ZbH7givgEgrop4QFnpb/wwv9SjAYORFrd/bQ
	Wwwbb9jZm/X1houMwuOd/xWOs3lPiVp7yRFlZmzLwOlmB5nKhAsHfuTmRTcEd1ACFsKDaR
	XFjz9meJnFhPmb9ZAKa1Cl2MHeEzztEyqzm9qFZHEePmTA45WfRn7u8KHu4GPD+pHdJrj0
	qJPmKXQH8GtWTRSbEgqcJOryHa09/qBLo0aNYmptJ4XXfw3soJlz0gtoTXW3/cOs0esgGq
	XDY8GYTZzhKYtUaTAy1WyriWGVy8nFw5I/9Vm/hwgLXoyuAS+nZaI/FR62vG9Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 09/11] batman-adv: uapi: keep kernel-doc in struct
 member order
Date: Fri,  5 Jun 2026 09:20:03 +0200
Message-ID: <20260605072005.490368-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KPS6TVDANKMQKXU7D6DGGJNLCYONO4YB
X-Message-ID-Hash: KPS6TVDANKMQKXU7D6DGGJNLCYONO4YB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KPS6TVDANKMQKXU7D6DGGJNLCYONO4YB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The order of the members of struct batadv_coded_packet and struct
batadv_unicast_tvlv_packet didn't match the kernel doc. This is the case
for all other structures and should also be done the same way for these
two.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 439132a819eac..1241285b866cd 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -518,16 +518,16 @@ struct batadv_mcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
+ * @first_ttvn: tt-version number of first included packet
  * @first_source: original source of first included packet
  * @first_orig_dest: original destination of first included packet
  * @first_crc: checksum of first included packet
- * @first_ttvn: tt-version number of first included packet
  * @second_ttl: ttl of second packet
+ * @second_ttvn: tt version number of second included packet
  * @second_dest: second receiver of this coded packet
  * @second_source: original source of second included packet
  * @second_orig_dest: original destination of second included packet
  * @second_crc: checksum of second included packet
- * @second_ttvn: tt version number of second included packet
  * @coded_len: length of network coded part of the payload
  */
 struct batadv_coded_packet {
@@ -554,8 +554,8 @@ struct batadv_coded_packet {
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
  * @reserved: reserved field (for packet alignment)
- * @src: address of the source
  * @dst: address of the destination
+ * @src: address of the source
  * @tvlv_len: length of tvlv data following the unicast tvlv header
  * @align: 2 bytes to align the header to a 4 byte boundary
  */
-- 
2.47.3

