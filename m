Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E980EB64DA
	for <batman-adv@archiver.kernel.org>; Wed, 19 Jul 2023 08:16:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF3DB824A8
	for <batman-adv@archiver.kernel.org>; Wed, 19 Jul 2023 10:16:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689754582;
 b=B4yd9pexykz1lfSVTY5GYPh1DKBlfRvpJmCPg9LvghwbCsw9msh0qoQ81sJHX6Olxn7jb
 1yX2gwMtOyIYVerhcWPMz0cbMLyBqQzOihIMVcJxhBWGgctO1OspI1IpOFb6hirSR6xV3ea
 qiXhYhnNkDickeY4aSPhFwmOuhEOiSo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689754582; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YsrfVK+IH6rtxItVlK59FCeeMb9VUmQo6t3hZq/f4Z4=;
 b=33RJYVVTR75tFe3Wy1BptGjx2PzL/DDhbJ7jNb/AqRxbmgQFCxqQBQ8jcgfCwsB3A5DAN
 i565dptAvQE6M+W5C0CCe4AWGm2JrZm2ff383IcW+HfdZemGaEhkIL0GLCDRa8ZiFi46ckP
 e1CxihtD5zu41e/qpxv9/1L7utyNR+A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 96F3981B76
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Jul 2023 10:15:32 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1689754532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YsrfVK+IH6rtxItVlK59FCeeMb9VUmQo6t3hZq/f4Z4=;
	b=oz2a/OJAvnFm9LRB9h6YO1Pi0DDsufrmdbzGiokRdHOGJF821iuWAIaZaPghgQxEMAwrJ7
	Wseb1IYGG9odpbOMMVGilr4b7iNqdCZxfvzw1IYeTGd4JGWvFGMeBVaCgUueknI4FuhOHm
	KS/f0p8Usp1q5qt6uBHDfF6wxDR9MaM=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1689754532; a=rsa-sha256;
	cv=none;
	b=icbCEJO7+OPhIaY2207DW54NdcdXkVXQO/A1Gg0Kgk8MAwKys0Av6ebl/Bch3VATUssHWP
	2UsrpZ2P7uAgxtRcSj1JQTityYGQjbU3FH6n5DmlbJofEGHqyGanhu9eEJsDvxri2O1nBm
	v3HpLtuTglmgJvOPF3XfZ49b4l/vV24=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xj2Yk88E;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1689754532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsrfVK+IH6rtxItVlK59FCeeMb9VUmQo6t3hZq/f4Z4=;
	b=Xj2Yk88E4oT/Jm1UOAXhp93G2qiMOr2oqKQqKwNDeS2Z+tYc/N6D/6hA5bijo+X4upSTez
	/mjO2PiXBd0MyuTb3B5Vp0YIkcm9pHNZcoKANNKjdkfiUdsP+0hTeQShHCCKBgnMxOLYzV
	qbkxBowLTKDHBVjZY1Dt+uHWnr0qH4w=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 19 Jul 2023 10:15:05 +0200
Subject: [PATCH 1/2] batman-adv: Trigger events for auto adjusted MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-mtu-v1-1-48fd024f0f56@narfation.org>
References: <20230719-mtu-v1-0-48fd024f0f56@narfation.org>
In-Reply-To: <20230719-mtu-v1-0-48fd024f0f56@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=sven@narfation.org;
 h=from:subject:message-id; bh=0TNwkq/zFnFdB203Lxc7qjRh5CWamDuzodSovjrzM6Q=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkt5uelkw6YibGD2peKJZ1M4D01mK6K9GaZZ0Ee
 qC8H2L7vOmJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZLebngAKCRBdhwoHwSZ7
 RqWmEACq013KASqVhyz+O9uo1FDl6R7WfaDem9odG5INqGBVJpnkKFXj3R7IWT00HxDoh3Dupoq
 ymokcBzuxgUkQHRNA0/khw1Z0ccoLSJzhaWSNSx787iFLYg0gPbVLQClvaEDRiq3Nu/VDp0s1bF
 XB+P1hTGnjIsXWyMJ4V0HlteY4S22l9xDk50t3+3rIhF0uHbHnf7gj+cTT7AICzBKIBRljzTa2D
 uHcnTVcy5Ls1zJLo2RWgGqhr+gZZFraClGyhY2eU8O5Zwk4sEJK5QrVR0H2GeEexsvmXf1juUAy
 mloNrpw9aHqa62vR/0MfuvgCxQyaFIAMiveaLZiRXqyw0eB1bbh40hSEF+DByKoreJyqHhJeXZw
 8iBxfr5F+M2NsRbTRVr+D0164hWjh3yS5i+ehs3jFv+T0SHECeW+e4ZG9hKDYdsiPJ68fvhBx0i
 8eUkAeKcZjrYTJgfTmUpnyMdZg8VPWRV7DJSCYDSBZ54jtLgSb6oaFR4kHgFbp/FSjSfEyxpgZx
 ZGt53J+cO5KtdzehcJLDCaHcenA47p2V0KWLTTg++2TjxGvi00tjgnihjlG0sGl8Y+qB7wx3Ewe
 djeVQ2k4NMvj+BbrHnTIVsSCJglGFyZYEEF4VBmIoaUxOtf/YzEv47ch1MzVwz8EUlM7kLeoHN+
 BtiNCGHGKvilblQ==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: P2GAWAXBDZPAE4XMXOQWF5P2XFLOSTUF
X-Message-ID-Hash: P2GAWAXBDZPAE4XMXOQWF5P2XFLOSTUF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P2GAWAXBDZPAE4XMXOQWF5P2XFLOSTUF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If an interface changes the MTU, it is expected that an NETDEV_PRECHANGEMTU
and NETDEV_CHANGEMTU notification events is triggered. This worked fine for
.ndo_change_mtu based changes because core networking code took care of it.
But for auto-adjustments after hard-interfaces changes, these events were
simply missing.

Due to this problem, non-batman-adv components weren't aware of MTU changes
and thus couldn't perform their own tasks correctly.

Fixes: 8009e9f7ac4f ("set bat0 MTU according to the MTUs of the hard interfaces")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 41c1ad33..ae5762af 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -630,7 +630,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
+	dev_set_mtu(soft_iface, batadv_hardif_min_mtu(soft_iface));
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.

-- 
2.39.2

