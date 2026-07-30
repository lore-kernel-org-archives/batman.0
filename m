Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC31DC55164
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 17:35:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 05AD48315F
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:35:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785432907;
 b=ogFUFqQkwRO0wEtcTZ0gjLrVy/CHCorb04VZ9SY4521WFw8TP91AW/xpTBsLKL68AM1C0
 WEJhrxlYnye09mEA9pnCDu9QJfTd6bcr114W/GkpckEDP6vig5zwFsn8bhqwbs3YpVspYc+
 OQxcD0SrN6hw5IreuMEWxBAY18YPO/A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785432907; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WCkyAhEiNbPN3zlM93jqc+Ac6pUlXP9cNJ3Jf5xA3dU=;
 b=fhwKAsCPrB/PmIXxm9cNtoVMcM0DsdeJpR/SiQOLhQlhU/gxwKdL77cnKynpJhpsuhWLn
 /9pJGdCX0IsU7OPz3TQY9kh19vd/vREE4gDsSn1T7UEXeko8cjhVmkC5w+sg/TjEhuobTSk
 LtR/WnFi2jfSQNTbFRiyXt2OJ/KM9ww=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 69FD88315F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 19:33:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785432808;
	b=YAtCYlyfaKoPBizuMdBfHe8JsvauEix2BGD4ujmuctvQq0cqSXzt1tgI+yYF2YALSTDpen
	g9vqXEXptzhHH6rJOG/CNFEVT9KBy9i3uA+zIjqNzaJLd64TO2ZVQeN6O2RwItZ5asDAJr
	1sRsRREMae5llTYn4XffZvjip4b6Kjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785432808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WCkyAhEiNbPN3zlM93jqc+Ac6pUlXP9cNJ3Jf5xA3dU=;
	b=4EXGAsFYmwXOeW4B62Iue9DPqIt0a9NjbD4cvbMvk/TJlH7bu2XbIzMzSBVRrkdJksMuPZ
	d5b07doqMXbiz/q00SEBuj7xhZdwj42eotDF7nN/JGxfYWoMdSaXNMf8oCi8sGPdVcvF2N
	naGecFcG/ujmuZ/W0F+dKK0754NVN7c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=1psw0a8e;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 14E9620CE8;
	Thu, 30 Jul 2026 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785432804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCkyAhEiNbPN3zlM93jqc+Ac6pUlXP9cNJ3Jf5xA3dU=;
	b=1psw0a8eDm5j9SmAb5s/0LrMcO6zxUgE28z5edI7mCiEyVgpFZ0/dQa05yIop62PtjVjPO
	a0FChROJwzIIKNHfOhOFPtHiokS0GorJcZZWN86csgxYP8vRD82onX8QVNukxIHpZAT2Eh
	PPRmb1F9tok/IK0cGaH500UnmiljFP4=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 19:32:58 +0200
Subject: [PATCH batadv 3/4] batman-adv: tt: don't uncount never committed
 clients on pending purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-tt-fixes-v1-3-64e9e525d555@narfation.org>
References: <20260730-tt-fixes-v1-0-64e9e525d555@narfation.org>
In-Reply-To: <20260730-tt-fixes-v1-0-64e9e525d555@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=sven@narfation.org;
 h=from:subject:message-id; bh=XdYPpB2WbBV9+1UXWjBZdyIBwDKuN0OLvh8/UnBHaeA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZXedubw+9bab2rOxyduzFOOaf0daLt5+YqdX3p8D/1
 bynSempHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJrP3MyHDudcDmEubHRjs+
 R81It7vxW+zeDLm/cnntFm3edZk/nVsZ/vBOWtbx6UDW1h8rgpLqT7W9CHXtvMZo1M1xW7X5aH2
 HES8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KVAKEZ7RQPA6HO6EWC3FVWM7TFZKA67D
X-Message-ID-Hash: KVAKEZ7RQPA6HO6EWC3FVWM7TFZKA67D
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KVAKEZ7RQPA6HO6EWC3FVWM7TFZKA67D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_purge_pending_clients() decreases vlan->tt.num_entries for
every entry it unlinks, but an entry which still carries
BATADV_TT_CLIENT_NEW was never counted by batadv_tt_local_transition_new().

batadv_tt_local_resize_to_mtu() calls batadv_tt_local_purge() and
batadv_tt_local_purge_pending_clients() directly, without committing in
between, and it halves its timeout down towards zero. Once the timeout is
short enough, batadv_tt_local_purge_list() marks even freshly added clients
as pending. And each of them decreases a counter it never increased.

Consume the BATADV_TT_CLIENT_NEW accounting token here as well, so that the
counter is only decreased for entries which were actually counted.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 248b2966..7907f1c6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3991,6 +3991,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	struct batadv_tt_local_entry *tt_local;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
+	u16 old_flags;
 	u32 i;
 
 	if (!hash)
@@ -4011,8 +4012,16 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				   tt_common->addr,
 				   batadv_print_vid(tt_common->vid));
 
-			batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 			hlist_del_rcu(&tt_common->hash_entry);
+
+			/* An entry which still carries BATADV_TT_CLIENT_NEW was
+			 * never counted and must not be uncounted here.
+			 */
+			old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+							&tt_common->flags);
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
+				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
+
 			tt_local = container_of(tt_common,
 						struct batadv_tt_local_entry,
 						common);

-- 
2.47.3

