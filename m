Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E9FCD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:30:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41F0F80F88
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:30:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052236;
 b=UIitRu18DjUPS8SNwcqIayzZbqUtT2JWNIaVLbPXBu5BKkrEEMRr3NirJgd8sxBp44dp8
 xwgT4Hrgj+LHHPw9P2DhZAn06/u/tPSV7Cil/854UJDXCglkldndBM4DI9zTBjAS79KcQpA
 Chlm7OVrwkMLjEeB8Vkv+i8vLVB2ogY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052236; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Jqur1ISftoxbugIER6zY5sFt5KHIDdCqqr0xtJTddFg=;
 b=uJopde6+F8lJqedX8wD6zgdd2UWIfAouZnQjhfU0z1D8PF7NYHn8Lxh67cuQaCpM6Tcyq
 eMhjFsrpvk1TYSHA1DPF2JL7rf4Yw/VzhLvo9qToBu7p1iMXub870RPH5TvMizFLQ3TgbG6
 om+UiojAEQNLqLUMexsJ+Z864JeHtS8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5AE148405F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:24:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051899;
	b=RFb2ma1NuftvLgdkmiYU+CKAIxoAdxOhgol/dvKVbAKxzJPH6OxW+V1Wjmv+3YvgBaWFjd
	b1Dn+syi2r3E5WKcNoWm7CMP6xuLVtfULlj9Jp66ObbakfjHUUwVb27/XlhhRvOnKvNzoK
	lj6Hc34RDSi+Gk3pHJelNIeWFviSlCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Jqur1ISftoxbugIER6zY5sFt5KHIDdCqqr0xtJTddFg=;
	b=JHLSgLWavDGf1zLyyqSZBcxF2NxdyBW2nMpvrR1TTVtbMovrswEF/HoQRfZCw8NJ7cjZza
	qji0EAtXF2VIxeaTRQNgIoSE8n6aKFWX2rCFGiPsm1i8nAc0T+FBd9ZR+pfInFu1SoTz2d
	HldFHeclt/UC+0R/Ltf9yUwK1U7MA+0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Ddeufr5s;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 14BBC20059;
	Sun, 21 Jun 2026 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jqur1ISftoxbugIER6zY5sFt5KHIDdCqqr0xtJTddFg=;
	b=Ddeufr5snYsQr5l4xWeOXdK9oudcRyHtx3MX5q3oqlPF4bbf3zzadh+wXWkpgsAGVeQGl/
	PK5eg+Bg8TokxFZX5E6psoDSKD7JT6tvDDUX/ES5NiGHDl2MNbKiH6uDUKjPD6NH5Tb9jl
	dz60FIof7bSKnfXk/DgRY9OBND+TbO8=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:23:58 +0200
Subject: [PATCH 08/28] batctl: return only initialized icmp destination
 unreached bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-8-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=sven@narfation.org;
 h=from:subject:message-id; bh=ERugwM4FM0y53CgOziL3IEGB/53oqbMoFcFb2w79MO4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1jnN3slpx/v/GzxzMhueUi3nXFwYFe8idWm01O/X
 zr2Qbiwo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRpcmMDL8TDh6u09n0vOLL
 x39mJfdW8Kn7OzgW2X+0NRerWKbm/JrhrzhnBv8u+33X2N8VfVC+vn3zsvy06s9zxZ4sviwsV/B
 mOi8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: V6C74Y3CJOVLAB3YFEKOSJSNU7HI5B5A
X-Message-ID-Hash: V6C74Y3CJOVLAB3YFEKOSJSNU7HI5B5A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V6C74Y3CJOVLAB3YFEKOSJSNU7HI5B5A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When icmp_interface_write() fails with an unreachable destination, it
prepares a reply packet using original packet but changes the message type
to BATADV_DESTINATION_UNREACHABLE. But when icmp_interface_read() tries to
retrieve this data, the requested packet len could be higher than the
length of the original packet. In this case, the returned packet length
must be truncated to the number of bytes of the original one.

Fixes: 4bd751eed4dc ("batctl: Implement non-routing batadv_icmp in userspace")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 icmp_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/icmp_helper.c b/icmp_helper.c
index 8b4fad7..64be9b2 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -471,6 +471,12 @@ ssize_t icmp_interface_read(struct batadv_icmp_header *icmp_packet, size_t len,
 		packet_len = len;
 
 	if (direct_reply_len > 0) {
+		/* never deliver more than was actually stored by the
+		 * dst_unreachable path, nor more than the caller's buffer holds
+		 */
+		if (packet_len > direct_reply_len)
+			packet_len = direct_reply_len;
+
 		memcpy(icmp_packet, icmp_buffer, packet_len);
 		direct_reply_len = 0;
 		return (ssize_t)packet_len;

-- 
2.47.3

