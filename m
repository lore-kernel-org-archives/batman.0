Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D08C87FCB
	for <batman-adv@archiver.kernel.org>; Sun,  3 Aug 2025 06:47:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D3AEB8487B
	for <batman-adv@archiver.kernel.org>; Sun,  3 Aug 2025 08:47:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1754203637;
 b=R5ySkbIuehx+3hVI/2BUjpQtgSNy0r4oPmnf/sKYzTN6LKYJ37q2PGWyZLCBSbYrGOPk7
 P5Ez7HqcBgy7q6VfQQvNeSIXx5vIH7mxqdj1Fb5ImNXouijySnSz/a79XSQm++KDwgpTX7V
 QFRRwjO0pcOElGYJCJLSREtmtJQo5hs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1754203637; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oWdVgLiowcGxSIGeF+3cO5TGD5QQdrrYGZeJ0UrZkV0=;
 b=a5ds+IW45qag3+VKDLsh/NifFsG5gau5BW8h6iHBVz8qV0iWMU7eySfrtc/jUgVQln/bH
 aBU4sYxLlg826mS9W3TJVYVR6HJYH6+4PDLBqX8MjMMs/ftyg84fE6mFFS2t4cLDWYZ5PqR
 KM2JTmkDVPyIp5pfq936SHSyhDMrmdE=
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
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D8634845AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  3 Aug 2025 08:47:00 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1754203631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=oWdVgLiowcGxSIGeF+3cO5TGD5QQdrrYGZeJ0UrZkV0=;
	b=pS53gSYVpjWdwKCQaosEHFhMTVV/ZQ0kGhOSGHdKUjcNvbVpuVi0YwAQvyLMt5ymCbcb08
	F1ZWUtDzMYXiv874grB2vi0kMDHPO6yQ9dBMYih0FjAaZpM6GrPQaddsf/6Bix0EPTk7o6
	XyY9jo3beyi6YJzTeyZOFZNex8u1c+w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fJcbOPDH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1754203631; a=rsa-sha256;
	cv=none;
	b=hV8UiyMYlHkUAmrqmfRFautgssY7aETI7NSgmJNtoaJjVzcuty7FW3xX9tL3rG9IlrundI
	F8GkC/uiAVclDezMLFEBSqkj1MH8ieQ+lgCxXQN9jmVmjC/Zf2JOyjzsDmD0wMh8rH5Dx3
	9q/dcvjp3moYsI865OGi8FRnN43qY+A=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:99fc::8c24])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id DED0F1FE05;
	Sun,  3 Aug 2025 06:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1754203620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oWdVgLiowcGxSIGeF+3cO5TGD5QQdrrYGZeJ0UrZkV0=;
	b=fJcbOPDHSH5MPzOe+G8+UXntw2cFmG/FYGjbPBkDHgb3nN07yKXXAfjkZ368mK+zh/Excm
	36La84v2vpTbhwmfUFESsTTUoqbMznRcMED8fHeY9OiYW+DNiLfYIGrvHunS+niiY4TRID
	mBxBJyqu5u9s2Yy9ItmsNRM1arQW9xw=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/2] batctl: Minor netlink related bug fixes
Date: Sun, 03 Aug 2025 08:46:54 +0200
Message-Id: <20250803-various-bugfixes-v1-0-017f917ea98c@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4Fj2gC/x3LTQqAIBBA4avIrBPGSsquEi36GW02FQ5GEN49a
 fnxeC8IRSaBQb0Q6Wbh8ygwlYJ1n49AmrdiqLG22GOj7znymUQvKXh+SDQ6tG3rfWecg7Jdkf5
 QrnHK+QOHpSNOYgAAAA==
X-Change-ID: 20250803-various-bugfixes-090544ff7199
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=sven@narfation.org;
 h=from:subject:message-id; bh=4LvKPVQWJ6Yi85hsm3mJY8yjeTG7cR6YpAPw4Wur5LA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBn9rPcDHv4tnDF5Vd0U86gnUxyD9u7U3qcffDfg6Q2zL
 4rxSYsndpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm4hvNyLD303+rA+x//usm
 XOlNbf+YmnelQnhvb576iWQ9j6V55/MZ/op13g9cIhO4VP9L3b73Md6/FLKF1L8br7sf/PVh0+R
 5bswA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CKG7PFKPNDA5JOQI45UV2TR5NFJWCOHQ
X-Message-ID-Hash: CKG7PFKPNDA5JOQI45UV2TR5NFJWCOHQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CKG7PFKPNDA5JOQI45UV2TR5NFJWCOHQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The code to get the hard interface name for an even was accidentally
checking for BATADV_ATTR_MESH_IFNAME instead of BATADV_ATTR_HARD_IFNAME. As
result, the fallback code was always used when BATADV_ATTR_MESH_IFNAME
would have not been available.

Luckily, at the moment, BATADV_ATTR_HARD_IFNAME is always available when
BATADV_ATTR_MESH_IFNAME is set BATADV_CMD_SET_HARDIF events.

The opts.remaining_header string is alocated before the netlink callback
object is created. But the callback object allocation can fail and the
function will return in this case. To fix this, either the string buffer
must be freed in this case or the opts.remaining_header allocation can
simply be moved to a later point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batctl: event: Fix direct parsing on hardif for set_hardif
      batctl: Avoid memory leak in print_routing_algos

 event.c        | 2 +-
 routing_algo.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: e690b207753a122eb30b8eaf8b504c81b9178b79
change-id: 20250803-various-bugfixes-090544ff7199

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

