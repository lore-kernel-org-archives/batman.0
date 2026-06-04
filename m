Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BCDCD6E75
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 20:09:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B01AA84718
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 22:09:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780603743;
 b=FrqUxN8w4WsdYNyJDWIhj/ZZ150iWlr/3A19ww+crayf7ITECLRX46mIjSKFNhiAxnlRi
 vT8F5CTf9li0LOUPHYqnkJhCycAg8++lYT0bjGlnBUgdEqvQ6p9Vvpouue7BnbDp9ObenLI
 uruFDV114mxMLHRTfl3nhOgmvTQuW/g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780603743; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=V+Ffcky9GoXavcRainSHI0r1nd2Uiyc6EN8rhRWxsb8=;
 b=ZhpXmIh+ROXgdU8IXmD3ZOFHHY/7PEdZiAOr209FGbNyw59R0UpsesLFko100INN/C9vU
 ngUBg43dy7ZJ3xZzUoPlMPmKrBfOO645MwZwrdxItg8XP5wy6dSkvkVdZA9Cq4FSrvdwgVA
 s846SOqPu/Eyh1q8YYLbGyIlcRC+D0g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4BB1B82587
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 22:08:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780603734;
	b=dPD4fkAVnNtt8Y4jqlM/u93g2RWoENc2DpyoJ095pUfiUnQECyAIrZDB+NA7IyLmGvgUc8
	JiTn0A5tYH2V9zw6yk6RAXTE+AqRicJlQW1kxC90sApuvEJrdjd8HhRoucwe/Y31MskNAj
	ACjOmV58fj7mEFWn2T7a3VINgHhh9Y0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AfG8vRwj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780603734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=V+Ffcky9GoXavcRainSHI0r1nd2Uiyc6EN8rhRWxsb8=;
	b=NvaLAjR4SSwF+FXaw+7Iy+v3nYRkPmHGwbw4VEIdmH0ydWpB1oDp+B+g9I2rm4YaAa9tNX
	TFthhlhLJ/EA5ai3tjZ7JzTsVwZMyLANc1Ry/xGr0yH5oOxRXuI3ew65llHaCUrrgaCBBT
	eVweITpQhhx/G4Aw6m207/PaCUiycAA=
Received: by dvalin.narfation.org (Postfix) id D4A4220268;
	Thu, 04 Jun 2026 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780603733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+Ffcky9GoXavcRainSHI0r1nd2Uiyc6EN8rhRWxsb8=;
	b=AfG8vRwjH1/JIC9lOI6Ekg1w0X3VbfgM6VU2Cxn0YkroTuuEPA0isQix7fR/0qCUF57DO7
	PbrBoVYOipNx8sIQYXNN+zz10q9bhZ4F/xPpNBY7MNLXkLHVAuaxgHh94TmHYSn6sTH20F
	zLTevagiwTmH0UxV/jq90Y2EHnhR7SE=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 22:08:45 +0200
Subject: [PATCH batadv 3/5] batman-adv: uapi: keep kernel-doc in struct
 member order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-kernel-doc-cleanup-v1-3-c4c4d4a77c31@narfation.org>
References: <20260604-kernel-doc-cleanup-v1-0-c4c4d4a77c31@narfation.org>
In-Reply-To: <20260604-kernel-doc-cleanup-v1-0-c4c4d4a77c31@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152; i=sven@narfation.org;
 h=from:subject:message-id; bh=XLdRAbf37dHnuGM+rQ5UfePJAOqr0/TajkzRZo6nMLc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKt73TvlVcX3tv8sWmhp/frrIfeGm+JdVrDs/y7kCfW
 5ratiFXOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT+X+BkeHMioZKpt5pH1XO
 PlsennO26WvDuZa9t99cyr4e1Ljs3q4rDP+UJcU/CJpvNmX8vqlWR/9tYtPV0ojG75d7YgTSjgf
 7fWQGAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QOJHSWTLYXP4TIWY3HXOX4PIAJJDLDV5
X-Message-ID-Hash: QOJHSWTLYXP4TIWY3HXOX4PIAJJDLDV5
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QOJHSWTLYXP4TIWY3HXOX4PIAJJDLDV5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The order of the members of struct batadv_coded_packet and struct
batadv_unicast_tvlv_packet didn't match the kernel doc. This is the case
for all other structures and should also be done the same way for these
two.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batadv_packet.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 439132a8..1241285b 100644
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

