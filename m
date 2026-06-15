Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4181CD98CE
	for <batman-adv@archiver.kernel.org>; Mon, 15 Jun 2026 04:43:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2CF6984035
	for <batman-adv@archiver.kernel.org>; Mon, 15 Jun 2026 06:43:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781498617;
 b=3DQDJNGZPpJHQFxWQmmSi0d+Z6yv6C3vPTM04vtaiE5YbfZ3yI8Yf/YldlKChgjjlWHEA
 RVr4NF00rK10tG3aknmWXpu3up5uZCmM6Rjnv4QPqfYNcSqPsEi9ekzgdWuO+ivD2wqpnck
 4/keG6bSG4Z5yJzMzkPJvJUNO2NOpLQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781498617; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OTvnH6FUoSBk1x6oouRwj1/xWiUN/i+RlaBLS3fv12c=;
 b=qmWPdMAINU5b6RJlQepsrupmvjP8oyURPakVXwPCFnvDoE96YTugsgRracBXBqdlAMMIa
 VaymTzeD1GEVlZH5ap3U2nu3YNfZvN8ZaN2yWO9o3OpUgEuEeWtEA86epuxdXhq2DPIlphs
 dpmY7gbqFP0HMj3wxrs/NZBuPH4mt3M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EEE6683DA9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 15 Jun 2026 06:43:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781498593;
	b=mSHqHTJZdOzJBicMSjcIXLBWEZvtI3Dyel3P0yFKHMiLcXxdFvaitLYJ6EbFvr5O1Hjf75
	WtkTjk+RYD4/2IpMZE9vA1ory9rg07FyWQpFT/HqeX93MPXuXzIjDnf2TANB/lgpf1hC3K
	NbVtnc2bJrit5sW2Wx7+foYCakiK5JQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781498593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=OTvnH6FUoSBk1x6oouRwj1/xWiUN/i+RlaBLS3fv12c=;
	b=MS7AZzmCcPt6ajEGQos6WkTrSE8hR7iffF0RQng30d+7FaBMAvUWrzOswE/PFsnMZz8QsX
	ILA+AbnEScI91x/ycurvnxlx1NTZXmWEV7OiK+g4i402Nzu9mq49reaAlEuaGomvgonePS
	D3DtndL5AZ4pUhS+i+ZEgYPpusMv/xw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=imSmhM2f;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 45BCD1FF92;
	Mon, 15 Jun 2026 04:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781498581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OTvnH6FUoSBk1x6oouRwj1/xWiUN/i+RlaBLS3fv12c=;
	b=imSmhM2fvyPHWMrs0Bz33kfSdoJBZsfDzaTc94RnwUP4bqM4i6nOGI1yXwjuWz6OQO4h1H
	wdyoKF2Anwol3nNTAPUHrvb3T8xJvIXw1dhwer2wF4WdddN7fF5wkJbT2n0TwhZJr0lIt9
	IDzxsqbwmP6lmiXI4iwlDx/fnmk/tUk=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 15 Jun 2026 06:42:53 +0200
Subject: [PATCH batadv v2] batman-adv: tvlv: enforce 2-byte alignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-tvlv-2b-align-v2-1-a48a8d5f73db@narfation.org>
X-B4-Tracking: v=1; b=H4sIAMyCL2oC/3WOTQ6CMBCFr0JmbQ2dkkpceQ/Doi0DjCHFtLXRE
 O5uwbXL9/K9nxUiBaYI12qFQJkjL74IPFXgJuNHEtwXDVijrrVsRMpzFmiFmXn0YpDSuga1Ug1
 CyTwDDfw++u5gTTJ9hu7nx5d9kEt72U5OHNMSPsdwlgf/ZyNLIYUmlKpVrsf2cvMmDCaVp+clj
 NBt2/YFE5CcmMgAAAA=
X-Change-ID: 20260614-tvlv-2b-align-f11bc4263342
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4232; i=sven@narfation.org;
 h=from:subject:message-id; bh=IHdGukbqELV3m4hCrvY/8FDMP8XA8JbACmI/e7HeS+Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn6TWcrHU1mZx4xEX0r6aBcajN7exX7s6uyIv8j/D786
 ov1mPO/o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRhOsMfwXqunc6932Sc7zu
 ty0ob8o7n/ks6876nHL+X7a26+CXa7cZ/pcKxmxcFvNh9Rn91+YPrcsWBezf1X9bv/ZN2fUFzx5
 uqeEDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2BSBEHKKJZP4UTWCW2IPGDSW3ZBRI5IX
X-Message-ID-Hash: 2BSBEHKKJZP4UTWCW2IPGDSW3ZBRI5IX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2BSBEHKKJZP4UTWCW2IPGDSW3ZBRI5IX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The fields of an aggregated OGM(v2) are accessed assuming (at least) 2-byte
alignment, so a following OGM must start at an even offset. As the header
length is even, an odd tvlv_len would misalign it and trigger unaligned
accesses on strict-alignment architectures.

Such a misaligned TVLV/OGM/OGMv2/MCAST is not created by a normal
participant in the mesh. Therefore, reject such malformed packets.

Fixes: 0b6aa0d43767 ("batman-adv: tvlv - basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- also handle batadv_recv_mcast_packet()
- remove RFC
- Link to v1: https://patch.msgid.link/20260614-tvlv-2b-align-v1-1-6e21383cd287@narfation.org
---
 net/batman-adv/bat_iv_ogm.c | 11 ++++++++++-
 net/batman-adv/bat_v_ogm.c  | 11 ++++++++++-
 net/batman-adv/routing.c    |  6 ++++++
 net/batman-adv/tvlv.c       |  6 ++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7588e64e..bb2f012b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -316,14 +316,23 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 			  const struct batadv_ogm_packet *ogm_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm_packet->tvlv_len);
+
+	/* the fields of an aggregated OGM are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGM must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 95efd8a4..037921aa 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -849,14 +849,23 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 			 const struct batadv_ogm2_packet *ogm2_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm2_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm2_packet->tvlv_len);
+
+	/* the fields of an aggregated OGMv2 are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGMv2 must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 9db57fd3..c05fcc92 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1366,6 +1366,12 @@ int batadv_recv_mcast_packet(struct sk_buff *skb,
 	if (tvlv_buff_len > skb->len - hdr_size)
 		goto free_skb;
 
+	/* the fields of an multicast payload are accessed assuming (at least)
+	 * 2-byte alignment, so a following packet must start at an even offset.
+	 */
+	if (tvlv_buff_len & 1)
+		goto free_skb;
+
 	ret = batadv_tvlv_containers_process(bat_priv, BATADV_MCAST, NULL, skb,
 					     tvlv_buff, tvlv_buff_len);
 	if (ret >= 0) {
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 403c8545..a957555d 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -477,6 +477,12 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 		if (tvlv_value_cont_len > tvlv_value_len)
 			break;
 
+		/* the next tvlv header is accessed assuming (at least) 2-byte
+		 * alignment, so it must start at an even offset.
+		 */
+		if (tvlv_value_cont_len & 1)
+			break;
+
 		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);

---
base-commit: c7518adb8b6ebdc481f6ed1fc42c7f45099806af
change-id: 20260614-tvlv-2b-align-f11bc4263342

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

