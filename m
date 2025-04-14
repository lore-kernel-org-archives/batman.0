Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F27C369A2
	for <batman@archiver.kernel.org>; Mon, 14 Apr 2025 18:06:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A060B847B7
	for <batman@archiver.kernel.org>; Mon, 14 Apr 2025 20:06:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744653960;
 b=TGCqw+DGGYdi8Sasm8gJTuuvwifkMRKXeOfu4Gneyi2lNCko+oGtkJ/OivPE0Bc33Fhx1
 n0y24+HkQOOTGtz8eZoEmFOgpZMpmeI/jrDUbFMcFnzA6owPg96PtNHKU8qObtiYkga2hBV
 IfIUO/THQwIftCN750w80WXafMBC3G0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744653960; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EOcHNaKvVT/0mARZxcxaig61vSP0GsRncJz7Dz1LbTQ=;
 b=Hg3J8XN9tYX9+gr2hQUSAou4oblUYqnKaXl1r31fDQ4uYTpIUPc5HR5KhT9R1E5VRLSzm
 BjocTarT1jXhc2neMZ2dAtGRMvOi95QwkONwmWBD4HKkk4DPyUOLp/zm4ElalkJAxG7kii2
 a+F54AMPsifva+zD0Q7fel924+vOyZE=
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
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 06BA284355
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Apr 2025 20:05:54 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744653955; a=rsa-sha256;
	cv=none;
	b=cBjlCtdrs1MPvOHDzRJrGqkCQCdBfBj1O2u8sVJdYxxaZciy3OGUI4LdySJofic9OQcPko
	w8/LeCEF6GwFWaNfJSgSTS/LQYMY9VRz1BEOzzl1HD9cklTBSJ52K9na7u+aIW1cmvtuHz
	YG8fV9em/8/FM0j1px+KpsBBoG9K0NM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vSMFu7i0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744653955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=EOcHNaKvVT/0mARZxcxaig61vSP0GsRncJz7Dz1LbTQ=;
	b=xHsktsYxlODuVUe4B7vWnrPSnnwvMYZWJJ5pm/kA9FrscRK53NLco+hQbPcO+MnzitCLyk
	PLYaNwOGMoIQceLFQXelj71P3nGbFdG52LGP/gGkLpBwEGFXY3nLeZmyQ4BUs7vxtmGlc3
	ERtwEAWWZN43xejNivifuST/vTNKI98=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:99fc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 255F2202C6;
	Mon, 14 Apr 2025 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744653953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EOcHNaKvVT/0mARZxcxaig61vSP0GsRncJz7Dz1LbTQ=;
	b=vSMFu7i02yBYutbzGc4yaiiv848nkAprKsfWC59Cm0HKIA6pep/onmXU+uxnVS2Ki16pMs
	Hu1zg6PYkolTC/JkAezLlNPSuolL8+I9VKBl6B9phFqiCc5JAGgiHVOGaZzxg4cj0ylOyw
	tfIiAzFkwhcpfqToOu7NcFI9ZM0l6j0=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Apr 2025 20:05:37 +0200
Subject: [PATCH net v5] batman-adv: Fix double-hold of meshif when getting
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
X-B4-Tracking: v=1; b=H4sIAHFO/WcC/3XO0QrCIBgF4FcZXudwpnPrqveIMWz+TmFpqEkx9
 u7ZriLo8hw4H2dFEYKFiE7VigJkG613JfBDhSYj3QzYqpIRJZQT1hCs/OO6wGj8okZtn7jTRHZ
 CCypVj8rqHqDUu3hBDhIaSqmDv+FkAsgvjPREHDllNeei6Xrc4JjBnZ0MWqZyo/Zh/ojGxuTDa
 7+Y2e7+fZNZYahuSauhmyhhP9ywbdsbojOGnfQAAAA=
X-Change-ID: 20250410-double_hold_fix-8f0a87f72ad9
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com,
 syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com,
 syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com,
 syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com,
 syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=sven@narfation.org;
 h=from:subject:message-id; bh=Bf2kK2Vw4Tc37/Kz4l3ukL8jF1/nrr/RnuXgsQDbdLs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOl//apd1TRu/bi/dqudDOvvmMppzPUSNf1VsTduprE3h
 7Kcyz3TUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIQCvDX7FNwhP/1qwsSJNa
 W1/2Omxx+KslTe4d2w4mNhzw2M6w8BjDX/EHS6N6JzV9XJnaGp7y8rLpsj11/PMKbpRkctif9eD
 pZgIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YFZT6YJCNJLJES3UXAV2ODGIEOCMRAET
X-Message-ID-Hash: YFZT6YJCNJLJES3UXAV2ODGIEOCMRAET
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YFZT6YJCNJLJES3UXAV2ODGIEOCMRAET/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

It was originally meant to replace the dev_hold with netdev_hold. But this
was missed in batadv_hardif_enable_interface(). As result, there was an
imbalance and a hang when trying to remove the mesh-interface with
(previously) active hard-interfaces:

  unregister_netdevice: waiting for batadv0 to become free. Usage count = 3

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com
Reported-by: syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com
Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Reported-by: syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is skipping Simon's normal PR submission to get this problem
fixed faster in Linus' tree. This currently creates quite a lot of wrong
bisect results for syzkaller and it would be better to have this fixed
sooner than later.
---
Changes in v5:
- added Suggested-by: Eric Dumazet <edumazet@google.com>
- added Reported-by: of various syzkaller reports which were affected (during
  bisecting) by this problem
- Link to v4: https://lore.kernel.org/r/20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org

Changes in v4:
- resubmission after 24h cooldown time
- added kernel message during hang to commit message
- Link to v3: https://lore.kernel.org/r/20250409073524.557189-1-sven@narfation.org

Changes in v3:
- fix submitter address
- Link to v2: https://lore.kernel.org/r/20250409073304.556841-1-sw@simonwunderlich.de

Changes in v2:
- add missing commit message
- Link to v1: https://lore.kernel.org/r/20250409073000.556263-1-sven@narfation.org
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f96626531053bbf8f58a31f28f625a9d80f9..7cd4bdcee43935b9e5fb7d1696430909b7af67b4 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(mesh_iface);
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);

---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250410-double_hold_fix-8f0a87f72ad9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

