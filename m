Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918A9C43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:13:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2E2878115C
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:13:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828817;
 b=Bu3kgMqHGNopXJgZMxOfUHRQePmRzd4+KwlrLBl4uMI2zUQIk+xsjIdpCGqDZQXnZYum9
 p22k5m8JOlS5AlQUMEzR+klaPn8G+letqVLdCmWnziKgdVyKoCwCEAGL/bxYbax1IEJaCcz
 HF2ITQOhi5zI1nt0Qskzqd4o7/W+q8I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828817; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QXJeX55aPHneDee3MRppeZCCDxksy2cihw5wER1FZrE=;
 b=dDpSBRBK8uN+rCjJB+3a/9oIOXvvap2kBbN9hnFhHcPpl7nxbJY3CND4fOeNj0D3WTu56
 Uvnfe+aWKVNc+XRx4EjKN584ythy7mflq2HqnbfJkGv7Ct4QpV7t3nhSa75qes29wF/AWu0
 dJj9lK+rVQjtrvPAE5QIs0WVES6mlkc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1C71C81091
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828393;
	b=aCgynXrYy/UnlZGkjBlcoqmM4Hv2aAJ69Dk/GCpv7oGalNwPf6oWqKUYqr/0ZV2C3giq4u
	nYa7jbW8w3041YpBo5RY72IANNfDFm/aEeb0vtC5KWqVRnl0/cfF/ar/bjnKHeKB4Knwed
	1UpwOE5/6Ei9WYos8jvbdscXN11l9NE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QXJeX55aPHneDee3MRppeZCCDxksy2cihw5wER1FZrE=;
	b=KcK+Zkl8/7/6+teuAtSwT8kZDpYLU9y73GdAWe8GISZE7FKJxpaS5rqTHeJor9+wozojHW
	TkERrTclHUc0yTJ7h1N0ErBOPTNUhHY3+7tTxDIUvLE1DrzTXVmCH7Wn8yg0KZECF5B9GA
	Q+khS79iOL5GKPuLrAJjKsuuhT06yTU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=mK2r2nAn;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXJeX55aPHneDee3MRppeZCCDxksy2cihw5wER1FZrE=;
	b=mK2r2nAnU16thNu3idBKmFf1HwjqU4xBrkZPAkvS2o9L+TwCGtprtZjtwklXuS84qdwarP
	2sAb3WbryzLaE3hyedDMgZyC7Yh27pJOea7Aikq9f77lwyddePYT5bP3N9P+LwgfVZVMGg
	cJAUDrX86I3lpVNxYYHyxeKhzKdYci4sixgcL6UAZcFBdfpmPeyE6AOlwcA0fVbK9DM1P7
	Y14Et9+xmBEE+jbVsHWJcY3bOpMCr8fl4CV2Ka9d+AFxuh7NDtOJryOueqO0ig1GzZyiKE
	HaNjwgacN2Ae/H1VOt8C/qZx+4kfstz8JvcAPvmFuSYm1S1SOoHe3ue4ohpZdQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Nora Schiffer <neocturne@universe-factory.net>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: make hard_iface->mesh_iface
 immutable
Date: Tue, 30 Jun 2026 16:06:11 +0200
Message-ID: <20260630140623.88431-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PCUFFVEZ53D2QEGE22LUCG3RNWETSDWF
X-Message-ID-Hash: PCUFFVEZ53D2QEGE22LUCG3RNWETSDWF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PCUFFVEZ53D2QEGE22LUCG3RNWETSDWF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

With the hard_iface now being created for a specific mesh_iface, it is
beneficial not to set mesh_iface to NULL when the interface is disabled,
but instead keeping it immutable after the initial setup of the
hard_iface. By also holding the reference to the mesh_iface until the
hard_iface is released, hard_ifaces iterated over under RCU will always
point to a valid mesh_iface.

Co-developed-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ace81348ddef7..a0b8b06f9a644 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -63,6 +63,7 @@ void batadv_hardif_release(struct kref *ref)
 	struct batadv_hard_iface *hard_iface;
 
 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
+	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
 
 	kfree_rcu(hard_iface, rcu);
@@ -829,8 +830,6 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 err_upper:
 	netdev_upper_dev_unlink(hard_iface->net_dev, mesh_iface);
 err_dev:
-	hard_iface->mesh_iface = NULL;
-	netdev_put(mesh_iface, &hard_iface->meshif_dev_tracker);
 	batadv_hardif_put(hard_iface);
 	return ret;
 }
@@ -871,7 +870,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
-	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
 	batadv_hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
@@ -881,7 +879,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (list_empty(&hard_iface->mesh_iface->adj_list.lower))
 		batadv_gw_check_client_stop(bat_priv);
 
-	hard_iface->mesh_iface = NULL;
 	batadv_hardif_put(hard_iface);
 
 out:
-- 
2.47.3

