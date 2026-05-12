Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F88CD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 20:04:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D80D985AFE
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 22:04:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778616265;
 b=Gy5Q+/bRxwFcZ38ykcPlAZ3qRvAut8s3aw0vf3LvmDAAepWOvT96M8QxuisZS7D/LZgfH
 4zBrBXg6IyDq6B1kCnlGR7YgxNTzdJzcG3CptGtb9tx9Abif/INODuOZeTgVFbWi6D4edtJ
 cOgZHOQP2pt5rAP+1dS+aRqdbJZpJHQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778616265; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6RwlLk1wTX6OMId4/4fMMBHMOP9MIwQ67na8rT/dJXE=;
 b=FrpoAD4XvLildHY/H4/moopoIVoFF0ErETfnE9GoAibqHhsodBTOtonu0u7KkmsWprBJM
 rG7edj8OIWiYPqMpjYxR1p+iT9YVH4GzeMWl0/6GYez+8Ujz+pGplt78aZpN5lcueUekYF9
 2E17IzRCWkc+8m2j9K1FpqmtwGNlR5Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1125984889
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 22:04:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778616243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6RwlLk1wTX6OMId4/4fMMBHMOP9MIwQ67na8rT/dJXE=;
	b=e3yDJi9+oJgR3huIPh92Sl1y42YM5BYzx4MK+gOgTH55ORyOeyTOThASfGDqOONP6hHuWj
	5i8vzD6eEekak7WZt0TOkGpCTbPgUDRRgtHYtreXqzP8qeoMBfNnc13zKWgjOJUIVh1e6w
	VHkG9sV3GGNKwt4TqEboQgCjUFJvwik=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DhzpvpzH;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778616243;
	b=lYB43GpHmGGFW0bgANL8Bmu8Cptjn1/yl40ccDrCjQAemAdO7VBQ1UMgpHlSL/893LJMWH
	5wLQqt5vRJ7XonlCIEcf9Nrw526a5NFNmPls3XDGPi1ZkdW1sw6RFvD8kbDFo6QJwxX2by
	GLpBsju5gOK9/OLRSi8SSponburYPFA=
Received: by dvalin.narfation.org (Postfix) id 6D11321617;
	Tue, 12 May 2026 20:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778616241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6RwlLk1wTX6OMId4/4fMMBHMOP9MIwQ67na8rT/dJXE=;
	b=DhzpvpzH4PdDI5pmYbaGs1ZGACjOgjFXY9blEN0rdk3lXoAkBCMJi0tHnOEA5XSyaGvviJ
	u2gZIak8AJhtlucjy1EPA/RblZAoB4dpGziVs4gHR4zQ60Z3iuww+6bGO/baSEvu9kwVsZ
	aLJurj/bRiqHut10JqOzvyKWgc1AzD4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 22:03:53 +0200
Subject: [PATCH batadv] batman-adv: use atomic_xchg() for gw.reselect check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-gw-reselect-xchg-v1-1-4df2344724c4@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKiHA2oC/yWMwQrCQAwFf6W8s4E00or+injYbuM2IlU2tRZK/
 91VjzMws8I1mzpO1Yqss7k9xgL1rkIcwpiUrC8MYWm5qYXSm7K63jVOtMQhUeCDtM2RVfaMkj2
 zXm35Lc/owhT6GZe/91d3K933h237AGMFi558AAAA
X-Change-ID: 20260512-gw-reselect-xchg-a0726590e230
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=sven@narfation.org;
 h=from:subject:message-id; bh=j515MeDFf2NIBwl9aM7ftavTLyQmJid2ce/WZYbBrvo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnM7etm7mEonsJh/eNvjLWo0UefyvrJ0yZvZErwcDh6e
 Nf05CbmjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBELk9h+B/BFyug72CQ+vHp
 vlTpy1wHeLapPbo3f26g/JzvmY7zWnwZ/vupPeZYFRDxPV5wUgyH/Pq+RClj++9HfyT6zJRakJ0
 txQgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5FDEXFZP2FVHQT4FEXFTS2IQOB6XBMCR
X-Message-ID-Hash: 5FDEXFZP2FVHQT4FEXFTS2IQOB6XBMCR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5FDEXFZP2FVHQT4FEXFTS2IQOB6XBMCR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_gw_election() only needs to test whether gw.reselect was set and
clear it afterwards. Replace the batadv_atomic_dec_not_zero()
[atomic_add_unless(..., -1, 0)] call with atomic_xchg(..., 0) to simplify
the logic and make the intent more explicit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a4ab3d44..0fb05469 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -211,7 +211,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
-	if (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr_gw)
+	if (atomic_xchg(&bat_priv->gw.reselect, 0) == 0 && curr_gw)
 		goto out;
 
 	/* if gw.reselect is set to 1 it means that a previous call to

---
base-commit: f3fe50814354e157a6740c818c9ba293ff7c2214
change-id: 20260512-gw-reselect-xchg-a0726590e230

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

