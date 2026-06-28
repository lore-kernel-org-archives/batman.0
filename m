Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ACBC43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:29:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8ECA9840A2
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 09:29:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782631794;
 b=23LbE1rodDFOzXRgLlKZGu7K+AGST48a+jRBd+JSUpG/XV/nZFr1ALU5Gx6JBDRxbDSj6
 9Q6ZAo52q1SFPeAp3ICup9AHLKfXaiPn087oKYM1fOmJqqz/I2a9VA+C23gBfR85FddpQQs
 jtPeL6GlfxAziharudqog7Vwrb1z26g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782631794; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rmITnE0cXo8waVPczBYIMMwBi2D1iqNhAQrJzNfLo5c=;
 b=bqyohb+Lp0qjjMbs5k+5cLKFWiwpAHgDQkqUJNMCqu+46KKdWcGp8rhb+nRoDrnuS4oXK
 8zGMzyNQrhZfjHpPIN4uX/cyvXUORnbrWPn5j+HEGc9pcdgP6skzi6Q6YGnR0hAa2Px1gqN
 VKUwFto7KKcmHMQMlI/cx/RTF17jTC8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 26A3F809A8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 09:25:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782631552;
	b=uN12p738+PsVYOy3BXXBtogZpRhf/ONjnll7rFXrVRq2Dmd27vJHDB5ybuYjsjsTZ2nDFb
	tS72IMI7sWdlu2H1pwk9/OslXt+Lbox0MHiaAxegJLCR5Ut8gEIsK4A0aC32i7xulpOe1o
	lcNPmuGopkxLbsIVEzDnlDoNghk/7ik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782631552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=rmITnE0cXo8waVPczBYIMMwBi2D1iqNhAQrJzNfLo5c=;
	b=aL4cVfPqUAVKZpK2zo7Bl36fmd6CVfEJYp5a5oF70cyxAwbzd7cvThygmKjO5heXULhBgs
	9x6Urx/23xw/k6gFhoDvI/8wiIT2cR+GEwoejxd5CnS2ikYSt79rrH3p2bDOqYCYvVq0Rk
	EEPayQ0MkA3je3Gx0gxJbXjC8SKRQqQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GsidzasE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 73CF51FECA;
	Sun, 28 Jun 2026 07:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782631541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmITnE0cXo8waVPczBYIMMwBi2D1iqNhAQrJzNfLo5c=;
	b=GsidzasEOe0/WLj72lADKAa4tLUOIRSW16WVZ/KoxUDDEL3UTzaPKQCmV70KgpAmpg6OI+
	vr1gEuQjlAZ/pvmFylJuurH+eLmuHSEyaP+DDYou/8bPbCE9mZ+GOw0ogKIh2xQGqeyWG3
	ulnEsAe4284yd1a9RBxiIlfSZpLWB68=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/5] batman-adv: reacquire pointers to skb buffer
 data
Date: Sun, 28 Jun 2026 09:25:33 +0200
Message-Id: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3MQGoC/3WOTQ6DIBCFr2JmXRqBSE1XvUfjAmRQWiOGoaSN8
 e5Fu+7yvXzvZwXC6JHgWq0QMXvyYS5CnCroRz0PyLwtGkQtVK1Ey+hp2BIosYh6mkLPOJqG26Z
 urZRQYktE599H5R2MTtpm6H4+vcwD+7T37eToKYX4ObYzP/j/M5kzzpTgrXPmwpWUt1lHp1P5e
 w5xgG7bti+M1I97zgAAAA==
X-Change-ID: 20260628-skb-post-realloc-1eb51d508d33
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=sven@narfation.org;
 h=from:subject:message-id; bh=OjMC7lmXqooepAI6t8GX6IeKjj3DUjzPziKOWWbGe8g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkOZwrOn3tiN+NEo9K/V6FnLe/xci3cnVRY9Tn4x69TJ
 VzTFdmXdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmYh/B8IcnPtfFdHZL/RNZ
 R/VZmnf1N3xK0Lr6utPbau6Ecwf0FxQx/Pe3fMi7V+e7Q9iboy9Ewx7ePLaL81hRZPuVrfslu3Z
 pfWQAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZGCM4P67M6MHS6LU5GMMCW67FJRNJ5MS
X-Message-ID-Hash: ZGCM4P67M6MHS6LU5GMMCW67FJRNJ5MS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZGCM4P67M6MHS6LU5GMMCW67FJRNJ5MS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a function is called which reallocated the skbuff, it is necessary to
reacquire the pointers into the skb data. Otherwise they might cause an
use-after-free.

There are multiple such cases in the batman-adv code - some of them are
hard to find because they are only indirectly calling pskb_may_pull. To
ease the situation, annotate these functions. And based on this
information, restructure the callers to avoid the potential use-after-free
scenarios.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- drop already merged first patch
- add fixes for indirect callers of pskb_may_pull
- annotate non-skb-consuming functions which might reallocate the skb
- Link to v1: https://patch.msgid.link/20260628-skb-post-realloc-v1-1-6218ffb71633@narfation.org

---
Sven Eckelmann (5):
      batman-adv: access unicast_ttvn skb->data only after skb realloc
      batman-adv: gw: acquire ethernet header only after skb realloc
      batman-adv: dat: acquire ARP hw source only after skb realloc
      batman-adv: bla: reacquire gw address after skb realloc
      batman-adv: annotate functions which may reallocate the skbuff

 net/batman-adv/bridge_loop_avoidance.c | 10 ++++++++
 net/batman-adv/distributed-arp-table.c | 45 +++++++++++++++++++++++++++++++++-
 net/batman-adv/gateway_client.c        |  9 +++++--
 net/batman-adv/main.c                  |  5 ++++
 net/batman-adv/routing.c               |  8 +++++-
 5 files changed, 73 insertions(+), 4 deletions(-)
---
base-commit: 6f34546691685542e30c7f7a3a5612821e917560
change-id: 20260628-skb-post-realloc-1eb51d508d33

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

