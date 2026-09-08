Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF1FC79F82
	for <batman-adv@archiver.kernel.org>; Tue,  8 Sep 2026 17:27:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4E7D283C4D
	for <batman-adv@archiver.kernel.org>; Tue, 08 Sep 2026 19:27:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788888442;
 b=cK+8C+6L1oL8PpmC0UqvS6P8xN854xW5dkFiZBNFwFHre4odBr2pfc7ypUGF2+jaNdm5M
 OqtvuVd7RQkmQtAphFmr1oeeDcP7eDrfXKfzgOWJ8bNpRRyjRDuAGbkP9Bw+YW+A58Od5Rt
 uTT+Ei7xoRHgychlsJF9rdgaRr0gOpM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788888442; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FHeMM3cah6we71csw5zVw2WNdPXB/wb60Sk/ZQak/zY=;
 b=wM7l1ISlPZWv63K9L4SQ01Uzj5FvR2klNLllWpCyz1UpJbtz1x2m93KbnxvVcjE9hVQea
 XN4g0ykE3w7yA2AUN6Z/eUb3k4Ff8iCfJY031TIkFYl7yJxxvwtGrvDLlCu7WIO2/uCojrE
 ZrWDvKep41+Ro4ebOP2qreNkREgJqgY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DB89B83D4C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 08 Sep 2026 19:26:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788888401;
	b=miYjMuCRfX8WFkOAY6AX6PA9dHvnCGN5rdGjgFFxgDxLkwjtDLnH6+gh65VPSpoLBOKYVE
	wi1dkliOhO3caI4xW5f34G1mAOub9xe+Jjwu3Xo2eLGxHGI73Zlg53KGygDkNC2kJDaW+t
	7vU5hh66LHcTCcDbIvy6XksfrMzWutI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788888401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FHeMM3cah6we71csw5zVw2WNdPXB/wb60Sk/ZQak/zY=;
	b=slT/SBjWed5lcTen6ntxCLbPoj6qqQ8HZS8Ju+RtHVwgPUOkIY+OrxdEN6SSPlTr6eMgh+
	mFQ1EfRNei3txZKKH4uM45Szj5957uEHyJ836vqN+IOXRev6NqMY+VD6MOv3q0hXc1OqNx
	AdCs2SlwNgMkMDrwXLa9X1zz8gLZGfc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hrjHL3Bs;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 63EFF203C8;
	Tue, 08 Sep 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHeMM3cah6we71csw5zVw2WNdPXB/wb60Sk/ZQak/zY=;
	b=hrjHL3BsFo9ZOXfxOa8aH6bBY4Fz2Jq99PJRhQtA/DCwSwI202J/RGUtFuU3rtreE36ApR
	fmWiMgBGtWW2I9fH0agOizZ+cdp/ciMzlBfqm5uXnLvUYldMn/OG29RmZ3Xon+uyPF8WY5
	5iEV9o0BuyAEUJ3S9mwdxw8FV9mRJuk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 10/15] batman-adv: tt: extract marking of a
 removed local
 entry
Date: Tue, 08 Sep 2026 19:26:38 +0200
Message-ID: <2056796.PYKUYFuaPT@sven-desktop>
In-Reply-To: <20260907081824.2474040-11-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
 <20260907081824.2474040-11-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23242329.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: D3ISS36MH63QKD2V57RN2KTZAZVQO7JQ
X-Message-ID-Hash: D3ISS36MH63QKD2V57RN2KTZAZVQO7JQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D3ISS36MH63QKD2V57RN2KTZAZVQO7JQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart23242329.EfDdHjke4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Sep 2026 19:26:38 +0200
Message-ID: <2056796.PYKUYFuaPT@sven-desktop>
In-Reply-To: <20260907081824.2474040-11-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-=
1-sw%40simonwunderlich.de?part=3D10

[...]
> Discovered by: opus-5, old-prompts =C2=B7 Missed by: gpt-5-6-sol, sashiko=
=2Dgemini
>=20
> Two comments in batadv_tt_local_remove() look like they no longer match t=
he
> code after the move.
>=20
> First, the untouched comment further down in batadv_tt_local_remove() sti=
ll
> refers to a check "above":
>=20
> net/batman-adv/translation-table.c:batadv_tt_local_remove() {
> 	...
> 	/* batadv_tt_local_transition_new() may have committed the entry and
> 	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
> 	 * check above.
> 	 */
> 	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NE=
W))
> 		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
> 	...
> }
>=20
> After this patch there is no BATADV_TT_CLIENT_NEW test left anywhere above
> that point in this function; the only one is now inside the new helper:
>
> net/batman-adv/translation-table.c:batadv_tt_local_mark_removed() {
> 	...
> 		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
> 			common->flags |=3D BATADV_TT_CLIENT_PENDING;
> 			pending =3D true;
> 		}
> 	...
> }
>=20
> Should the wording be updated in this patch to name the helper, so the
> size-accounting race stays traceable from the function it is documented i=
n?

See patch 11 "batman-adv: tt: extract immediate purge of a local entry"


> Second, the retained comment above the "if (roaming)" line still says the
> node "has to mark the local entry as roamed", but the code it now precedes
> only assembles the announcement flag word; the actual
> common->flags |=3D BATADV_TT_CLIENT_ROAM happens in the
> batadv_tt_local_mark_removed() call two lines below.  Would it read better
> moved or reworded so it describes the flag assembly?
>=20
> No functional change is apparent here: flags is fully computed before the
> call, *curr_flags is written unconditionally inside the guard so curr_fla=
gs
> is always initialized for the caller, and the helper is only reached after
> the !tt_local_entry early goto.

See https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260908-sas=
hiko-kdoc-v1-2-535b498f2519@narfation.org/


Regards,
	Sven
--nextPart23242329.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqBFTgAKCRBND3cr0xT1
y9eVAQCrSHMq+uPJN+ZPUSxx99ek6ob/8ZDfr6sFi5RrPM/zYwD/SxEeTKNzH0Eu
zfG8hknPR/Ai9zHlEzWGPvUmEoEuEwg=
=kyIT
-----END PGP SIGNATURE-----

--nextPart23242329.EfDdHjke4D--



