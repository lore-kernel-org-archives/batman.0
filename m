Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DB6CCD1AB
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 09:13:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F0E31849D1
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 11:13:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1761297182;
 b=M49bWtGT1e/U4NP4iweMXEb6DCcqLR7wA9FiIt7QyKfxZQLKrvNj9oLrDlpqG3WgdcMe9
 lMk0gLLONhhArzV4TdiyfDC7z7T7OREtcgUCXm4OD04ERxgHmWXalrKZ1hWldf5FTq+2SXb
 BXKd1D2YSE6yj0HJ4V2yvV+KJXsCiZg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1761297182; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GYItv4LjxGI9QAr2wC0HDDFkMftXC4Ia2yfMnKbpSXU=;
 b=dDLVo69bvX21APCvib3McdKD24+l2FsNQ6aH91KY6TY+JS7zr9f8oCTPCAuN5sgIBsQxh
 qWUMrO9NiKrWvANxPytReKw2Yo/onNocUN5iq7wKYbrzdIY+wx8pBk2V1z0vLNZx3fz0XQi
 7dfNzcQhCL0qEFnvObVt3njSfpQ0yqc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BBCE684935
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Oct 2025 11:12:14 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1761297144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYItv4LjxGI9QAr2wC0HDDFkMftXC4Ia2yfMnKbpSXU=;
	b=jMm7enW5eUxiZv2egqtExih1xpztZjS2rbtz6T6R9eppe86fPfyz4Dsmj/5fYsPDRjqOpU
	hlUyVg0fz1KA4nXb5Gw0C9vAsF/go1gV2+JkJrSkJezVdvmQDK120DI3/JUdzjIDq11h4B
	XgxZzQCxUk4UAipFa1x5hRTf25ZnY5Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1761297144; a=rsa-sha256;
	cv=none;
	b=xGvAKoHodzQkX9n+nyCKKGNDAL3iSFe0TnZmpXbsi+GSaolOA7mKPON6TQLvG94txUOEWo
	E+gDuIJRnG9ixvnHvYegE3ftl62CJTyP+QeUqsIGfY+x+3ZPvGo/bsBuTI9dK7G9Qib9hz
	EqKiAB4eAFmgUzXoyur35iIV2Vs/uzY=
Received: from kero.packetmixer.de
 (p200300c5970781D8b076411Bb4c554a3.dip0.t-ipconnect.de
 [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BEF03FA14B;
	Fri, 24 Oct 2025 11:12:13 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/1] batman-adv: Release references to inactive interfaces
Date: Fri, 24 Oct 2025 11:11:50 +0200
Message-ID: <20251024091150.231141-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024091150.231141-1-sw@simonwunderlich.de>
References: <20251024091150.231141-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 24JAZZOA7OX6CTZCGKX45J4TMJKDVLU5
X-Message-ID-Hash: 24JAZZOA7OX6CTZCGKX45J4TMJKDVLU5
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/24JAZZOA7OX6CTZCGKX45J4TMJKDVLU5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Trying to dump the originators or the neighbors via netlink for a meshif
with an inactive primary interface is not allowed. The dump functions were
checking this correctly but they didn't handle non-existing primary
interfaces and existing _inactive_ interfaces differently.

(Primary) batadv_hard_ifaces hold a references to a net_device. And
accessing them is only allowed when either being in a RCU/spinlock
protected section or when holding a valid reference to them. The netlink
dump functions use the latter.

But because the missing specific error handling for inactive primary
interfaces, the reference was never dropped. This reference counting error
was only detected when the interface should have been removed from the
system:

  unregister_netdevice: waiting for batadv_slave_0 to become free. Usage count = 2

Cc: stable@vger.kernel.org
Fixes: 6ecc4fd6c2f4 ("batman-adv: netlink: reduce duplicate code by returning interfaces")
Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a464ff96b9291..ed89d7fd1e7f4 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -764,11 +764,16 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+	if (!primary_if) {
 		ret = -ENOENT;
 		goto out_put_mesh_iface;
 	}
 
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out_put_primary_if;
+	}
+
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
 	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
 		ret = PTR_ERR(hard_iface);
@@ -1333,11 +1338,16 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+	if (!primary_if) {
 		ret = -ENOENT;
 		goto out_put_mesh_iface;
 	}
 
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out_put_primary_if;
+	}
+
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
 	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
 		ret = PTR_ERR(hard_iface);
-- 
2.47.3

