Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EB1C79F82
	for <batman-adv@archiver.kernel.org>; Tue,  8 Sep 2026 17:27:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CDFF083169
	for <batman-adv@archiver.kernel.org>; Tue, 08 Sep 2026 19:27:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788888472;
 b=yjpMByh5cMqH5YkYA/GSSFq1VlmSsyA/PHdkpy1NzvTDikrX+03H435j4tvbLynuKy7Px
 0sFWVj+koVnisVOJqau/tTWhatYMUnHJQ9UMo4SBZtxiWeLQX9IiyMqaxV0IVWK3ZldRqkF
 T8RnV4I1O1A0RooT9nRA4J958tigDDM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788888472; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O1WEMwLwpC0O2fnWxbqM0WCToy+BcA1jN5S4hrQvxk0=;
 b=Jaum9/E7g0x4LCqZlALqcitr2Hx63XKGZFwdPS4YfqXTRLtHqowGkfvwRudxRLueZEI9i
 inifoBelMUEtCtMCf1Oiwb7z8O8l1aMCtAAYhAhjNg6dF5tL7NvwQEJj1ddkl9ufEeIK4W5
 pHFXRupt8z228mvy6c95Zkw3FXsEwao=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AB973846EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 08 Sep 2026 19:26:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788888404;
	b=Obra/jO4/nHWd287nlWx2HdK//zLKpOR4YNVWetF+/h+Ax/Gg+UhH+W+hPkDiJnA1+/eHz
	cogptz63mbFX1BqimtrRB4m7CJjM+PYS9shk/rXHsXvY4ChGKLqhk7sHwW97WT/x4TxPIR
	lfSZP10i7MAaEtTx3ked3nvf/f4fdT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788888404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=O1WEMwLwpC0O2fnWxbqM0WCToy+BcA1jN5S4hrQvxk0=;
	b=Li64s6SZiIVrNQXKyZ+/o7VOgs8iDW85NuEiUj3XiKO+1aQyxeNw+8hE/Fv4WPSbs9/Jm/
	CrW3mkrL1HlOfZ9ukoW7zZ7o6kArnOQe9/OsEBfcpLNSj1zwUT3IFykhx/0d/0j3eCSI44
	Tc9Xa7WRcW5/h2VXiLWwWLGFOqBjIO0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NbJXeKrJ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 28B971FE4D;
	Tue, 08 Sep 2026 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1WEMwLwpC0O2fnWxbqM0WCToy+BcA1jN5S4hrQvxk0=;
	b=NbJXeKrJOsBsi/Oe48DKBkbH+cN+af/Q9dDEzNIokHwcdNtQJwncgXw8zWONbiwnhCTTwz
	G7rRLL/npG/cj3D7Sxo2/5Yi03LIF0S/cl+AxraBNRbjH/BX0HAvLjR0RAsg+yY3FoqxAu
	jenlP1zaCOC32IyJ+RoPIg20OMUaOgU=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 11/15] batman-adv: tt: extract immediate purge of
 a local
 entry
Date: Tue, 08 Sep 2026 19:26:41 +0200
Message-ID: <7996121.EvYhyI6sBW@sven-desktop>
In-Reply-To: <20260907081824.2474040-12-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
 <20260907081824.2474040-12-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3976506.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: WLM766ISH5RWJUJEZX56EZCUXWVUKTKC
X-Message-ID-Hash: WLM766ISH5RWJUJEZX56EZCUXWVUKTKC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WLM766ISH5RWJUJEZX56EZCUXWVUKTKC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3976506.kQq0lBPeGt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Sep 2026 19:26:41 +0200
Message-ID: <7996121.EvYhyI6sBW@sven-desktop>
In-Reply-To: <20260907081824.2474040-12-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-=
1-sw%40simonwunderlich.de?part=3D11


[...]
> Discovered by: opus-5 =C2=B7 Missed by: opus-4-7, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
> Is the "was never announced" wording in this new kernel doc a bit too
> strong?  The body of the same function documents the opposite case a few
> lines later:
>=20
> net/batman-adv/translation-table.c:batadv_tt_local_remove_now() {
> 	/* batadv_tt_local_transition_new() may have committed the entry and
> 	 * thus counted it in the local table size since the
> 	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
> 	 */
> 	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
> 		batadv_tt_local_size_dec(bat_priv, common->vid);
> }
>=20
> batadv_tt_local_mark_removed() drops common->flags_lock before returning
> and batadv_tt_local_remove() holds no other lock, while
> batadv_tt_local_transition_new() only holds the local list_lock and
> flags_lock:
>=20
> batadv_tt_local_commit_changes_nolock()
>   batadv_tt_local_transition_new()   /* clears BATADV_TT_CLIENT_NEW,
>                                         batadv_tt_local_size_inc() */
>   batadv_tt_local_update_crc()
>   atomic_inc(&bat_priv->tt.vn)
>=20
> So in that window the entry can be committed, counted and announced under
> the current ttvn, and batadv_tt_local_remove_now() still unlinks it from
> bat_priv->tt.local_hash instead of leaving it BATADV_TT_CLIENT_PENDING
> until the next ttvn increment, as described by
> batadv_tt_local_set_pending_event():
>=20
>  * Schedule the TT change announcement for the entry. The entry is kept i=
n the
>  * local table until the next TTVN increment so that a consistency-check
>  * response can still be answered.
>=20
> Would it make sense either to soften the new kernel doc (and the matching
> sentence in the commit message, "A client which was added after the last
> ttvn increment was never announced and can be dropped from the local table
> right away") to mention that the entry may already have been committed, or
> to fall back to the pending path when the NEW flag turns out to be cleare=
d?

See https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260908-sas=
hiko-kdoc-v1-3-535b498f2519@narfation.org/

Regards,
	Sven

--nextPart3976506.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqBFUQAKCRBND3cr0xT1
y5seAQCZYvOU4AIYF3w0R7bW952r3l9YtRIYnYMADqpfKWJebwEA+pTpEAWEZDxH
KuKzsnlu2gddfoimFMEPOXVk8k9rkQ0=
=3jo+
-----END PGP SIGNATURE-----

--nextPart3976506.kQq0lBPeGt--



