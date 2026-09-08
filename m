Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05879C79F82
	for <batman-adv@archiver.kernel.org>; Tue,  8 Sep 2026 17:26:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67BAC84B98
	for <batman-adv@archiver.kernel.org>; Tue, 08 Sep 2026 19:26:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788888405;
 b=epfpT+iBT7I6+BILcKs91eKQNAIxKeOpAsReTIo0gE3yokF92z1lV2RzAmcWQGt2gi/Sl
 J63wEOotdhVFIJSuVD6g4XvwCoXcIPsov1XweztkAoBhhRHI0TZwN9dzAxWNvEolIDPCU4I
 uv0tbMZJXpe/H00tkaPgBuP2Yrc6tso=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788888405; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JQ3A98NZ2ECFbKXKOsLzyCKt1+1+2WSG2OWSAYlYPsM=;
 b=R/Sv2S5C/tHFRCRJR5fvlJNwKAyiff01ca+MfGuflAlWwdG0GpnAce1p1rtKoYyWpQsw5
 DUyeQ2ZjxayZ33x5QjKspCrN+saZG2skfzLAJEtVnDqC85OjG81RLer9ytAuSDQfhqGnTyg
 tM2HSBmDly2Wpkfoyr+XoUnhQwGRVQ0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B453F830DD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 08 Sep 2026 19:26:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788888398;
	b=Pems4NNrH+EZcTf41WLcMG0uPYDKgaK90DUJieccv+k5ralwYJxPBX/uCT4pVi7PrO72Pt
	kVOms24W5hK9TFBChBIo6/0pGXD7RTO+cuFk5tkaHdSTYhLNTT1JhVBOjazBeyH06TQlce
	ZXCQjcPcLdcStsUXd8EkkQWdAmoIppg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788888398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JQ3A98NZ2ECFbKXKOsLzyCKt1+1+2WSG2OWSAYlYPsM=;
	b=g2hv+RVwSaPldSc/D4foV4mkjcxH+EIeMWqYLKnI4ZHf7itGiSRIzY3W2ZY2DPYSqsZRQm
	/rxliD9dkvmO3iz1RbROnIo1Hpk8rSi5NEs8jrakOZ5CY20j2SGeGkh8BX7aBfoPnZwgIf
	SWVY1piAu2X0oKEuZp8OrRDNzR4QktA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=I6UOd57m;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EEBC91FE4D;
	Tue, 08 Sep 2026 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQ3A98NZ2ECFbKXKOsLzyCKt1+1+2WSG2OWSAYlYPsM=;
	b=I6UOd57mdRUQ4rJ9KDGFDA/AGB2puwV9x1z2f00x5yWsebJbapMcToKfMEzQqA++uINhpm
	M5kPcwwBjNSeA2KWJb6D2crIdJi0wEfKtwM3hIHUbG4AO8rBLdn4oqY5MXamOYI+YgVhXf
	n7ZbsOmCsLOKwRN6j/GKUKNxSRdY/vk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 09/15] batman-adv: tt: extract removal of the
 superseded
 local entry
Date: Tue, 08 Sep 2026 19:26:34 +0200
Message-ID: <10917869.nUPlyArG6x@sven-desktop>
In-Reply-To: <20260907081824.2474040-10-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
 <20260907081824.2474040-10-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2370024.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XPEK6PQDJXMOVLDII7EXTJ3APWIN6YB4
X-Message-ID-Hash: XPEK6PQDJXMOVLDII7EXTJ3APWIN6YB4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XPEK6PQDJXMOVLDII7EXTJ3APWIN6YB4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2370024.iZASKD2KPV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Sep 2026 19:26:34 +0200
Message-ID: <10917869.nUPlyArG6x@sven-desktop>
In-Reply-To: <20260907081824.2474040-10-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-=
1-sw%40simonwunderlich.de?part=3D9

[...]
> > +/**
> > + * batadv_tt_global_purge_local() - drop the local entry of an announc=
ed client
> > + * @bat_priv: the bat priv with all the mesh interface information
> > + * @tt_global_entry: the global TT entry of the announced client
> > + * @flags: TT flags announced for this non-mesh client
> > + *
> > + * A client which is announced by another originator is no longer a lo=
cal
> > + * client. Remove it from the local table and take over the WIFI flag =
it was
> > + * tracked with.
> > + */
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
> This isn't a bug, but should the new kernel-doc for
> batadv_tt_global_purge_local() mention the two things the body actually
> does beyond the summary?
>=20
> The doc says removal from the local table happens, but multicast addresses
> take an early return and nothing is removed:
>=20
> 	if (is_multicast_ether_addr(common->addr))
> 		return;
>=20
> The doc also does not mention that the global entry's own flags are
> modified, not just the inherited WIFI flag:
>=20
> 		if (!(flags & BATADV_TT_CLIENT_ROAM))
> 			common->flags &=3D ~BATADV_TT_CLIENT_ROAM;
>=20
> Since flags_lock is documented in struct batadv_tt_common_entry as
> protecting both @flags and @batadv_tt_global_entry.roam_at, a reader of t=
he
> new standalone helper might not expect the name purge_local() to also res=
et
> the global roaming state.
>=20
> Both behaviours are unchanged from the previous inline code under the
> out_remove label in batadv_tt_global_add(), so this is only about the
> description of the new helper.


See https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260908-sas=
hiko-kdoc-v1-1-535b498f2519@narfation.org/

Regards,
	Sven
--nextPart2370024.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqBFSgAKCRBND3cr0xT1
y13LAQD3VEVHjsI9tXKh0taDphyxGC7UrRqY/ulxeBr95Uek+wEA9UdRnWCKsCsQ
N0Zjd2X9YldVmQvuB6/1yNn/k2gQjQM=
=MCep
-----END PGP SIGNATURE-----

--nextPart2370024.iZASKD2KPV--



