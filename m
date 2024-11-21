Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C8D75BD7
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 08:43:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 603F58421F
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 09:43:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732178598;
 b=gkZ/J4/JuLKIkC9srSDM1lkS1Y+g+dEp4GwZWvPAiWuYcUEvTxBPLLzc5jgk4rdj1s2fM
 Z+l6gdrLtUHUHhUB687aBnrFIrLNHKDYW1LdjY5HscPpVj3c+pV7J8gh1JJSkPbWgqI3p2n
 Jy71Zpt6mZgO9xXo5DI9WPG7aRM/y7I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732178598; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9PIUovPQ3Qpu40g5idgy+YBrHwRiF0tBOcReMK6auKw=;
 b=KiOZzsfsdWsH313rJqJg3d1ZQRiuT6atgL8Qm4y7OZP8l9KLLf13yw3suFsEtifawGXMW
 +KfmttwsNlvKrHCBTuRwKSc0cnLIufIZ1jpofDrARGvI+rjwQ3o9uA4kG0Fy64PnH4mZoE3
 U6V2QnGwnMtp7r4KVqTTO+5qKu3ZmS8=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 38B978158D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 09:43:06 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732178586; a=rsa-sha256;
	cv=none;
	b=lTiAhIfOluExetFoIQ1OraCmY2TvoNToQkfgRli+M93uvD7WKOcl2tSIw7M9uLMfx3E6Al
	3i9+h/TrWLotGox5i1UPQW3Cqp34mmqnye3mUCGD9puUV0Y9m5Xp+ioHBoKcvlVysMl2mQ
	EMk0VVzRRalGhi3ZnJuabQxtF5X9778=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tn8zHUQ3;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732178586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9PIUovPQ3Qpu40g5idgy+YBrHwRiF0tBOcReMK6auKw=;
	b=LrWjYse+bNJYObZQ6MScAaDcxG+H7CCwGVFVcS2ivXpSaQQlKPqsgpXLMN9uko3FbSSf/A
	MEzx2qSWS5y+w2fdgEiCjRQ5ARUbrCObtyG0AWHuK8DZ/K4A+g79hEuxdlzXTwePRIUkR0
	erybWyMHNZx6jGR2FKOh/rtNnt6pCMc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732178584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PIUovPQ3Qpu40g5idgy+YBrHwRiF0tBOcReMK6auKw=;
	b=tn8zHUQ3lUI7jcdlR54iENkP4h42j6lN5xBp+SMovO0xbWbBNqMNga5p09xRzRhVrBM79T
	pDHzdJi1YbNyw95G2xwNR40uBZcnlPFj5TqZ0wZmLdIjfO8M2pszJ5gQ8fiGeuOg6MCq10
	MQhVgeC5nJgTUyZeC4lnwb22QIGII0s=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3 5/5] batman-adv: Don't keep redundant TT change events
Date: Thu, 21 Nov 2024 09:43:01 +0100
Message-ID: <2485257.jE0xQCEvom@ripper>
In-Reply-To: 
 <71e47271e530851861441f55d102e55a7e5d1fc8.1732124716.git.repk@triplefau.lt>
References: 
 <cover.1732124716.git.repk@triplefau.lt>
 <71e47271e530851861441f55d102e55a7e5d1fc8.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2412775.NG923GbCHz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XZEI3QOAUT57SLGGISDGM3OJT2OUFWUF
X-Message-ID-Hash: XZEI3QOAUT57SLGGISDGM3OJT2OUFWUF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XZEI3QOAUT57SLGGISDGM3OJT2OUFWUF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2412775.NG923GbCHz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>
Date: Thu, 21 Nov 2024 09:43:01 +0100
Message-ID: <2485257.jE0xQCEvom@ripper>
MIME-Version: 1.0

On Wednesday, 20 November 2024 18:47:18 CET Remi Pommarel wrote:
> -               /* this is a second add in the same originator interval. It
> -                * means that flags have been changed: update them!
> +               /* this is a second add or del in the same originator interval.
> +                * It could mean that flags have been changed (e.g. double
> +                * add): update them
>                  */
> -               if (!del_op_requested && !del_op_entry)
> +               if (del_op_requested == del_op_entry) {
>                         entry->change.flags = flags;
> +                       goto discard;
> +               }
>  
>                 continue;

>From logic perspective, the check would be irrelevant - and the continue never happens.


    if (!del_op_requested && del_op_entry)
    	goto del;
    if (del_op_requested && !del_op_entry)
    	goto del;


Implies that del_op_requested == del_op_entry. So the check wouldn't make too 
much sense. Maybe we should clean up this logic further:


diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 437c4edd..b349851b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -484,18 +484,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
-		/* DEL+ADD in the same orig interval have no effect and can be
-		 * removed to avoid silly behaviour on the receiver side. The
-		 * other way around (ADD+DEL) can happen in case of roaming of
-		 * a client still in the NEW state. Roaming of NEW clients is
-		 * now possible due to automatically recognition of "temporary"
-		 * clients
-		 */
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (!del_op_requested && del_op_entry)
-			goto del;
-		if (del_op_requested && !del_op_entry)
-			goto del;
 
 		/* this is a second add or del in the same originator interval.
 		 * It could mean that flags have been changed (e.g. double
@@ -506,8 +495,13 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 			goto discard;
 		}
 
-		continue;
-del:
+		/* DEL+ADD in the same orig interval have no effect and can be
+		 * removed to avoid silly behaviour on the receiver side. The
+		 * other way around (ADD+DEL) can happen in case of roaming of
+		 * a client still in the NEW state. Roaming of NEW clients is
+		 * now possible due to automatically recognition of "temporary"
+		 * clients
+		 */
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 		bat_priv->tt.local_changes--;

Kind regards,
	Sven
--nextPart2412775.NG923GbCHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZz7ylQAKCRBND3cr0xT1
ywk3AQD/fuF98/QwiVq//zB+SJcfKzkkSVlLor7T1YxeJvbw6QD8DZRrkavLjKfI
npDLicYE8SUjt80qPqkHAgoq3M7JBQM=
=9eZX
-----END PGP SIGNATURE-----

--nextPart2412775.NG923GbCHz--



