Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F0DCD37AF
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 09:31:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1EBA685B2A
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 11:31:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778405498;
 b=032nttSeCMVf+NMcrnfx6QB8Weplj4VPsx4VGyluV1znSrUOS66nAgk5lbeBOdXZm+QJG
 rpkUwXqi14oa9WH7SIc2CdwRsNXXIf3GwKAt89b/Vr7ptoPRHF8h8AXYucwkppU4licRbJn
 HedxuyFwrrRz5h7pQOHKwLqcC6O36RI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778405498; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZiUpIzufh4m1riy1mCJl1DVSTkdtr8UYCRZGd4Mu8a0=;
 b=Bz2DN+/b9wcJYn3VX4XVNCpGWad/rdrxmIroTwoUTUcNcy0BjOHd1VGhGb+JWbOxBB+P3
 NBbs8Rky3YF6blApzw85b1AqorUOMoJ4/9hadWlFzxHAX+1ZPEYtQhVigXlCMAj8pUxcUO2
 N3Lwdy9ltdkMZz1XPewuUv8wtNtkV+E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8AE2484508
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 11:31:09 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778405474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZiUpIzufh4m1riy1mCJl1DVSTkdtr8UYCRZGd4Mu8a0=;
	b=YFu+cwOlIZZdxRZrZmdO0dw4bQ0PJaY2lpPI6bU8tj2hzz1UERnJBNInLP3o0IzGD/OyqH
	XaGhGgRdhQKi+XORmPpPC+OyWk3KWciuFEDgoOsdbP0JnpLwVVDvBToZJNKpHACELaAh1w
	73tCP9jexaCbRG9rOznCRxT9MriZ/DE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=cR6AkPQT;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778405474;
	b=GyIY2RanlwhbqpuI6Pl/mrix2killZOMMX1eKCDbJv8dEFPxOdkfAwT21+fZCuFU+7pBNA
	lt8LYYJl5ORSD4p4/MkKTTKD97hNG2qZ65rU45LpOr/K6JF659S3/5nTXVMfRYc0EZDLtu
	e4JXpS5q21mrxM7aRHlm20pdBc8wPu0=
Received: by dvalin.narfation.org (Postfix) id DD91421617;
	Sun, 10 May 2026 09:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778405469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiUpIzufh4m1riy1mCJl1DVSTkdtr8UYCRZGd4Mu8a0=;
	b=cR6AkPQT01aYGrIyOkFJ3VUp1UMuaPSr2mN/paBmNVc2RfFkkSWNlz0UUPKflCEcPge/DL
	CxCt5BwUIHiCHNVrs5lgfSnTn9nlajllzw2almbj9a1ON4ou7D/NsptA/lROHREH1623c2
	Uk9Wy1IZRROoC7Wz3IRa8EzU+6B/wew=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 11:30:57 +0200
Subject: [PATCH batadv v3 1/7] batman-adv: tt: fix negative tt_buff_len
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-fixes-followup-v3-1-1079a93bc964@narfation.org>
References: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
In-Reply-To: <20260510-fixes-followup-v3-0-1079a93bc964@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=sven@narfation.org;
 h=from:subject:message-id; bh=+GD8drVYnA3x/+zOKkKBcyOk2oa0GLZhKZ0yTsCpYOc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkMAcGfa/2OxBc2lX+vnqXsvKDVdw5jxMMJaqpxcYvfJ
 vEKxt3sKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzk2HGGv/LpK3uVE1+w9Gis
 3fBLwyZ/woRySZfSWTvlFT6d4VvGcJCRYdJlQWftkCU/fs9dd2hHyDG+vC7nIw0CXRzr43qlvZe
 4cAAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PL5YL6MYQ4K36RS44FDEVM7FCZBK2DMT
X-Message-ID-Hash: PL5YL6MYQ4K36RS44FDEVM7FCZBK2DMT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PL5YL6MYQ4K36RS44FDEVM7FCZBK2DMT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_orig_node::tt_buff_len was declared as s16, but the field is never
intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_other_tt_response(), tt_buff_len is temporarily widened to
s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_global_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_other_tt_response().

Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index daa06f42..0f3814b4 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -452,7 +452,7 @@ struct batadv_orig_node {
 	 * @tt_buff_len: length of the last tt changeset this node received
 	 *  from the orig node
 	 */
-	s16 tt_buff_len;
+	u16 tt_buff_len;
 
 	/** @tt_buff_lock: lock that protects tt_buff and tt_buff_len */
 	spinlock_t tt_buff_lock;

-- 
2.47.3

