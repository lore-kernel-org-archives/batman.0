Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E0DC43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:49:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A87A084147
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:49:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450159;
 b=Ofhg7MxKdJll/DejQOknbikKU4brYOt/TJkUNBvQ2n8qNYWT27rO/O2dXVsHSfGpek8vO
 flYMuRF6aPSG5eXkKS7Z1YAso7e2m1sSpqkUj4YWGRWJbi/bIGh7uQIEbNusFIC+mw6Sb30
 7yLphQGdvW5JHxE4iNj4vynog3Xpiq8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450159; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HD/FzkQ0p759m4I477DfN78ex+HPljmhLqMPGbCKRtw=;
 b=dIgAQxU+rpAIMtOLGO2oKq6KJOc7tR4DlNioRpvWJTzOYVDIQFem2zzHhk3W/zINvWUYg
 l2ld32rc4siVNVN+w7etv9/3R3KAi0nTbD2wPXKOK2RMB7HuHheWJxOP+YHr7UA2mA4bZN3
 BeZTRvAEg8Df3GsyaTDEGWMMFKkWk4Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 15C5283454
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450022;
	b=iZsVvvvT3mAuwVrL1wZTyuiZoexMbHcckv+SMcIN8zYZH/VZAs0dwO4DX6/im++wn4bI14
	kptNDnzNYezROnIt3ji+YOANck+7xFOvJ63sT1579p/g1R9vviNVWhdbfvUMH3ghnOXvkb
	mkY/KRgupg426TBh9HOV+zlPCU22qSk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HD/FzkQ0p759m4I477DfN78ex+HPljmhLqMPGbCKRtw=;
	b=RJF3BTCE5MlqtvFOgcoJXVB5q0xVRutT0mFEod0NCLR0Z0n0ixGlrd94rHus5p3mYUM/vi
	x4bKCguYD5Q2IP7JJd1u4RSAmGFVL+lYlOH5jyipDpVHFHH7s5LtdblaAWPhBk7RsnMgD7
	ZgIeb/k7qaoSN1fTS+qf/E2GnFWc5r0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OdJDRkAG;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AF7F520442;
	Tue, 07 Jul 2026 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HD/FzkQ0p759m4I477DfN78ex+HPljmhLqMPGbCKRtw=;
	b=OdJDRkAGz8i324J1TxbZTEcDJAQjkic+Bm1aVJER2+8XemyFoL8Pjo9kKguc9dmxgiLMiM
	TpE9AmpjZ5LjKBZ6u2vX2kvjzSLxbdQhwyDdNol+xCiXYEz811QU8dau+YfP7Hel+8Zxni
	pMCWj/QuUFA1mDGotOQ/t+mGKineXaM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:46 +0200
Subject: [PATCH 04/11] batctl: ping/traceroute: don't restart RTT timer on
 stray replies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-4-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=sven@narfation.org;
 h=from:subject:message-id; bh=5q4BDQayQ4/FXlcIDQMAFZ9NNT5ERBLPs/1Qr8fu3xA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+nlMfbXFUEXnzs6J+XpN8YrdPzu4Xf2tm7Ny9t98v7
 +136+odHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJqMkw/A995p9ybEtXQsWj
 JZNm7lqwJG8jq4vt1fMHVkmdb34T8+cGI8P33fYmUuf/rW0+z/DZxGdXfrdJ3atZxhOuy/zz8xB
 kWs4NAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OTDLY3YB2LAECKQHZUIZU5F4CMUDCRXM
X-Message-ID-Hash: OTDLY3YB2LAECKQHZUIZU5F4CMUDCRXM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OTDLY3YB2LAECKQHZUIZU5F4CMUDCRXM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a reply with an unexpected seqno arrives (for example a late answer to
an already timed out request), ping and traceroute jump back to read_packet
to keep waiting for the real answer. The jump target also re-runs
start_timer(), so the reported round trip time only measures from the
arrival of the stray packet instead of from the transmission of the
request, underreporting the RTT and polluting the min/avg/max statistics.

Start the timer (and initialize the timeout in traceroute) once per
transmitted request. At the same time, let select in icmp_interface_read()
the wait time instead of restarting it each time.

Fixes: 2ecb2c8b060b ("batctl: tr / ping - ignore packets with wrong sequence number")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c       | 2 +-
 traceroute.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ping.c b/ping.c
index 5eafdad..fcb8d5e 100644
--- a/ping.c
+++ b/ping.c
@@ -215,9 +215,9 @@ static int ping(struct state *state, int argc, char **argv)
 
 		packets_out++;
 
-read_packet:
 		start_timer();
 
+read_packet:
 		read_len = icmp_interface_read((struct batadv_icmp_header *)&icmp_packet_in,
 					       packet_len, &tv);
 
diff --git a/traceroute.c b/traceroute.c
index 94443d7..975c9ff 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -142,12 +142,12 @@ static int traceroute(struct state *state, int argc, char **argv)
 				continue;
 			}
 
-read_packet:
 			start_timer();
 
 			tv.tv_sec = 2;
 			tv.tv_usec = 0;
 
+read_packet:
 			read_len = icmp_interface_read((struct batadv_icmp_header *)&icmp_packet_in,
 						       sizeof(icmp_packet_in), &tv);
 			if (read_len <= 0)

-- 
2.47.3

