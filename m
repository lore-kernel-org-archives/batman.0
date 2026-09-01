Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B8EC624D0
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 19:33:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 47F7982267
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 21:33:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788291232;
 b=mtHfrYjK4vGNbWAeJCcz4/3euACqZsWE7+QaoqwvJWk3+eZaSQVhA9saRPL8KVKRMWa4x
 3dali3+7HjA4sYlxpk77yjRX09pDQ6sH+y/3/h003Qk+Hq0Dji1NplZkekSJJOyaa4Pjyj/
 h+tp0MBouNhyLkswj6eWGNoammJmFos=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788291232; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cQm3GImKZjX3NSlbzygy8Q61DyRZs0TqW6vyMiHfK74=;
 b=gb7r/8ZflJ6gnA7l5gLJ9huQ5J9tuhR6bAvj/JiIT+pP35XME+dLJwDyO9CpQ5OuuaEwW
 66hqoXwVP8hR/QuBW8RI9Pubv501GbJ5ZNUN6E6chT2KvdUk/5EbrxOsgWjR85iTsCH0tfR
 o+Vonge9+0opVNIZyd4gzAzuowD+5Ps=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1A216811CE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 21:33:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788291225;
	b=sxd0t6yMwS/9UzKCtHWUp4SPjRAviNxiIz4BQx7azlxyokDZzLK8RzSO6xqaytwgegnC2a
	3FnAUo/wLNKP8J0S9nq6QVLhGihR7hmPL0PlaQdkCvSCP5dsPtmAul9tFjL/RfFWVBKQ2H
	AiejxanA0oK2c/tvlknxpJjNejvUa6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788291225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cQm3GImKZjX3NSlbzygy8Q61DyRZs0TqW6vyMiHfK74=;
	b=YaN7V9b3f+PiGVQ3o1BnUEhwbZFqbgnzUIZPWhqOYD48mHmPkUoHFLnw4b099VStlb6kOz
	DF3rCQcRNGt6UpSgypM1VfEJ4e1I6jYOr3txkzAtH8zsIyFyFslHEl3dH59mT58YyF9bEM
	FacXzWrZC2P1318BWKgYdrveaTFD7jg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="UB/u0WwE";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5B6AB20396;
	Tue, 01 Sep 2026 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788291220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQm3GImKZjX3NSlbzygy8Q61DyRZs0TqW6vyMiHfK74=;
	b=UB/u0WwEJNYzPQF/vN7M6e7/ACp9jJ/kgo6HzG34MQTo0JYGiDgXXB0goFk/P5l8KGotMD
	lqgCQH1Dr1kzSWYCT5ufORDEQ2Ku6XJDUl8hhTaQOp8z1Krjp1pouYgnEKTWoIXCdeGze7
	ulMGMs7P/fEnfv58EOx3YI9/WaheVg4=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 14/15] batman-adv: tt: don't uncount never
 committed
 clients on pending purge
Date: Tue, 01 Sep 2026 21:33:37 +0200
Message-ID: <2089489.usQuhbGJ8B@sven-desktop>
In-Reply-To: <20260831135117.574836-15-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-15-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3649466.QJadu78ljV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XCBQEHEXH2IOTRLHIM4OTDE2UPOG2SXB
X-Message-ID-Hash: XCBQEHEXH2IOTRLHIM4OTDE2UPOG2SXB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XCBQEHEXH2IOTRLHIM4OTDE2UPOG2SXB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3649466.QJadu78ljV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 21:33:37 +0200
Message-ID: <2089489.usQuhbGJ8B@sven-desktop>
In-Reply-To: <20260831135117.574836-15-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D14

> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index a870d9a97e32..794692170b61 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
>=20
> [ ... ]
>=20
> > @@ -4019,8 +4023,13 @@ static void batadv_tt_local_purge_pending_client=
s(struct batadv_priv *bat_priv)
> >  					   tt_common->addr,
> >  					   batadv_print_vid(tt_common->vid));
> > =20
> > -				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
> >  				hlist_del_rcu(&tt_common->hash_entry);
> > +
> > +				/* An entry which still carries BATADV_TT_CLIENT_NEW was
> > +				 * never counted and must not be uncounted here.
> > +				 */
> > +				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
> > +					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
> >  			}
>=20
> Discovered by: gpt-5-6-sol, opus-5, sonnet-5 =C2=B7 Missed by: sashiko-ge=
mini
> Should this carry a Fixes: tag and a Cc: stable hint?


I am not allowed to add Fixes: lines for patches targeting net-next. And th=
is=20
is not suitable for net or stable backports. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/

Regards,
	Sven
--nextPart3649466.QJadu78ljV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcokQAKCRBND3cr0xT1
y/SSAQCtPbvVaDKm5YLFTiYOdgIqrp0Q8igeg9XRglo6tDX5QQD/fV0CDLZDhbFY
dDdEnLN2635iTdFhWIxTKfnvanR0RgI=
=lnez
-----END PGP SIGNATURE-----

--nextPart3649466.QJadu78ljV--



