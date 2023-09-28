Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C0EE732D8
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 13:52:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 49109835DC
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 15:52:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695909147;
 b=kw3MxiAKvYRS9MszGT4cS0lOy+oMotNz3T6gU57FlgQw6JbmQ8lXE25VOxu7qck+xDHAm
 HVkwKgzgcu8zcCjvBPIa89xZ/hr5AUUI4+S6pBaZ1TiwKHgSWUmsmtSBXq96YvLHfRRBv4O
 sFGk232NKNikQ6eXszrKr7ubrG2JgRY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695909147; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZhX1o4UmndOpZvway/9WTvP/GJW+Irk2ZupNKK2HL0Y=;
 b=RBuu7FC6+YBkc3BjkBAXNPOGuTLRxkx9eSd7J8xwN6tP2srqY63ONG3ssuQt2l7hNYxTk
 El/Uwmb0vZoaffvoYYXTTu3FBwz5e/Zcn57xk40sRhsouJ+Xat0rWkPJLsU698xLX7is59S
 0nxj+qPKrf+/DU8DoZ1tG/7fQvztOWs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E6A068324D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Sep 2023 14:40:41 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695904842; a=rsa-sha256;
	cv=none;
	b=C+IwYvI7w0ciQSanJizfslhTTOhZ7OLab046a/+DR0q+ELYgWkI6g3KdM2uo8b0q7Fdwmz
	oanP3PrO85W43uXmnxV1uv3Kjkvwh541gXsVxdYovxmTAkr8PdBIWzXSou2kAwWBwscjNo
	ZtYia0PZJ1+mKTQ0Q1+Nvp6shN8bZSE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 2001:4b98:dc4:8::221 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695904842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhX1o4UmndOpZvway/9WTvP/GJW+Irk2ZupNKK2HL0Y=;
	b=2CnXfz0fpfalr6zxTAC+TtEH3sjnshz+c02NwP0UCnZb1mdaNkGm+1uYyWjbBZuScysWYl
	qwgDt2G+H4FgXxBufk975E3w/o0VxjGq1Ga8qy1twMusMauwvUu1xM4LY8SHzP2V8EUROc
	nYt2VRZnr3//5ZtxbMTMi61cdB5uYqc=
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5361F24000B;
	Thu, 28 Sep 2023 12:40:41 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH RFC 2/2] batman-adv: Better half duplex penalty estimation
Date: Thu, 28 Sep 2023 14:39:36 +0200
Message-Id: 
 <09c086e5e68055e52d1f92ba17d0e921084107e7.1695904299.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1695904299.git.repk@triplefau.lt>
References: <cover.1695904299.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: NFD5JGXOTVUD2YQCK6TC24XGTTSFHRAB
X-Message-ID-Hash: NFD5JGXOTVUD2YQCK6TC24XGTTSFHRAB
X-Mailman-Approved-At: Thu, 28 Sep 2023 15:50:50 +0200
CC: Remi Pommarel <repk@triplefau.lt>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NFD5JGXOTVUD2YQCK6TC24XGTTSFHRAB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Let's consider the below topology

+-------+               +-------+          +-------+
| OrigA | <--- ... ---- | OrigB | <------- | OrigC |
+-------+      PT_ab    +-------+   LT_bc  +-------+

Where OrigA's OGM is received on same WiFi (non full duplex) interface
as the one used to forward it to OrigC. And where LT_bc is the estimated
throughput for the direct link between OrigB and OrigC. And where PT_ab
is the end-to-end B.A.T.M.A.N-Adv path throughput estimation of OrigB to
reach OrigA.

Let's note PT_ac the B.A.T.M.A.N-Adv path throughput estimation of OrigC
to reach OrigA in this topology.

PT_ac was estimated by dividing by two the minimal value between PT_ab and
LT_bc because of store & forward characteristic of OrigB wifi interface.

However the following formula seems to be a more realistic approximation
of PT_ac:

PT_ac =  PT_ab * LT_bc / (PT_ab * LT_bc)

This patch change the half duplex penalty to match the formula above.

NB: OrigB still sets PT_ab/2 throughput in OrigA's OGM before forwarding
it to OrigC for retrocompatibility sake, and is discarded when OrigC
computes the new estimated end-to-end path throughput.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/bat_v_ogm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 27597f4cdf3e..9b7d4de182d0 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -866,10 +866,12 @@ static u32 batadv_v_get_throughput(struct batadv_ogm2_packet *ogm,
 	oth = ntohl(ogm->throughput);
 	lth = ewma_throughput_read(&neigh->bat_v.throughput);
 
-	if ((ogm->flags & BATADV_V_HALF_DUPLEX) && lth > 10)
-		lth /= 2;
+	if (!(ogm->flags & BATADV_V_HALF_DUPLEX))
+		return min_t(u32, lth, oth);
 
-	return min_t(u32, lth, oth);
+	/* OGM throughput was divided by two for retrocompatibility sake */
+	oth *= 2;
+	return oth * lth / (oth + lth);
 }
 
 /**
-- 
2.40.0

