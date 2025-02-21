Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5475BC021B5
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 17:29:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7F002840BA
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 18:28:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740158939;
 b=KZaSJ5K+HGLRk5YzHpeasSZ0ncZTWzWRN4Y5WHpNT6Injtt5JT+1eL/ES30ib0qdgD7L3
 edeRDX88bFvbzbO7Q8/yAubWgHbXvW11gGZp+eqHJVSiFir3B6DChHmUHaS3m6uGO6b0aGL
 zplcHE/JXy/cTLIbLrKAVhn3Tbz9/dU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740158939; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UM+zO8mMzpAneAWdErjtMzTpQ6qzZXAbNcO1ig6HFS0=;
 b=l3rMXV8FOROWMHv7Tw77e2Ua4udw9yUzTyPRh8kFp+fTvVJCwY3A2EMnG8uFlng4FrglO
 kcee9oCdFGtuO9qQX9IcfYK62QrGzWvLMGeo+scHgw8d5mko4JyN48tLLLAFKp9AxiCQkUI
 b4KWwV7++zIZJQ2UOWCXMZI62J0xP2o=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6605B808C7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 18:28:33 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740158913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UM+zO8mMzpAneAWdErjtMzTpQ6qzZXAbNcO1ig6HFS0=;
	b=yECYqeepzjvQKFLQLwpeBorNbp4/6tbx+g5CHX+8hIO80S/dYmQ295VvBUNcQsBjq67w3E
	mT4u5LC2eLUKAKoarxfXnvPXFIDUcLeiXHEnAWLItEfp92Wke6MejwA0SESqKwwFSkbIOv
	gxEipZcMqqhNOYc+FTj/0urM61UGPo4=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740158913; a=rsa-sha256;
	cv=none;
	b=DE1eJg3RUbqDr13kMrCXkG1pTh8RrMELv5ZjKhyoouyieVs9/tCMr+gh4fHJIOl+oTdbX4
	uKP+aMHlWxSTRKdLO00n/Fj7cKepVFmYLkbUeZNVZ9U8Jh00NIwpbZV8p2VOI8GRwrET8E
	isb0tPU7uwBg62di6J/fKgATJAtoCEo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=W8M5p5zY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740158911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UM+zO8mMzpAneAWdErjtMzTpQ6qzZXAbNcO1ig6HFS0=;
	b=W8M5p5zYrWpS6M0GMoOfz8ovxZuwrSTAG3Kwbd6/ovK5UCb4Ni2x/qEj6AQDhfCDZhqxvh
	VlguiMcbggexmlX9g1b95de7TmNvGwgmrkfLo7EEJzv/bHK2XNNiDBtcceGI0Iuc4K7hYA
	whFOO3xQPpYTsRdOpAs4bWQyaQjAB5w=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v6 0/3] batman-adv: add dynamic, bridged-in TT VID
 detection
Date: Fri, 21 Feb 2025 18:27:30 +0100
Message-Id: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIK3uGcC/03MQQ6CMBBA0auQWTuknVKJrryHcVHLAJNANR0hG
 sLdbVy5fIv/N1DOwgrnaoPMq6g8UsHxUEEcQxoYpSsGMuQNkcXuk8IsEdcpJEVqHIUQXeNPBkr
 zzNzL+/e73or7/JjxNWYOfxdjTeNa8rX1ZFu0OElatJ4WVpU0XKLpXH0vhH3/AgNjrWqhAAAA
X-Change-ID: 20250221-dynamic-vlans-2432aac34590
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732; i=sven@narfation.org;
 h=from:subject:message-id; bh=cC9fur+1T+z4u5AxxlQekaFZorFZZpy2TALSSvYOUmk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOk7tu/6fqbuqlTwrqkCa/fP3tmitcmO5cpxlxlfdE+tN
 rX7F6Id31HKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYSO5BRoZHp24UcZ5JD1+4
 KHbftJmVF6Pk27Ye542fdLnYxrw+PzCe4Q/H9s77EsHOYozbv+aVqk+/KiZ1PTDxrOCztU/ehc3
 fupgbAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EEIMGTH7F2KE7OI7JZ4NHUAKNKJSXVGC
X-Message-ID-Hash: EEIMGTH7F2KE7OI7JZ4NHUAKNKJSXVGC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EEIMGTH7F2KE7OI7JZ4NHUAKNKJSXVGC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

For one thing the following patchest is supposed to mitigate the
regression of extra OGM overhead that we accidentally introduced with
the introduction of the compatibility version 15, the TVLV support it
provided, together with TT VLAN support. The addition of these TVLVs
roughly doubled the OGM overhead back then, also/mainly because the
8021q and Linux bridge modules would add TT VLAN IDs 0 and 1, even if
no one is actually using them. While the 8021q VLAN 0 ID addition was
addressed in upstream already, PATCH 3/3 tries to avoid unnecessary
VLAN additions from the bridge and only adds such VLANs if they were
detected on actual traffic.

In preparation of this the internal VLAN creation was overhauled in
PATCH 1/3. This also in theory allows detecting new VLAN IDs dynamically
from traffic from bridged-in traffic. So far, VLAN IDs could only be
used which were anticipated and configured on top of bat0 by the
administrator.

However the detection of VLANs from bridged-in clients is by default
disabled for now through PATCH 2/3. This patch adds a configurable limit
for such snooped VLAN IDs, defaulting to zero for now. The issue is that
each added VLAN still increases the OGM size considerably in the current
protocol, so it is not advised to add many VLANs at the moment, without
a bigger upgrade of the protocol. Also there is still an outstanding
issue with temporarily broken broadcast traffic upon adding a new VLAN if
BLA is enabled at the same time. Therefore defaulting to zero snooped
VLANs from bridged-in clients for now.

Regards, Linus

---
Changes in v6:
- change from "softif" to "meshif" naming
- add of missing include <linux/net.h> in mesh-interface.c
- added kernel-doc for own parameter
- this is not an endorsenment of this patchset - just a rebase to make it
  apply again on main
- Link to v5: https://lore.kernel.org/r/20250201043725.15217-1-linus.luessing@c0d3.blue

v5:
* rebased to current main branch:
  -> PATCH 3/3 needed to readd the include for soft-interface.h for
     batadv_softif_get_bridge() since commit
     "50eddf397ac3 batman-adv: netlink: reduce duplicate code by returning interfaces"

v4:
* reworking PATCH 3/3:
  * removing the added exception for VID 0 again, addressed upstream now
  * replacing the specific VID 1 exception for the bridge default PVID
    with a more generic solution: a user might change the PVID or add
    other, untagged VLANs on an access port which we should also ignore;
    instead always avoid such kernel event additions if a bridge is on
    top of bat0

v3:
* fixing refcounting, removing an unnecessary kref_get() in PATCH 1/3
* adding PATCH 2/3 + PATCH 3/3
* resubmitting without the RFC tag

v2: fix a typo, a missing "to" in the commit message

---
Linus Lüssing (3):
      batman-adv: add dynamic, bridged-in TT VID detection support
      batman-adv: limit number of learned VLANs from bridged-in clients
      batman-adv: avoid adding bridge VLAN IDs through ndo_vlan_rx_add_vid()

 include/uapi/linux/batman_adv.h    |   6 ++
 net/batman-adv/hard-interface.c    |   2 +-
 net/batman-adv/mesh-interface.c    | 190 ++++++++++++++++++++++++++-----------
 net/batman-adv/mesh-interface.h    |   7 +-
 net/batman-adv/multicast.c         |  38 ++------
 net/batman-adv/netlink.c           |  15 +++
 net/batman-adv/translation-table.c |  20 ++--
 net/batman-adv/translation-table.h |   4 +-
 net/batman-adv/types.h             |   6 ++
 9 files changed, 191 insertions(+), 97 deletions(-)
---
base-commit: aaa23d95ec513d8507d8aad83b143889c55f1dc0
change-id: 20250221-dynamic-vlans-2432aac34590

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

