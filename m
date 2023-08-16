Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6E6C001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:42:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1467383BB2
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:42:57 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692204177;
 b=wD+Ze45odgoz4ugSPbt+JU0ZyxSKjtgKUrVWatqzdTHHzhmRhff7IffCc0Qo3Ntn2euYE
 J8PlroOS5OC3KAbaDv/x1dsEb/mPbRZ/kpryTZgZCtYnIsM4Z41C8B7DCnGRZOWFpSsIoNU
 YqkQBeNmZkMpC9mKHY4hfHPNbMMCR2A=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692204177; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5sUYbNqhvEwel1SnIcIOzH8ev0lU6YpbfJPn2kk+jys=;
 b=SSY37XuFQ3EUM6HY+oJlbeArhwxLnHJAXPp5FrDe2pf8MWvH2L5Aj1JEnAd7S2kfXFkSd
 GlcK9Qjjp+evaJAcG0nVZoO3G8BHtjqajdsQguoRMlwo3Wmr+R6b2GQvj9zYlW78ayRyI4i
 sJlFVsoJtbmMOuWtwdM+Yqk04OUasZ8=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 954BD80920
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:40:02 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692204003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5sUYbNqhvEwel1SnIcIOzH8ev0lU6YpbfJPn2kk+jys=;
	b=gtcaqqZSH4JIsA4Z4n4OqVldi3Ui/ncqDtAc0i1hBESaSOL1NFIrfvkndVScyAu3M/bRIF
	1pt/IE6INN/jqpK0IE+vJiCvIQkUgF6TyPqqfkwazX+8YaHIQYUvYXxnjWbnxBbr5tSZgf
	V4QMhV3Ym26SsBgK3fzN4JWrESX5AXM=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="yI/IKRhF";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692204003; a=rsa-sha256;
	cv=pass;
	b=pXBDvBRBfx03hvjmZIwaz6vm8aHeOqhklFRSCnGDsFVkUtK7S6EyFL91zXsnYblqDhBoSz
	ok8z0qhjRfhmNd8leBWWN6FqVm64re4ByiDSXJ8ivGoy4JxZYUK6zly0nDzIBhWuqaD3uo
	4ALjoFRkfZP4W+4loowwMFn71dUc0R4=
Received: from kero.packetmixer.de
 (p200300FA272a67000Bb2D6DcAf57D46E.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3F50DFB5C5;
	Wed, 16 Aug 2023 18:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204002;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sUYbNqhvEwel1SnIcIOzH8ev0lU6YpbfJPn2kk+jys=;
	b=yI/IKRhFy+YW+6ro/aDBeavgCLP2gfTSSqqgmlOK6g94B3tgyXgsQaSnO7AaMU0gjz2ouH
	isi1zVyCb/vH/oCBUaHx1fhVfRDIE4UoJdZPQL+DJMaio8BzNFQokIHK9URzmz5Vk2F/dB
	moqyqNMPed/JRFDlBeuUZ1cCRPm36DEW3mqxg/AJ0+L1mJBn6G2Ao8hjZ5gRb5ARlW3jAX
	jOpx6vtI8xN19gIvA5Bj78kL4bGkjMksbaltrAatgbqj2E3RMk/3Kw356MrqddGabXHlut
	fC/FGUEbzj0aAUYp7q0FubhxUihsr8xPuBKvyb9a8mIDQAyXLYGMEQ57XO8rVg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 2/7] batman-adv: Remove unused declarations
Date: Wed, 16 Aug 2023 18:39:55 +0200
Message-Id: <20230816164000.190884-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204002;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sUYbNqhvEwel1SnIcIOzH8ev0lU6YpbfJPn2kk+jys=;
	b=Gjw+X2TXV9lmXC2cIouRX/GeRbLar2fuBT84HRlICSgzqBChzqj39skcG0mRZu+8mvvh1F
	G6WVzSF3odlKr1GCo//vvsqO5brAlsO0Euma4NG/bdPz4qkdcqB25FtbisOavGNoKiKuzo
	lpgg9uNTWp5/DFsgh84CEzK18tKhOpwhZiIpiT+64SUatjoaxLLd5t6r3js0NZJYJsBC4l
	c+qhsseClEpjaHYnVPqmdSgEuoHxg2I6Hibk5O0Q8IhgTdUlJGX5dQkPt0Fgg8zTvZpoF5
	3l/Ig6cDmMOQUHu5OGUsw8x40qgwbr8bjdvavvIMHYofLP15KnH2fQib928uDw==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204002; a=rsa-sha256;
	cv=none;
	b=gl2LSSRhCEl91VNW5tZZDVEtC16utTaoobwQUh0q6JOUwaLs4wNhqVfok4sHYDoof2wImu+sRSrd+nEGIQefI4lO7YNaX+tWJiULon1/MD+OiGGzGTh0f+BeNRevoUieTIAsM+E8bx7sb8s55quDgRLHQZFNk4QHBiVMarsJqpPvrhJUhwP4KRNaNP9yxaBvpJRZAmJHS4a1iIZwHXD8UQSGmkWwQSsKyTOkpseE2QF7xgiO54R52psX6htzpQvxDU3sE75s7KO3iSJnJu5TTEMd8mGIceRjBT/bcFuHnLhMhysxNAs7Mc0X3nL8yKyL5qEPePrXe4sD/oPbdJMQAg==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: HRJ6JXBF5FYTF67LGGCMEN3HVCHMKG25
X-Message-ID-Hash: HRJ6JXBF5FYTF67LGGCMEN3HVCHMKG25
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 YueHaibing <yuehaibing@huawei.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HRJ6JXBF5FYTF67LGGCMEN3HVCHMKG25/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: YueHaibing <yuehaibing@huawei.com>

Since commit 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
batadv_recv_tt_query() is not used.
And commit 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")
left behind batadv_recv_roam_adv().

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5f387786e9a7..afd15b3879f1 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -27,10 +27,6 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *iface);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
-int batadv_recv_tt_query(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
-int batadv_recv_roam_adv(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
-- 
2.39.2

