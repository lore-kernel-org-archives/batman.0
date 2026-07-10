Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDFDC43458
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 20:03:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A3938842C2
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 22:03:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783713801;
 b=Ev7JUmycabaTYOu2TbgRFMcm16DteC6fFf4ZXs9wOFDvSNMIYntwpT9mF8pSjhXMjLjup
 y/EoiDOZAv0eY3JxGsvrV1V0kL9rwS4YPF0NbwIn96ocGkZwGPFosGZ9zhqQc6UWB8dAI0V
 Q6sVt3ekxyhZC30rvfM3Fyzo6Gb5fxk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783713801; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RsbIyZoolxhSW3NGb9a6wqMW3AzCEEdbiN3KmULEBN4=;
 b=HrXWtLEL5w1askO3KCfHBg2uBJTcxxD7C+hkPqTQX6wOwy8B9p/R6vzyD2XvoK7Esqasi
 RcnNAvKwgj+eXUMlbOoKzmDp817JGLq6z8pUbRCupElj+7fjciTVUqmjDoqiNIpNix1YT0Q
 9AdeuZbm4AM9qj5jhCb35twdWbZZOKI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 882A080F5F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jul 2026 22:01:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783713688;
	b=4HNj7+39djEmwpA/2uEcZamLHiTzBiOF7zdFkU1TuOUkVVxI2HbxrZ63Q6Hoa8Pq7OMgvI
	GW/NYJR35FeYpD4rF2jgRJi23HQUC2c+/r6qJzYp9jFAlXa3Y79InHBiIimnxv5AxqeJ3f
	3zafsFevukOAuRTleVW5N5HhR4g2AGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783713688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RsbIyZoolxhSW3NGb9a6wqMW3AzCEEdbiN3KmULEBN4=;
	b=vGeqFEnUAJ620jTTS67e+Ix6dI/gmGowEbnIVuBch5lLZUQrOaJ9M/DK9KHS6hb0/vto9X
	zTFmVjaFukl+gS9XyCyZ7GLm/pm8mUYRyIVB0vuyznWfPXnC+UcShDK3KC/qZC6D/F2fkE
	rXLhkMFm+TS/5hgfRqri8XFSxiWhDsg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KX39t7OV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F06262058C;
	Fri, 10 Jul 2026 20:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783713688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsbIyZoolxhSW3NGb9a6wqMW3AzCEEdbiN3KmULEBN4=;
	b=KX39t7OVtWsbvyRfG0hOkMWj2Z019r2UkB7hxNvaQHq2t9WftJh9qlH409oGewY6tggQo1
	0Lub1KS02MY0hzJewyy+KEOn2vwofMxyCPzEJKu2K+JDxhwAlECRgo1kTD3VL9htgUb6/J
	QPHypip3wCSNbN/3FzO5Hd3eJpswxME=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jul 2026 22:01:17 +0200
Subject: [PATCH batadv v2 3/3] batman-adv: mcast: linearize skbuff for
 packet generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260710-mcast-header-generation-bugs-v2-3-06cd83c0f534@narfation.org>
References: 
 <20260710-mcast-header-generation-bugs-v2-0-06cd83c0f534@narfation.org>
In-Reply-To: 
 <20260710-mcast-header-generation-bugs-v2-0-06cd83c0f534@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=sven@narfation.org;
 h=from:subject:message-id; bh=bL55bK33cYlh7OYqf/q53jV4p21NpQQgGXoInOUTJoY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmB/n0XpySrxXxcVafwM4YzuIVHQ3nlkrlFxu+myagbb
 1sRe1Kjo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARHwmG/6Ficmc+7Rfff9FY
 86Mdm/jdMy0mip927VoT591veaXF7hMjw8GoCakXP703dFi7qOtSyFtGbzHRz9tnTtnTvSTv++G
 ao+wA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AGUDV2IGYIWORA4UB3NN5RMODHCIKB72
X-Message-ID-Hash: AGUDV2IGYIWORA4UB3NN5RMODHCIKB72
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AGUDV2IGYIWORA4UB3NN5RMODHCIKB72/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_mcast_forw_packet() and batadv_mcast_forw_packet() is not only
called by the unsharing+linearizing batadv_recv_mcast_packet() handler.
When it is called by batadv_mcast_forw_mcsend() then it will be unshared
but not linearized. The SKB_LINEAR_ASSERT() can therefore cause a fatal
BUG().

The linearization should happen during the expansion of the head because
the call chain because the scrape function can be hit already during the
initial batadv_mcast_forw_mode() selection code:

* batadv_interface_tx
* batadv_mcast_forw_mode
* batadv_mcast_forw_mode_by_count()
* batadv_mcast_forw_push()
  -> calls batadv_mcast_forw_expand_head() before everything else
* batadv_mcast_forw_push_tvlvs()
* batadv_mcast_forw_push_dests()
* batadv_mcast_forw_push_adjust_padding()
* batadv_mcast_forw_scrape()

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 8ed36122d709 ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast_forw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index c5b8e2e3..d8374ef5 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1103,6 +1103,10 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
+	/* batadv_mcast_forw_scrape() + batadv_mcast_forw_packet() require linearized skb */
+	if (skb_linearize(skb) < 0)
+		return -ENOMEM;
+
 	return 0;
 }
 

-- 
2.47.3

