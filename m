Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B941BCD98F6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:01:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 18D2683ED0
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:01:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852468;
 b=czw47pXycNpJRVdX//eAzn4/jOCVPNYmCwYdytw+mFfWIeuagP3eYytuxE9T6ZGgQs5CX
 IL/JWba2S+JGw95mQ5CXc9SNncZVdRbmMmEC9lULmmG1pOBhSW20BEXlek0F/D3OSiSINnD
 2/73jRkFII3/oHY81wZD1pT3IT1kFAs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852468; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qo0iYtAoCh7dGR3yHCIMed/owbEgbIwKhpDMlELxzWw=;
 b=Vd6DGRxgGgTo0Rj4T6oRvFdBtTWlKxnxTVDpr9z8O+mi7b35V3AnTsXyeR0vGO+2tLqdz
 fiXaITOBedw1ZFlaMQNMgNK/AEAw81XkucLo3sTVvTlHwg6+VDQCzdBivE7DCuRbZ6krFSX
 LagImdnGwP2vHlWPgE08FdGQ5D3dVeU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 997BB8081E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852453;
	b=yWWXyE0l46iaapw7jDxXt9yErW1KmgMiq6g1Kr76MTakfdVJN6/3VeT7XqnPI+UgPzafoF
	er1KSVXfuffo8NcOxSOIp0/K/r51jb/Vr91yd5o9KnP9gLwuKrCsDAUm6DJrT47TGTcl7d
	LhGDp5xZiiJeHy1lxq5W05ZJzwXcJHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qo0iYtAoCh7dGR3yHCIMed/owbEgbIwKhpDMlELxzWw=;
	b=1idcBbtqrxCKPpHDu2JxpF9MLOP9I8xiwcRfCs3bff/Wu2EdGxEu3w9XWZ6Hfi99TgehyU
	VgNaQPGHfIQGnQci3/9oDCHK73A2uA6HoOA8YXEG/JkhIYVFOswHM0gYQrq4DHtpcaJ93o
	rGrQmt0bBTfLMBpWtq9ZjCBWqWOLCxs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=bEJhaM3t;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo0iYtAoCh7dGR3yHCIMed/owbEgbIwKhpDMlELxzWw=;
	b=bEJhaM3tV3Ir745fax8850NlyCjwpARi0UXkyIOjVWuXppiz+t8EinUOx9Ph2rO54kaGgT
	LSe17krS+6Q7q3qHw7VCrw+6KhQv9qMxu++tIzpVvAI99pvf0cMXUE7h1XRyHk91+qIsSB
	NxJQqfiw+pIJa75F9uMOloZcLD4egBGMV3fVlSrrZse197OX9JSyGzKZ/83sB/7jJ0kT6R
	bw7QiDOJ39kO+lmyjLQUpwKqQ9ipBjqiQcEt9bqANLeNffpnWj52eL0W1SYcQjPfE76vMH
	Ow5u3YRSWzy3Qvwy3NTs8DVuZ2Yl+Sej66yAVhgVCzzzwdI+Zd+1oSfiSSl4oA==
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
	Nora Schiffer <neocturne@universe-factory.net>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 01/15] batman-adv: gw: don't deselect gateway with active
 hardif
Date: Fri, 19 Jun 2026 09:00:31 +0200
Message-ID: <20260619070045.438101-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4K3E3ACKNPUC6G2MIIYHDDFO2QCZW5YB
X-Message-ID-Hash: 4K3E3ACKNPUC6G2MIIYHDDFO2QCZW5YB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4K3E3ACKNPUC6G2MIIYHDDFO2QCZW5YB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The batadv_hardif_cnt() was previously checking if there is an
batadv_hard_iface->mesh_iface which is has the same mesh_iface. And since
batadv_hardif_disable_interface() was resetting the
batadv_hard_iface->mesh_iface after this check, it had to verify whether
*1* interface was still part of the mesh_iface before it started the
gateway deselection.

But after batadv_hardif_cnt() is now checking the lower interfaces of
mesh_iface and batadv_hardif_disable_interface() already removed the
interface via netdev_upper_dev_unlink() earlier in this function, the check
must now make sure that *0* interfaces can be found by batadv_hardif_cnt()
before selected gateway must be deselected. Otherwise the deselection would
already happen one batadv_hard_iface too early.

Because a 0 hardif count from batadv_hardif_cnt() is equal to an empty
list, it is possible to replace the counting with a simple list_empty().

Cc: stable@kernel.org
Fixes: 7dc284702bcd ("batman-adv: store hard_iface as iflink private data")
Reviewed-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 60cee2c2f2f41..03d01c20a9548 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -814,30 +814,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	return ret;
 }
 
-/**
- * batadv_hardif_cnt() - get number of interfaces enslaved to mesh interface
- * @mesh_iface: mesh interface to check
- *
- * This function is only using RCU for locking - the result can therefore be
- * off when another function is modifying the list at the same time. The
- * caller can use the rtnl_lock to make sure that the count is accurate.
- *
- * Return: number of connected/enslaved hard interfaces
- */
-static size_t batadv_hardif_cnt(struct net_device *mesh_iface)
-{
-	struct batadv_hard_iface *hard_iface;
-	struct list_head *iter;
-	size_t count = 0;
-
-	rcu_read_lock();
-	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter)
-		count++;
-	rcu_read_unlock();
-
-	return count;
-}
-
 /**
  * batadv_hardif_disable_interface() - Remove hard interface from mesh interface
  * @hard_iface: hard interface to be removed
@@ -878,8 +854,8 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
-	/* nobody uses this interface anymore */
-	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
+	/* nobody uses this mesh interface anymore */
+	if (list_empty(&hard_iface->mesh_iface->adj_list.lower))
 		batadv_gw_check_client_stop(bat_priv);
 
 	hard_iface->mesh_iface = NULL;
-- 
2.47.3

