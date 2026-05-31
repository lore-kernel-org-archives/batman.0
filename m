Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553FECD5BD1
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 08:32:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AD75084222
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 10:32:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780216329;
 b=waaSoc6/nRDr38qazvRkg/37k20qxZByfm2Cm37q6jJMd2qMmh5W/6w/lfSh5C1YBB0b2
 uJ5Ld3E0E52ih5Mwwhx8aF04xoOBRDufQ23zuglDAmxEG/JGNgZ8fy1ey6fE1aIG/y9pLIZ
 niB3w1PkyGKWBnOF2MXoskrNkUThGE8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780216329; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PnYAMAKBoSADehNAcMCcp4UbxWywFNelduupz6rQ1A8=;
 b=0V7lYFbm+wOP5jGIYCByqRc5UdhXR8CnHMtmC07BL35wD6qqd6z9lXLGXEEMe+7u8Su8/
 YUW3QkNziKDnFtkpH2aXg4URe0RufgSRZdsnG6xQ8fdP7HEw28bVqqxgG6ChoaUQDPn+W0O
 b8O7NhoehsqrFkVFfXMXn3DSkWBgssY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1140D81461
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 May 2026 10:29:22 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780216167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PnYAMAKBoSADehNAcMCcp4UbxWywFNelduupz6rQ1A8=;
	b=Xhyyn6814czG/cfmCBGA5xYffU3Snb4exz4Ax6rsGkj4I/T2gIJY+bQvV6P51o1o4Td/yz
	1CQx2MXo+2XlB/t6DWNFYzl7o2cc7BJ3/pjWCE6Sp1ONtZnHg7ebmtnaOGBQ+YUwtmNaD6
	jjNhprS4lrwzj3V/S4vuo9vNpaM1wTk=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780216167;
	b=aS3g8NAMZNyT08W0Su+eXBBjU+Cy1wInreyopf+18Hfb/ArggUUjwmqEQ/O6xc3YlNNBLH
	ZtCSKivpwioYsl948M0xBRXW6+8y0AVOH6Siczr/lHSxplyVOTpirPI2N0qyslogmHnFHu
	b4e1MZQITmp3s16/2pIfY2rXUFvOsww=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=adDwL2Db;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A539120174;
	Sun, 31 May 2026 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780216161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnYAMAKBoSADehNAcMCcp4UbxWywFNelduupz6rQ1A8=;
	b=adDwL2Db6jZXLJ8Eg9DM/mdME28EEe9a4BHNSChBkN8av1oFKQH35OEBmWMtTU28jOMmVt
	ojCTTxtJLSIreyfU3WdO0sraBAFXXwr+1n8RsabuBOEXpVHE9k/OcRzPZ72wJwyoSpvmKv
	Vb3z2Gw9qi8Fog5FafRAZuD2i++PG/I=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2026 10:28:52 +0200
Subject: [PATCH batadv v4 2/6] batman-adv: tp_meter: initialize dup_acks
 explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-tp-reason-missing-v4-2-5d2556e00128@narfation.org>
References: <20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org>
In-Reply-To: <20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=sven@narfation.org;
 h=from:subject:message-id; bh=Z/R7ID/wCk/c3RTeU7x0yDMm7oqCKAx+UL4+8W91cNQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnSH8OTGcN26T/m+DGtK1Y1/9Zs59rM3Pl1MbIK1w1kJ
 fbm1zp0lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACaSKMrwv6oiYZ8tp0nVSq8X
 D6LP3s92y/hv6/fzfe8d2Ur1dqXMHQz/dDU2aorqnXdcqv50u5FFfOHSw5c2G/r90fjMXhjtdK2
 AFwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EXBQQJVV7IPHTVLSDX63QVQKBU525BRV
X-Message-ID-Hash: EXBQQJVV7IPHTVLSDX63QVQKBU525BRV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EXBQQJVV7IPHTVLSDX63QVQKBU525BRV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When an ack with a sequence number equal to the last_acked is received, the
dup_acks counter is increased to decide whether fast retransmit should be
performed. Only when the sequence numbers are not equal, the dup_acks is
set to the initial value (0).

But if the initial packet would have the sequence number
BATADV_TP_FIRST_SEQ, dup_acks would not be initialized and atomic_inc would
operate on an undefined starting value. It is therefore required to have it
explicitly initialized during the start of the sender session.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e8941f75..0325b951 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1045,6 +1045,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
+	atomic_set(&tp_vars->dup_acks, 0);
 	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;

-- 
2.47.3

