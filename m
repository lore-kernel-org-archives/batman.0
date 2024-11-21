Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EAED743FE
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 18:03:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BBF29842FC
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 19:03:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732212181;
 b=GZZwNs2s6X8Z0BRKrc7Q+XkitjDLjZ+976uNF72uDJoSzg0KVXYOUajynPttxizCmwbel
 FHXv60Bq56bzS7eZ4ClO4sNcC009o4z117jCLycH8yN9Ld8zrzHw0uJJlj705drzu7lNHAz
 8P+8PMlVeXSP1VZsfsc65A6nzpW/+K8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732212181; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LRDgVmHAGnVLbyGD7CRMq4dNOR0H8kVned55nyAokn8=;
 b=DrPehL0GFGrdCqp2te0AXHMYQd4duebb2+gm2px9hi0w53o6pZGaqY900pT9q/5InuKSM
 P/JiH8YL9hZlbfgFBlA+Ltoe7p4STEQ8NBacdLHD7wbUc2kKUGPKjdPimlwj8Tr2CG222vj
 nR/9BzbNCPdIVZoXJOdCdZTpLcFacnU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5B665801DA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 19:02:50 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732212170; a=rsa-sha256;
	cv=none;
	b=n7E/Bwd3gPDlqb/pzInmtMJ3DTxDVYQKcqYHtXeGVoP1XP7kHDSLx1eDAYSqROKhnJBSrC
	v5lWwUDopPDFnPwJApMB5pS0qvD1Hk07TPB3s2ABBQklK7Upm84/YOUHZVt+R97Mf27/14
	M2kWLcPuaWzRdHjig5Pur/JR8EYSP2Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=O0n5D2Qv;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732212170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LRDgVmHAGnVLbyGD7CRMq4dNOR0H8kVned55nyAokn8=;
	b=iJzgZMn+rty1MhfuJGEl8GuDgZdNNN0+flaov8syVBDYL8+LwNylgx7HviTZlKcovtWINm
	Anx+dFqqBQJc8rwXHdA9rZuVoNrdEvePCV+W6CaNCampK7ZO3R7oYTbBiAA8C/KGjYOE/Y
	AAyXQTJrkagEU+5MuhQx2BJs7saKAEw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732212169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LRDgVmHAGnVLbyGD7CRMq4dNOR0H8kVned55nyAokn8=;
	b=O0n5D2Qv+0AA+P3LocFK9Ggg8+53bsq2kOeH1vA6pSj0j88XguJYsNiExgF2MYO7cexiwK
	k+h+AIcD+LXWHFaFzfiZYJk9BmZBNXNO+BPUQylTr8jQl/oVym/NgygeWGR4BM33axbu5k
	ENcVrZTRzLWkudWn/nQDSVSYmIew8DI=
From: Sven Eckelmann <sven@narfation.org>
To: Antonio Quartulli <a@unstable.cc>, Remi Pommarel <repk@triplefau.lt>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH v3 1/5] batman-adv: Do not send uninitialized TT changes
Date: Thu, 21 Nov 2024 19:02:43 +0100
Message-ID: <4345009.mogB4TqSGs@ripper>
In-Reply-To: <Zz9MrP6LBw0eY_Uv@pilgrim>
References: 
 <cover.1732124716.git.repk@triplefau.lt> <Zz88AYyDTv5W9gQk@pilgrim>
 <Zz9MrP6LBw0eY_Uv@pilgrim>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3673567.hdfAi7Kttb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: IWKBYA5H3PI5NMQ6FXRN6YSVBJPT4EUH
X-Message-ID-Hash: IWKBYA5H3PI5NMQ6FXRN6YSVBJPT4EUH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IWKBYA5H3PI5NMQ6FXRN6YSVBJPT4EUH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3673567.hdfAi7Kttb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Nov 2024 19:02:43 +0100
Message-ID: <4345009.mogB4TqSGs@ripper>
In-Reply-To: <Zz9MrP6LBw0eY_Uv@pilgrim>
MIME-Version: 1.0

On Thursday, 21 November 2024 16:07:24 CET Remi Pommarel wrote:
> So the patch would be quite similar, only tt->tt.changes_list_lock will
> be taken sooner in batadv_tt_tvlv_container_update().
> 
> That will fix the ADD between two read situation as you described
> though.
> 
> Do you still prefer this option ?

I can't speak for Antonio but I think I would prefer for the fix the current 
version. The locking one would end up again with nested spinlocks and maybe 
more refactoring. And it might be nicer for the stable backports to have less 
noise in the patch.


Btw. just noticed that the code (not in your change - but overall) for the 
filling of diff entries could have been something like:

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -980,6 +980,7 @@ static void batadv_tt_tvlv_container_update(struct 
batadv_priv *bat_priv)
 	int tt_diff_entries_count = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
+	LIST_HEAD(tt_diffs);
 	u16 tvlv_len;
 
 	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
@@ -1011,9 +1012,10 @@ static void batadv_tt_tvlv_container_update(struct 
batadv_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	bat_priv->tt.local_changes = 0;
+	list_splice_init(&bat_priv->tt.changes_list, &tt_diffs);
+	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
-	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
-				 list) {
+	list_for_each_entry_safe(entry, safe, &tt_diffs, list) {
 		if (tt_diff_entries_count < tt_diff_entries_num) {
 			memcpy(tt_change + tt_diff_entries_count,
 			       &entry->change,
@@ -1023,7 +1025,6 @@ static void batadv_tt_tvlv_container_update(struct 
batadv_priv *bat_priv)
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
-	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
 	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
 				     tt_diff_entries_count);


And then you can also move this before "tt_diff_entries_num = ..." and 
save the corresponding bat_priv->tt.local_changes for the spliced list to the 
inside the lock also in a local variable. And then operate on this variable 
for the other decisions. Of course, you must still clean the local list in 
case of an error. Which of course would slightly change the behavior in case 
of an allocation error in batadv_tt_prepare_tvlv_local_data (which would 
previously kept the list as it was).

But if it would be done like this then we could also remove the READ_ONCE and 
not introduce the WRITE_ONCE - just because local_changes is only touched
inside a locked area (see changes_list_lock).

Please double check these statements - this was just a simple brain dump.

Kind regards,
	Sven
--nextPart3673567.hdfAi7Kttb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZz91wwAKCRBND3cr0xT1
y+5VAP0czIadHK+PkDe97j+y3r303edJJI745hOPit7umCNVAAD+PCRgzx/EHdXf
FHehkxD0WxwvF3D4u6G+pTB3WqLAGQc=
=tNrz
-----END PGP SIGNATURE-----

--nextPart3673567.hdfAi7Kttb--



