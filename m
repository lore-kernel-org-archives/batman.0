Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429D5CD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 09:57:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C3EA885D1A
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 11:57:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839070;
 b=w/ZhABAmmd7yaM8DtTNkysPIJKZpMyRmS5mrbZ842UgeV1LmYOL7sR2691PHPuOxGttzW
 iO1OLnaPdEMdk1Y5+qDh3j23nNETHsZ/SvcYJkmVyUV1T1eBGba+Kz9jmnf2Kz+zMvIb4Sy
 jxknYNCeK7lGcf0bHD4tAVD7j67i6Qs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839070; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=q/qkFKT8Qr7l15xFxytFFUVwsMDuYQMQoM7YNKCJOr8=;
 b=scP0Z5mtYDrqQMGWb5Z9HY0eu1VP0lRPVnaxBVErnul5RmWezOyngGM7JqlX6ZZvko/4Q
 3r7/B2q69q04ppIoFPQpyY3aO3zSfQqhU7ImtrvPWJuXOoGLouswd6RsIuvtJCaqDukUuaE
 vCbqx+0WaO77gN2+v2ov/Y+pcy+fE1M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A844584C80
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:51 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=q/qkFKT8Qr7l15xFxytFFUVwsMDuYQMQoM7YNKCJOr8=;
	b=jYRsoIskwJy5eu8WBeJ58UBt9IzeFVFG0ZLGdKPOK217efcY/FxnMDW0F1uXYpJM48kXFP
	fbnqX0G/cUMakJAlPxx4Hp6+NBejYkL5GtKbxPIrdvvRSGN4WNcm5bI3/sfY6I7Tpxcbdb
	fU7qAJtPckps2CcFUiw3rEI6jpxulsk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="b/P/WA5h";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838951;
	b=Z3ZtMiPzBLAdipjYO1zLNKkAqOQbqx6dd/XGjSujqSOyXeV7nKlgFY5Nz7jF7DLT1uBPqH
	zaguEtkdFZZdIGcvf7UOS5Xw19ZmnH5t4XXgNQAbSL4YuZ1PMlsqbLK6T922H6ZCXlaLv6
	S0Y7ie1tPpg8tMtlLepOvu4FquEAmeU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/qkFKT8Qr7l15xFxytFFUVwsMDuYQMQoM7YNKCJOr8=;
	b=b/P/WA5hCs7nMi+QKuSlg4ffP2GRtM0t+oyAbQe5gjVUvZk13tSXWlvxH7Gb1jAB7ng0WR
	3reWJ8lkEZh893acthADvWJ2CHznddReHOcV03oCKCukXXRoDDZ7BQGTKNhjMQA4M6QFV0
	k6SFjDpyL6lQXXPAlMGqKVpYDcS6Old9uHTp91v9t9JZX+ur9Sxdf8/JnHe9vmmso5317v
	kPxFvSUAEPXCqWitibmzf0BCReeD8MLJACBfwwNuxF4r3fLbQhWBWBtuNjrM6dvrFFOcy+
	hyS4FjywW7TthNZ1nn0mDiEdL4zklbpBAZfeJO/EsLQpMUiif67vbYq+aV4qrg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 04/14] batman-adv: tt: fix negative tt_buff_len
Date: Fri, 15 May 2026 11:55:29 +0200
Message-ID: <20260515095540.325586-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DFBMXY7XN7BTGIZGEPSGOVMGFS5FB7NN
X-Message-ID-Hash: DFBMXY7XN7BTGIZGEPSGOVMGFS5FB7NN
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DFBMXY7XN7BTGIZGEPSGOVMGFS5FB7NN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

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

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b9c0b77791226..888f337a194bf 100644
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

