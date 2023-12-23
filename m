Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA6EC3DA6E
	for <batman@archiver.kernel.org>; Sat, 23 Dec 2023 11:32:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F0B3583D78
	for <batman@archiver.kernel.org>; Sat, 23 Dec 2023 12:32:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1703331125;
 b=fcvjgVwXNQFhUA81eZImPvVrtMs56cjZKdD88E6wo4MzukremGYLKNPTwofZH5I87utot
 Yce4IkcN4yBMCLhY8ZyuWZMJi2AhjgoAousDgCW6Y/aDXD7n4CvmjcuKuxE2cEUX7IfUhgy
 LBV0+RKuiFGp/fNqdDDWSak5A8XFOvM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1703331125; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6MsyQAsfFA4n6AFjfDJDYVw/q6CpsSePKlLBLQtyuZY=;
 b=yyYWJgl1Hjnvx3C+K+yNadjasyeTWBDX8sM3RTREnOr6IuPIFlGHku4vBiVfb243r+UtI
 Uj0LrGKkUZ5e/wb1xQPdVHIWAS7SVDBW59q3HfCWAqskpKdkBl+PGvv/R1EYS3xZ/0wB9sK
 Aiweu56eGI79OfvCYnaikD8iTweGlII=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 731CE80DE2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 23 Dec 2023 12:31:44 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1703331104; a=rsa-sha256;
	cv=none;
	b=QrOX+mVZpZU4zXQUytsmucpqOPFhqkN7mwbJ4gur6YWd/te57vW4mG2ltGZhE8hT9krRO2
	7urE4tphodEkGZyv6m3fJtVhODo9fwfSNGjnAS7q2w5KU1XEia3/01X8kgMSlqAfavj4Tg
	ulkS6cWSY3aze4RPJ426/LwAvFr+h2g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=aCJazaes;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1703331104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6MsyQAsfFA4n6AFjfDJDYVw/q6CpsSePKlLBLQtyuZY=;
	b=JiijvatMeK8XYwLBr96mWb1uJ/59j56U2pGJB4DS0pha2aSqy4iz6N7btnI1Bd/pcn6GWS
	I91qoNGLb6Ux0TvuNwQbP/TRp5r8KPH0r3MGbXszNwMrYwvPpWbJjGTrnwkhyJhMStvjzf
	wW0BQ6OO+EK5SKx9dwDb6K56Cby+2Ow=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1703331103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6MsyQAsfFA4n6AFjfDJDYVw/q6CpsSePKlLBLQtyuZY=;
	b=aCJazaes5QIL9oOXEBvu/ztMImRrywJJGK7c9GH+/k7l/gGjVASx5ZImrnmIt0ZmaYnscx
	H2UnBAOYNDmzlrR3C2VPhM/8fKdmxHNH8ryQt0I/GrH0ybg3fRxHoLLS10PX8Ufm9jhg4e
	vcAr5QKxd2r+8C61FtKAf5wx2G2R2ps=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 23 Dec 2023 12:31:36 +0100
Subject: [PATCH] batman-adv: compat: Fix skb_vlan_eth_hdr conflict in
 stable kernels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231223-compat-skb_vlan_eth_hdr-v1-1-b31f7dd6e5e4@narfation.org>
X-B4-Tracking: v=1; b=H4sIABfFhmUC/x3MTQqAIBBA4avErBNqCoSuEiH+jDlUFhoRRHdPW
 n6L9x7IlJgyDNUDiS7OvMeCtq7ABh1nEuyKARvsWsRO2H079CnyYtS16qjoDCq4JBxpQx6dlL2
 FUh+JPN//eZze9wNRJ5qZaQAAAA==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=sven@narfation.org;
 h=from:subject:message-id; bh=CgrBtwP5JQ25YIDCG5WUE5eyv8Qm4thhd7wP+K+n7LU=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlhsUYZrkNWqiAgxY8Wz5u4unIArLz/Zfc/revD
 CiYnH6mSAmJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZYbFGAAKCRBdhwoHwSZ7
 RkoYEACARarjTCZ4ZRX3tHrcKstud37KUrFj3AJi7NNNhyAytNBvKkbZJ/I5UKBwOd4w/R+wD7l
 R7kWuSeRRDKCQh+Kd7ho4cFDP+0/bjLQPWVCaPiWtQZK/mgFhftvwyoZ8xVk4nRZ9CZcACnbilt
 5qTNuo7GxPNB1pMjkQGNLr67Wph6Z2F0EUys2hh4fEyQ2vWc6yvgwWbgaZFyoBNjjR+fArPMzmh
 EF25GQdN+1bJKB8JAzyBWa7KuyDqrPrPjrU2oX2nqQXkWTU2CYEaRGbaRzp61o6WHdjbcSWUtvM
 BdYm+fsWEs0le2o1iS0+9ArpGDYeNXNm/VZrdoOf1xrVlsSKfUlW7vcqu9TRZ0Vd38ZXbbICCQI
 Xg4iU254XknBdG7n928x2RvYhjSWMq/vIhcbl0vNkx6UEwZQswhiBJDwgUzBzoDbTUtCsoZA5wv
 5beIWArdJ3d7tX2LmS6SjD8agK+mFBquWctR+Fj76sDLQ8s1N35sM4yjJ3okGYQ2z0+xUVjRrTS
 xl8qjF5llsntaomzHPVGXqj0xIdsOkqadWDS16QJsII08HpvUH3L4GSD/dP3QUgSdIumAGhnfOM
 GgEH0fTFdEpN8rwd3wfHPAhg8kevuv810xxtx/GZIM3gGpON6Sn15w9BGgM1OZ9WhzEeg25JRWL
 FB/tN29lTQUURCw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HBNINDMFAS5VWI7253U5AZKJQOFAFKR4
X-Message-ID-Hash: HBNINDMFAS5VWI7253U5AZKJQOFAFKR4
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HBNINDMFAS5VWI7253U5AZKJQOFAFKR4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The newest Linux stable kernel releases:

* v5.10.205
* v5.15.144
* v6.1.69

received a backported version of commit 1f5020acb33f ("net: vlan: introduce
skb_vlan_eth_hdr()"). batman-adv must therefore not provide this function
any longer for these kernel versions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/if_vlan.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
index eb15e060..f19674b5 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -13,7 +13,10 @@
 #include <linux/version.h>
 #include_next <linux/if_vlan.h>
 
-#if LINUX_VERSION_IS_LESS(6, 4, 0)
+#if LINUX_VERSION_IS_LESS(6, 4, 0) && \
+    !(LINUX_VERSION_IS_GEQ(5, 10, 205) && LINUX_VERSION_IS_LESS(5, 11, 0)) && \
+    !(LINUX_VERSION_IS_GEQ(5, 15, 144) && LINUX_VERSION_IS_LESS(5, 16, 0)) && \
+    !(LINUX_VERSION_IS_GEQ(6, 1, 69) && LINUX_VERSION_IS_LESS(6, 2, 0))
 
 /* Prefer this version in TX path, instead of
  * skb_reset_mac_header() + vlan_eth_hdr()

---
base-commit: f33d7f724675544a36b24c77f8d4b95d41252ae2
change-id: 20231223-compat-skb_vlan_eth_hdr-deabef2d774c

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

