Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB3BC624D3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 17:37:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 333088213A
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 19:37:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788284278;
 b=YLYMspZ1SvzVcvLpwWqz89uNyY0UUfj95fCEw4Q0A2v67LJtqG7m5bMcV3fQnDJKyFeUW
 lS6oT0u7dph9yszg+l6Lw6b81kfky6gg6TUpbP8QfPsVffkdSEO/SVU1nYcVyL+bJn98YXx
 dezDpRp2TagyRt7VOGZ8OSEfYmOVS3w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788284278; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MW4uIRZbxU4yWfnPozbsGgffmci+XLeEDrZYYfCair8=;
 b=Z2pUhHZ+8FoWzF5DIeZw3+FUW1AMzsJXk6RR6TW1iRmubrp6kvEp09ZYooc0REEHtCBxi
 iaw+/wstqcPFAC7NavoM8tIBt33KzfUWkOZFClsNHSo99I0v/Bi8d6ph4UjFhZc7/Ixdo+r
 DcG1GO8dmckv8vLrIw1o9T0MQ529DXA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A5BBD80B42
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 19:37:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788284270;
	b=ufrjBa/ovQyWPKyLSiCIixTOT3vuZ72Ud8UQY7VQHqI7tmQAYJB9jqZu7TG3FberrpY5Zp
	5258xvBoncoDX0wSWvBaq+eYbSE8V4O0ip1l/3+bSNTy4CVdPHUw2NnWtu6JNLGHIsbrr+
	roKAnBdk7QXEBKh2Et+hnhEoTcQToww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788284270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=MW4uIRZbxU4yWfnPozbsGgffmci+XLeEDrZYYfCair8=;
	b=nvA/MVaZlWPCGCmXNI9b61tCKMYlZioQiukrwI2YVHsn+SDrWmgz6tmLT0aukXOEWaO/E8
	BU41l8yEGQxuvyaZaRJPOAt6sIkpDFovQNKQHQY5B+h1rlklsEXzz9p+6HYqTObPsXxWn2
	LOtvcxAyy8ZWj9DKpo+P2rjMF2nv66c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nDueaf2v;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EEEE21FE7E;
	Tue, 01 Sep 2026 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788284256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MW4uIRZbxU4yWfnPozbsGgffmci+XLeEDrZYYfCair8=;
	b=nDueaf2vmXwk81L+XLmppE6qD611IipDvtRbkDn0TMTO0X9DfDc42vCT3ap4BmeQBd8dbE
	sFMFbpKhOdbdaHdfgW4q0m7t0z7TFEh85mG1OjGQXilT+op76vnZPZOz05OFh/2MzKuPz+
	A2jRceMZ4WbNVRQM3phMB3ZWr/juS+Y=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Sep 2026 19:37:33 +0200
Subject: [PATCH batadv] batman-adv: correct batadv_hash_remove kdoc return
 type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260901-kdoc-hash_del-return-type-v1-1-07b9c26e8df3@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFwNl2oC/yWMzQrCMBAGX6Xs2YWkh5b6KiKSn68mKmnJpqVS+
 u5GPc7AzE6CHCF0bnbKWKPEKVXQp4ZcMOkOjr4ytart1KA0P/3kOBgJN48XZ5QlJy7vGTx2cL3
 FYJXuqfZzxhi33/tC1hTjV7r+vSz2AVe+YzqOD4B5OKOFAAAA
X-Change-ID: 20260901-kdoc-hash_del-return-type-f6ec7be9b017
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=sven@narfation.org;
 h=from:subject:message-id; bh=mozaSe2Ub394R0hI0An03qJoGgPIHpSO8+SwmPIvdCo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnTeWMvLH226IfQo8iMy/UTIs7xv1/nIGKkXjEvQOhpz
 sm3G2uzO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATKdJiZPjNtHS/xNkkQ+k+
 qxtFO9+t0buwQejyo47GDVe/a/4y7NvN8FduBXOnaENwnNIqrTeSrYyTymYdDph1a5rE4gPrZ1e
 UhjEDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RO6T3N2O7VTJP7WSN3ONELU2K7D6GMLY
X-Message-ID-Hash: RO6T3N2O7VTJP7WSN3ONELU2K7D6GMLY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RO6T3N2O7VTJP7WSN3ONELU2K7D6GMLY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Not the data is returned after a batadv_hash_remove() but the pointer to
the hlist_node which was used to look up the entry in the hash.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index e67afe01..45a432cc 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -137,7 +137,7 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
  * data could be the structure you use with just the key filled, we just need
  * the key for comparing.
  *
- * Return: returns pointer to data on success, so you can remove the used
+ * Return: returns pointer to hlist_node on success, so you can remove the used
  * structure yourself, or NULL on error
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,

---
base-commit: bd881c94108e3fb3f3d9ef7186d74e51afe1e5a6
change-id: 20260901-kdoc-hash_del-return-type-f6ec7be9b017

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

