Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E5EC001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:41:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1C0E83AB7
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:41:16 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692204076;
 b=XZvKs6zxDgT2C3XVmSDAtER/1Fr+0r2Paor0tY+VMrK1QD5ysreHG25brvMO1cLAXuskI
 mnTukvBRq8nLgNxYl9kJsSI6OI9sfQWzPM4fY6F0XQu+Qp6TK+i5mWHWLYgtLwkxYDD7ESy
 k1p678dHIkvvjFQQSYT/hiMeFsxU9oQ=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692204076; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=amJQTPXrCeuUiYKJIPBLJv02MxYZRVyiUw9AyUoaEmQ=;
 b=mCXVzPs6j9669N9B3TF/chJdpJbj2TJ3No94WLjCRvV6qCNXgxuvA8Mv5F4t2FpskLD2w
 j0kAumfaqub5MS6+xZ46gGRo76bZXb7qGIIKBgHqsJsSv+E2lYfYZa6v6iepkVpcafOT9xL
 ejOAeekJtNsMfhdLu2BKuo8MV+Xchys=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3D2C98011C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:40:02 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692204002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=amJQTPXrCeuUiYKJIPBLJv02MxYZRVyiUw9AyUoaEmQ=;
	b=MxJcgGwwbzCHdKHHrrLdktzBi+fXPEa0pPTRYsg+zQ2Ad1bJcep5QrYaUTh9gxqYHN8B6S
	eq3Xz+RM5DE86MS9YM2pmEOKH9NMBBQqjirGelbDDaWg6Huc17KD5Ty9ntiWERbRzRaHP+
	d7IehHmKW1uX73uxgpj8veiewh9nfBk=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Kp9TQ+Yt;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692204002; a=rsa-sha256;
	cv=pass;
	b=kAxTAuxsVICeeOnmtAmdJaSAfLh/JfvgRj1YQ7n+yRI4o59LYRmggA4JaHJZeYpFGpgT0y
	OK0qXRbtlupdxfneGHn//rpA0TIIt15ZJF/h61PZ2YlrSDGxMRi9EJRJUDKBMF7cWN1nI9
	kbqIBTRr27rLySk3vjic5XTbt4KI5+c=
Received: from kero.packetmixer.de
 (p200300Fa272a67000BB2D6DCAF57d46e.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id DF06FFB5C4;
	Wed, 16 Aug 2023 18:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204002;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amJQTPXrCeuUiYKJIPBLJv02MxYZRVyiUw9AyUoaEmQ=;
	b=Kp9TQ+YtoGGHDDL28+D5GjW/EjCoCqxQT9iOMXbSplYWYauFZC+Zz22I74uTdd1osMdx/p
	WG2VnXo/8fSUj6QPvdfAZP8HcdH1+bJaENYm4zUywUNzAiVNNjEYrG6ItXjkrGoZnkHRe6
	SXrpSsQvTo1A2JfVPikuIyW8XplKa8A2eU4bUWNITEx52Dzohq++duLu1ZOSfsGrBWBQHj
	7qovh7oAdKVEYCbVhAx2xf3MSbK5mSU0p6Pu+AOtQO8/0UayKSk6MTI1+tTsd4EpojrvlV
	ZjwA0TIQJEclnU62HJ8NGs7dKL2SZ6MoSiNqfMfv78f+DkpQaYXKOmjYedT/UQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 1/7] batman-adv: Start new development cycle
Date: Wed, 16 Aug 2023 18:39:54 +0200
Message-Id: <20230816164000.190884-2-sw@simonwunderlich.de>
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
	bh=amJQTPXrCeuUiYKJIPBLJv02MxYZRVyiUw9AyUoaEmQ=;
	b=qc3/HpVqg9desG0/jzyJbn1zWCN6/fPRJYNVsdlmbHHpmqea1xsNZw6XdFaDlCIHcOkd6Q
	ZxJAgjnHzYT/tCdjN+vTofruJSTywIRChO6zfjIzlawC0O4aJWu442i/Tx9wYIjeXHlGOT
	Rulwus+yKUIxsS1lgKRuUA4InXcrvtQe7fDwCoc+N30fQpUoHlOaAafN7DZn+GB4bOgt5A
	UaiXNZpJWah9TTbnt5TNXJga3fbO66tAaHgoGt0PfE4p+h5hjtTx7mE0tNJIg3BHrin1zS
	/+XQNkuK51hTqkLlsdRRhgMixgdT/Kr28Z4e2U3sy1gJ61K2wwdjGMaNsqn6xg==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204002; a=rsa-sha256;
	cv=none;
	b=12vnSjM6zHgsGbIzvXGWSXbUnpAO9GKEA8Z421OW7nlBEXf1s3IHnqfDoM7fiUSErrrGPPQlGWqHw/3/X+ThbDW/2/vfHqnhOjzs4TB6yCnzX6vOZqCb3o7m8P1IFUEQfAx8IfUv8q0r9lzo0tu+fC5HZvMJYVQTxDq2dHHwpNu80iLbOqx0W3oJknvu7Zi3av9l9fE29gRW54h6FKA2skM6onxoisVPfytK2M0AVjef0VE2L8iDRR2iYREUBm8C91HJOc1e6t93TsZJ/mhsrEV3npvtdpp0Z0PCvQrbexjs63bfviFoOGOOkiKZ1T9TmGgwEW9LzbBeQDziyvYHPQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: AMVG6BHBMYQX6GR5RYOT244UI2QFA4BY
X-Message-ID-Hash: AMVG6BHBMYQX6GR5RYOT244UI2QFA4BY
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AMVG6BHBMYQX6GR5RYOT244UI2QFA4BY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.6.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 156ed39eded1..10007c5894a1 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2023.1"
+#define BATADV_SOURCE_VERSION "2023.3"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.2

