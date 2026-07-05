Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30AAC43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 13:05:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 426708473F
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 15:05:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783256739;
 b=GrBMa8doiE7HGqwJ2On/zTgl9Lhx9Y6lSprPxavZzdLpSM81FkSwO3oHBt4GKuP0niJq9
 5qhUgOC5Jt54m/AJYSMvy0TTmvGFNSfakBjStpqnsf+n8awenkBu09HkLbN3nftjE/S2X/0
 IuFWLsoagITHgw2BBTNRwi9Vy1eKZbo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783256739; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3G0VaCm97t8ScreyYjEd6Yu5aDs+KLddW89AKZGzjk8=;
 b=u9GNe4eswcu/3qSDt/5u5KsKZgkC2FXEIF7UF6ae/6yduyChDkHIXLbXMIsm1ZvtP8Yor
 iGEVBpBMimPLbwH/8YAFZal+fWKWWnP1a6Qu9RDU5CJfE8kQaSmmarBmxlrtwwITjMr66YA
 a0zeoLLo5E5J8tuoShzS2UU6Z2BsRE8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AB73980706
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 15:04:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783256677;
	b=4KPod8mkD1tW4prBivoDV5rFVkOU7uJjgoHyzJyDwukaTMDUESdrns3D8S+G5YfKB+yRYY
	glC5JSfRs3Dh/XiGJHnlCVBEIosLtL9G0EJwY7UwqwVVrAMmD6TUBGCb8Kcje4MRYm2Gf+
	8ZgfosQ31cCjPSxTrIsv53UdDhBk12g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783256677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3G0VaCm97t8ScreyYjEd6Yu5aDs+KLddW89AKZGzjk8=;
	b=C4VA7T19YdU9yvreb867dgIFXsvr25S/UmHcpD6nDvgpXnh4y242WFj2/E7CAmtSgfCafK
	XJk4raA+uSO55OusRWBOsTBoxhT6rU6oAxr9vBKhrhg3hg8UcINtttqF5xcWuAu8WzJQyU
	gUzxVeLc2YIHt8wJ0LxnIG1h/J+SXVg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZK+Bq7Is;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 48BE6203F3;
	Sun, 05 Jul 2026 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783256672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G0VaCm97t8ScreyYjEd6Yu5aDs+KLddW89AKZGzjk8=;
	b=ZK+Bq7IsLCnEXYav7z3gBd4h0I8Wxnakn87LbnvvuuWSoHbeWVF7cF4NNcv6wZ8TmGjwv2
	n6PpqT9TYzVdA91FURlN+eX8dZ1EpmCwGyQCje5rzzbAkyx+z5jTDPFqsQUp54eVlG8v5M
	VBzulb/FviMPtj3KajIVI9QfWVeYXcs=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 15:04:26 +0200
Subject: [PATCH 1/2] batctl: interface: report rtnl query failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-interface-v1-1-64743906b3d4@narfation.org>
References: <20260705-bugfixes-interface-v1-0-64743906b3d4@narfation.org>
In-Reply-To: <20260705-bugfixes-interface-v1-0-64743906b3d4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=sven@narfation.org;
 h=from:subject:message-id; bh=kmGiGEF/Cp/rvcVtRzSFNEbCnzbOUl7hXhnPfM0msBo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleYVEfzC58usGwz399YMqK2m2GB95fXVkseHfvj7fWT
 hlJ9gv+dZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmsnkuI8PUMy7pUyrSmr4Y
 zWW4w24Wrcq11OHPrIO/rVepccU+PyzOyDBjOvvf3SxHpTnYXqyre6dqe7b6yZew4ymvhZhdcm2
 OPGMGAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NOTIQDUUYDDV6KVFLMUDJJIM4GM2AJAC
X-Message-ID-Hash: NOTIQDUUYDDV6KVFLMUDJJIM4GM2AJAC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NOTIQDUUYDDV6KVFLMUDJJIM4GM2AJAC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

print_interfaces() ignores the query_rtnl_link() result. When the rtnl
socket setup or the dump request fails, batctl interface prints nothing and
exits with EXIT_SUCCESS. This is indistinguishable from a
meshif without any slave interfaces.

Check the result and fail with an error message instead.

Fixes: 60e519bfeaa3 ("batctl: Use rtnl to query list of softif devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 interface.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/interface.c b/interface.c
index 7d3897c..c734eda 100644
--- a/interface.c
+++ b/interface.c
@@ -164,11 +164,17 @@ static int print_interfaces(struct state *state)
 	if (ret < 0)
 		return EXIT_FAILURE;
 
-	query_rtnl_link(state->mesh_ifindex, print_interfaces_rtnl_parse,
-			state);
+	ret = query_rtnl_link(state->mesh_ifindex, print_interfaces_rtnl_parse,
+			      state);
 
 	netlink_destroy(state);
 
+	if (ret < 0) {
+		fprintf(stderr, "Error - could not query interfaces: %s\n",
+			strerror(-ret));
+		return EXIT_FAILURE;
+	}
+
 	return EXIT_SUCCESS;
 }
 

-- 
2.47.3

