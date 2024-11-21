Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A03D63959
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 09:30:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9273A8301D
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 10:30:54 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732181454;
 b=GDWZd1FGWB3rmX18B+Ap2pcs1h0O4TAmPt571y6rU6AyBZJlFxSdS+A9tEcPuwFPAPg9m
 JqYsFzX/tV1utMRkYXvpHessNXNma2lQgiRTEX3xJkHyYg8IdQSQYbtDXeLPqmPEHnxn+Jc
 vCCblz/n5+fm422HQUlNko4hN3JAw90=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732181454; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=btz+99iTTyfRqpec0bGGE97I9TEpiaroUA2sLqc0kl4=;
 b=P/aoUb/zjVocrvqpDcyVbgXxSNr9HOJDCvGG2heuGawreuNHzYdWPpYU1IBedxDEfEh5B
 YWnKKXf+SEylXwrCf0aCQhv6z2HE4a7g83ANJBENMc2HD7vebpstucAvIaTc8g7K4IA8yV2
 MhIsixCmKH+2X2UrLzkaXC0RJMLRBMM=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 566388158D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 10:30:41 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732181441; a=rsa-sha256;
	cv=none;
	b=oeechGzuIBDeAIq0opMdPJdit7a9nO9mE9fI3U5nuQ1tqXNymVGBWpxLkkrglVbozvDcsY
	5yHXTtFYFPb/uA4qKQMVVF24WWJg69g81CAmND86OFfJLIZkD7WN9rL+Vzl7AxhH/7diKY
	urxV4aEQDogkbI8+P697r+bqDCLXJI8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EwQCDptF;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732181441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=btz+99iTTyfRqpec0bGGE97I9TEpiaroUA2sLqc0kl4=;
	b=e0i9EwULb8ghpzIKwzHNLd+OXQCmkgQnRQdkvlNmOnR/s9f7TAcUg1ICzn0wRKnosPhpxN
	Sh0pue1HSXjCaOU53FXZ0UJ/1TCeuJPFbyZ2DibIzNdYp/CdFicZ3OSnCwaqQQ20pTHN28
	nFM2Uc/BVSiVNVUmfZmfZ05leoUEOLo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732181440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btz+99iTTyfRqpec0bGGE97I9TEpiaroUA2sLqc0kl4=;
	b=EwQCDptFpBKsjhqH6pXY5iV+Eyxf5ccWo+ifaiz6FqfzD6Sdv/Ek7i2HWH7JzlhE5Kifqp
	B+6heql+CfstOXSzG9/84SsxkvOyAti/rttfj9nYQDGXYE/x7Rv408Ldas5dO6xGb14CoQ
	nUJOe9zFZgSSmzhQ4kD6MmO9dmeBo2Q=
From: Sven Eckelmann <sven@narfation.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Subject: Re: [PATCH v3 5/5] batman-adv: Don't keep redundant TT change events
Date: Thu, 21 Nov 2024 10:30:37 +0100
Message-ID: <1834684.3VsfAaAtOV@ripper>
In-Reply-To: <13642846.dW097sEU6C@ripper>
References: 
 <cover.1732124716.git.repk@triplefau.lt> <Zz75q77puwRSl5hN@pilgrim>
 <13642846.dW097sEU6C@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3290497.AJdgDx1Vlc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: QILABBNSFDM7GA6P7NSVFUYQWXQ45Y5U
X-Message-ID-Hash: QILABBNSFDM7GA6P7NSVFUYQWXQ45Y5U
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QILABBNSFDM7GA6P7NSVFUYQWXQ45Y5U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3290497.AJdgDx1Vlc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Remi Pommarel <repk@triplefau.lt>
Date: Thu, 21 Nov 2024 10:30:37 +0100
Message-ID: <1834684.3VsfAaAtOV@ripper>
In-Reply-To: <13642846.dW097sEU6C@ripper>
MIME-Version: 1.0

On Thursday, 21 November 2024 10:23:33 CET Sven Eckelmann wrote:
> On Thursday, 21 November 2024 10:13:15 CET Remi Pommarel wrote:
> > Looks right to me, I would even simplify that more for readability with:
> [...]
> > -del:
> > -               list_del(&entry->list);
> > -               kmem_cache_free(batadv_tt_change_cache, entry);
> > -               bat_priv->tt.local_changes--;
> >  discard:
> >                 kmem_cache_free(batadv_tt_change_cache, tt_change_node);
> >                 goto unlock;
> > 
> 
> The "discard" is unused. But the rest looks good.

No, it doesn't. You've accidental removed "entry->change.flags = flags;". So 
it should look more like this:

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -484,34 +484,25 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
-		/* DEL+ADD in the same orig interval have no effect and can be
-		 * removed to avoid silly behaviour on the receiver side. The
-		 * other way around (ADD+DEL) can happen in case of roaming of
-		 * a client still in the NEW state. Roaming of NEW clients is
-		 * now possible due to automatically recognition of "temporary"
-		 * clients
-		 */
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (!del_op_requested && del_op_entry)
-			goto del;
-		if (del_op_requested && !del_op_entry)
-			goto del;
-
-		/* this is a second add or del in the same originator interval.
-		 * It could mean that flags have been changed (e.g. double
-		 * add): update them
-		 */
-		if (del_op_requested == del_op_entry) {
+		if (del_op_requested != del_op_entry) {
+			/* DEL+ADD in the same orig interval have no effect and
+			 * can be removed to avoid silly behaviour on the
+			 * receiver side. The  other way around (ADD+DEL) can
+			 * happen in case of roaming of  a client still in the
+			 * NEW state. Roaming of NEW clients is now possible due
+			 * to automatically recognition of "temporary" clients
+			 */
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+			bat_priv->tt.local_changes--;
+		} else {
+			/* this is a second add or del in the same originator
+			 * interval. It could mean that flags have been changed
+			 * (e.g. double add): update them
+			 */
 			entry->change.flags = flags;
-			goto discard;
 		}
 
-		continue;
-del:
-		list_del(&entry->list);
-		kmem_cache_free(batadv_tt_change_cache, entry);
-		bat_priv->tt.local_changes--;
-discard:
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto unlock;
 	}

Kind regards,
	Sven
--nextPart3290497.AJdgDx1Vlc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZz79vQAKCRBND3cr0xT1
y3wOAQC03zEJ9TxB/MxaFk6gZrQ+byTr0yUQ7A2mBwuNS4R6EAD/bkiZlEpX1536
DzWkkFbsJsG653zNApVOVFcXWtTbAgY=
=4nEp
-----END PGP SIGNATURE-----

--nextPart3290497.AJdgDx1Vlc--



