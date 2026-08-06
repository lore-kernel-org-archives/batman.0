Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE0BC56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 16:13:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E12118427B
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 18:13:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786032818;
 b=ZnLRhrVk7qTmobv4aWKdhw5fsWhLZ9/JqVYCIOjfe0crYWirQDxMU1LaDXUaTRVBJyMwq
 5zywsrooHMjw8U2E4p3d8vpDrX8OXCDsx88J0I7AwUU3mxaIs5ZjWGzqBgSrMhvspuTBH1B
 4bPk+SYhWVnH4P6IZlHiCCop2DkdIts=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786032818; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FDnJjr6u5CI2FNAIvthxuWqMU0c59QUxaGduLMRi80k=;
 b=hPlLzf/Wj/Cb1rT0hJoSxvVxgC9ZUCv7GJzHV3Gf+xp67crtA4hE0TJJ3EL/iSwuvAp0i
 kcvJ0DtMASDigV2pSgb1eomo8di15b3HXBqp3k0PrvGU2hETlKonihj+cKrIzYahWcXOInd
 1WKr63bFbVGdQbNPXntBmi4v8rgekUg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3AC8080E31
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 18:13:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786032802;
	b=UD6sttvjrismSpb0vDrzoMAtLydpyo4m2KoNaiATY8RKt9T7Ld6x0oUIkp6TEu7FoufMHu
	PE89YbgNOD4qrf9BI36byvQ077Gn0Mm3xTgXd1AnhedBK8S5n/5a4Q4zxLT0jMQOi0lhqj
	jVLvLyrDmJMePtyJjIGbrmmnj+nUGtM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786032802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FDnJjr6u5CI2FNAIvthxuWqMU0c59QUxaGduLMRi80k=;
	b=myR8J2UZqxTRhCV+32pIaIWyQ4o/mzpltZN+yBQeP64I3fpZoUvNl7Nd1rLAl3Ta1hpxjL
	Zm5LIAO5XH4Lii/5MFBX5dIvjq+qGmGGP954gwb7s7fRzHok01sfO5+fOnUPtregYhPTrX
	hkfd+lMRhjOsFphBPs7Qb3gt5dQ59Kk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=M4PABhAw;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5BA3E21002;
	Thu, 06 Aug 2026 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786032797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FDnJjr6u5CI2FNAIvthxuWqMU0c59QUxaGduLMRi80k=;
	b=M4PABhAwzeME3pAJ//y1LUuDSUdp8sDpbtiOoQoMiu+BsfFAqKKRw/EVx2sFGUS3D/zJUT
	1Hgon80Q76fVkSS6owsAw+COavPvA8VI8YUWmxXmsF6xTKFG+CDZ4Bde7nAd79utOl6ANm
	C/JDDLiKus3P3iZ+CeidHY71gaQxTaU=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 05/10] batman-adv: annotate functions which may
 reallocate the skbuff
Date: Thu, 06 Aug 2026 18:13:14 +0200
Message-ID: <5280888.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260805143200.722098-6-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-6-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4913403.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XL7NQBBIYS3PHJJYL4YS4O3ONMQ76WR2
X-Message-ID-Hash: XL7NQBBIYS3PHJJYL4YS4O3ONMQ76WR2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XL7NQBBIYS3PHJJYL4YS4O3ONMQ76WR2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4913403.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 18:13:14 +0200
Message-ID: <5280888.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260805143200.722098-6-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D5

> --- Patch [5]: [PATCH net-next 05/10] batman-adv: annotate functions whic=
h may reallocate the skbuff ---
[...]
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug, but the ellipsis in the batadv_dat_snoop_outgoing_arp_r=
equest()
> annotation has an extra dot ("batadv_dat_get_vid()/....") compared to the
> "/..." spelling used in the other hunks of this patch.

=46eel free to use the extra dot for whatever you want. Will not resend the=
 PR=20
or create a patch because of this.

>=20
> > + * from skb->data or eth_hdr()) before this call must be considered
> > + * invalid afterwards and has to be reacquired.
> > + *
> >   * Return: true if the message has been sent to the dht candidates, fa=
lse
> >   * otherwise. In case of a positive return value the message has to be=
 enqueued
> >   * to permit the fallback.
> > @@ -1271,6 +1286,11 @@ bool batadv_dat_snoop_outgoing_arp_request(struc=
t batadv_priv *bat_priv,
> >   * @skb: packet to check
> >   * @hdr_size: size of the encapsulation header
> >   *
> > + * Warning: This function may reallocate the skb data buffer via
> > + * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtain=
ed
> > + * from skb->data or eth_hdr()) before this call must be considered
> > + * invalid afterwards and has to be reacquired.
> > + *
> >   * Return: true if the request has been answered, false otherwise.
> >   */
> >  bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_pri=
v,
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is the advice to reacquire the pointers correct for the true return path =
of
> batadv_dat_snoop_incoming_arp_request()?  On that path the skb is not just
> reallocated, it is released:
>=20
> net/batman-adv/distributed-arp-table.c:batadv_dat_snoop_incoming_arp_requ=
est() {
> 	...
> out:
> 	batadv_dat_entry_put(dat_entry);
> 	if (ret)
> 		kfree_skb(skb);
> 	return ret;
> }

This is outside the scope of this patch. The WARNING is of course only vali=
d=20
when there is still an skb to use.

> [ ... ]
>=20
> > @@ -1788,6 +1818,11 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct b=
atadv_priv *bat_priv,
> >   * This function first checks whether the given skb is a valid DHCPACK=
=2E If
> >   * so then its source MAC and IP as well as its DHCP Client Hardware A=
ddress
> >   * field and DHCP Your IP Address field are added to the local DAT cac=
he.
> > + *
> > + * Warning: This function may reallocate the skb data buffer via
> > + * pskb_may_pull()/batadv_dat_get_vid()/... Any pointer into the skb d=
ata
> > + * (e.g.obtained from skb->data or eth_hdr()) before this call must be
>        ^^^^^^^^^^
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Missing space after "e.g." in the batadv_dat_snoop_incoming_dhcp_ack()
> annotation.

Will not resend the PR because of this.

> [ ... ]
>=20
> > diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast=
_forw.c
> > index 1404a3b7adfb1..60ec12805742c 100644
> > --- a/net/batman-adv/multicast_forw.c
> > +++ b/net/batman-adv/multicast_forw.c
> > @@ -1080,6 +1080,11 @@ unsigned int batadv_mcast_forw_packet_hdrlen(uns=
igned int num_dests)
> >   * Tries to expand an skb's headroom so that its head to tail is 1298
> >   * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
> >   *
> > + * Warning: This function may reallocate the skb data buffer via
> > + * skb_cow()/skb_linearize()/... Any pointer into the skb data (e.g.
> > + * obtained from skb->data or eth_hdr()) before this call must be
> > + * considered invalid afterwards and has to be reacquired.
> > + *
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Are skb_cow() and skb_linearize() the right helpers to name here?
> batadv_mcast_forw_expand_head() calls neither of them; the only
> reallocating primitive in its body is pskb_expand_head():
>=20
> net/batman-adv/multicast_forw.c:batadv_mcast_forw_expand_head() {
> 	...
> 	if (skb_headroom(skb) < hdr_size &&
> 	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
> 		return -ENOMEM;
>=20
> 	return 0;
> }

The relevant changes were lost when the fixes were removed from the PR. Wil=
l=20
not resend the PR without this line. The statement will be true when the fi=
xes=20
are added.

Regards,
	Sven
--nextPart4913403.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSymgAKCRBND3cr0xT1
y5M4AQDtiv3xZfVq1t+gGMqETnnfR6iXthq5uJa6Vyuc4LVhvwEA6sCgsuW12hU/
ssXA+bh+FDQterPz9a3EhE/ADtaFQgk=
=H7jn
-----END PGP SIGNATURE-----

--nextPart4913403.LvFx2qVVIh--



