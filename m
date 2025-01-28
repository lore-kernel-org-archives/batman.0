Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4278C0218A
	for <batman-adv@archiver.kernel.org>; Tue, 28 Jan 2025 15:15:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E4BB783E06
	for <batman-adv@archiver.kernel.org>; Tue, 28 Jan 2025 16:15:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738077326;
 b=nSBhQzgIglQHvYnm0LDlxBbggKK9Lv8F2s40MrUV1g1UVx9/pAuxZE2Fq2pP79dAHsvdw
 ry40JTZkgNI0pI/NxJU7h2Bf9xpbSowOL8KD5sB1TMKu5SpZJIdyc6Q2OKnoO39OAYO7EVm
 /6EkcV+qcZNIQ8lYIgWUBOIJiVGKe2A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738077326; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+xSsdRmbHklVvRjU75VCmBGTMgpvR753FjKrsS8EVyw=;
 b=1TtkKaJD3wMvtwlS8cGHwOQAzqJUyWI4FFFxhNIy+vIuWNJXZW7KVm/r7vxbNl/AJTOs4
 s0y/T8nE5vBQrK/RTQMgPkmHv761I0VhsCtOoAhdV3FoGGnWcpcouGkV8yJkr0DZkHNyc4C
 wfPQRaX6UzA0ANeS5yOAMDMHTxvnZlI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E6890805FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jan 2025 16:15:14 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738077315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=+xSsdRmbHklVvRjU75VCmBGTMgpvR753FjKrsS8EVyw=;
	b=xdGkVtZj+nmj4pWYXHWmg8eoDAVBW87XrUo6CMTM0tnPPUa3VwMynmgP9dBT3lVyTTRYWj
	S0mhE/9NZiT81lVXSo8JK/yQnF/RUBP5t+t3c2tc0Y3rjnVHpAK2S9shWE8ynT+p3vjNkG
	SN33qEgq0UhKThLvhHizE4G5nyeGjIE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=smtpservice.net header.s=a1-4 header.b="Lhf/mkUl";
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=IotgyJ5M;
	spf=pass (diktynna.open-mesh.org: domain of
 "bounce.rpiq3dbqf0mr7c3=osy29e9an0un=yzzzp51tqiugpp@em510616.triplefau.lt"
 designates 158.120.84.103 as permitted sender)
 smtp.mailfrom="bounce.rpiq3dbqf0mr7c3=osy29e9an0un=yzzzp51tqiugpp@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738077315; a=rsa-sha256;
	cv=none;
	b=r5tYvMVzNC4jzy9rxxKu7KmhaW7IoQpl2/9VFTkjGVH0sOaCJkFHubROMnu7MesI3IQ1B9
	TXiATiKLvCt7vDmmH1XZWh03up+Vei9B6aEyhWzq8S2teL2C3NjCIw5Vggoy9vb/5GpN+F
	Sq+KW7CcRfBQiAuunsMFNq9JUj0LVVo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1738077312; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=+xSsdRmbHklVvRjU75VCmBGTMgpvR753FjKrsS8EVyw=;
 b=Lhf/mkUl/eG1XVJckT168lLkkzVY5BYLcYnKPJr7nv0MuDRg3006/llR2O3t6SoaI6VQo
 RBk4tJhEKPzUoKkC735urNmiBy1ki1kg6yLd9QDRos2X/5KErKMrxnZizgk/cHxv9tAbPhY
 /fx5sOs6JWSdyme6bZ948GrD1r6QQ2UAOXSEGnMOimDpYosVN6ma5aflZ6k1F5fR2s/WJPi
 Qiull1oQ94MxS66Tmn0CqFREH62wvTQdtswThYxfG6li3znO4sGr+hbzDqwG/ibne1IkCQT
 hDFNNi1L/SqgAys51A4EzySUkzwOyxqlFa5x0XRLn+S2LImZ9ZEC+GoMHzUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1738077312; h=from : subject
 : to : message-id : date;
 bh=+xSsdRmbHklVvRjU75VCmBGTMgpvR753FjKrsS8EVyw=;
 b=IotgyJ5MnOsbSLTWFGCaAhIN7gLw38OnINlUnGQbnU81zJQKPAVKcxIBJmRaTotqg1iiJ
 MOlLlYbUa/y8/k8lg5f5wbYP5Yft94jn4iG6fFY89lCYG/nS/GjgKnPim9ye9bkrcjzb5m9
 x/TUm9+nOG41oNTbCXvbOPyC4Up7KvAW+cYoOMLbK2ojY7i9K647j2iZBEBIK6kw9QyVc4j
 KmWcYeU/cT9DvLHo7Rw021k/B4L3q9MIToH7Ou5tcrDXWeh5/9WO+XS9HwKK1uV8lTO0CKw
 aeGeegJQT60hMUZ5IA2R2LMVX7YotxfPSDNepAroQmDQ4m+udw5B9wvSqCiA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tcnIs-FnQW0hPqPnK-kBbu;
	Tue, 28 Jan 2025 15:15:02 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sven Eckelmann <sven@narfation.org>,
	Erick Archer <erick.archer@outlook.com>,
	Kees Cook <kees@kernel.org>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Date: Tue, 28 Jan 2025 16:11:06 +0100
Message-Id: 
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sA6pqHVkxx
X-smtpcorp-track: NDKQwSG4K6tV.tzbnkokrPvEh.ygOqMgzwjYM
Message-ID-Hash: PYXDY7GUE6ICA7FP4YS2LBEZ7R7US6R5
X-Message-ID-Hash: PYXDY7GUE6ICA7FP4YS2LBEZ7R7US6R5
X-MailFrom: 
 bounce.rpiq3dbqf0mr7c3=osy29e9an0un=yzzzp51tqiugpp@em510616.triplefau.lt
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PYXDY7GUE6ICA7FP4YS2LBEZ7R7US6R5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Since commit 4436df478860 ("batman-adv: Add flex array to struct
batadv_tvlv_tt_data"), the introduction of batadv_tvlv_tt_data's flex
array member in batadv_tt_tvlv_ogm_handler_v1() put tt_changes at
invalid offset. Those TT changes are supposed to be filled from the end
of batadv_tvlv_tt_data structure (including vlan_data flexible array),
but only the flex array size is taken into account missing completely
the size of the fixed part of the structure itself.

Fix the tt_change offset computation by using struct_size() instead of
flex_array_size() so both flex array member and its container structure
sizes are taken into account.

Fixes: 4436df478860 ("batman-adv: Add flex array to struct batadv_tvlv_tt_data")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3c0a14a582e4..d4b71d34310f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3937,23 +3937,21 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
-	size_t flex_size;
+	size_t tt_data_sz;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
 
 	tt_data = tvlv_value;
-	tvlv_value_len -= sizeof(*tt_data);
-
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
-	if (tvlv_value_len < flex_size)
+	tt_data_sz = struct_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < tt_data_sz)
 		return;
 
 	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
-						     + flex_size);
-	tvlv_value_len -= flex_size;
+						     + tt_data_sz);
+	tvlv_value_len -= tt_data_sz;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-- 
2.40.0

