Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B9C04A94
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 15:36:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 38CD6831E6
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 17:36:04 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692027364;
 b=KUJP0WlMiDRJpzXMK3X3Gvk9wks35qc5vmzqznGyty4/7jJnNvNQFt9UCGVbIY/V0kGv2
 O10lSpjHnChUXC7FB5LZIHG3lai3z1czlLIKylbHfo3fDdNC8p4NH7jw4okNI5Ey8tnZ/Ah
 AFN63pDrxqPuMOuifsGiGeV8P+Fu6Kk=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692027364; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VIjiIzgG3WiiXb9G4SOlo4E1rnBGZsco3n5UAQ/5c/w=;
 b=nCodO+L4fE7wh1zMw/Jlg20YwiEMkXA5canROcgEaqxzDMQgxatIgGh7GqhU6LA0Kf1Vd
 Wto8Au9TYaRJRUtDJ59rXReDk5L9VX9J0sT3zOkHUQ8dRzH3EHkaRwBlLAznvPmLErs+NZj
 BnLd8mNB5KJ6uCxOUBozxkd0VRMELP0=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CE451805A8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Aug 2023 17:35:29 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692027329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VIjiIzgG3WiiXb9G4SOlo4E1rnBGZsco3n5UAQ/5c/w=;
	b=lQ9iyEpMZJ/QN6y99jert2NgEE4YzHKovp08WKMXs78jPID7p90sWJLwHE5Js/iG8UrzoU
	FxRnl7GVuG3sOPx8LqLKabzxytSFkBgDtGiPWe7ivIwaKa+rY1wMyb0a9Z3eIBcg7UWqtz
	cI+yZHZGM1xrlCjYSSfWJQHnQf70Hp0=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=oeuJyHJK;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692027329; a=rsa-sha256;
	cv=pass;
	b=grLO4BQxgkdm3NAV83scYHm+U8aRupmQcb+z30c+YKNezds4l2iWrBUbhnpMiMAW1Rwblt
	D6jehzYLHmCgaKVEc5YP7pRZuIer8mi1qefn/ZmaT+kdCubwOoYBXeR/L60wqSGYMUwfhN
	T60PRp8SVZFl0JiVaw21t5ovsRI7TEs=
Received: from prime.localnet
 (p200300C5970E8AD8a82608f38c359CBD.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:8ad8:a826:8f3:8c35:9cbd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 45372FB5B0;
	Mon, 14 Aug 2023 17:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692027329;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIjiIzgG3WiiXb9G4SOlo4E1rnBGZsco3n5UAQ/5c/w=;
	b=oeuJyHJKvoMBUsdl60DLPredH3BtBhgiuArDed/LYl3zV2PLYtT5c+tx0W3iVS40NGD31X
	gM6ZGiAOOqHcd43m8A1m34qbC1FPbj3+TYcbPiXmPlos10DZbZyAoirSE0P57JH+Ihlr18
	KwcRnLklN2tutxfWplv+0VCO/+dp7s7qSXt7L5zMfRPqF3dMXJ7YmKX9H4cKmigRbJ1VuY
	+An0ppnU7No6nIcp6RzE6c0/rcNGqrJyzqag3qc5qFk9h9XxNmbLL2lBsgIhefZOb7KcqM
	55LRIKuDiLUvThvrzAeOAS0blz8lBj0oGWn9X0MqTy7JnxruJlsgFEVGFCfb/w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 1/3] batman-adv: mcast: implement multicast packet reception
 and forwarding
Date: Mon, 14 Aug 2023 17:35:28 +0200
Message-ID: <2296108.bB369e8A3T@prime>
In-Reply-To: <20230720043556.12163-2-linus.luessing@c0d3.blue>
References: 
 <20230720043556.12163-1-linus.luessing@c0d3.blue>
 <20230720043556.12163-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1995798.3VsfAaAtOV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692027329;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIjiIzgG3WiiXb9G4SOlo4E1rnBGZsco3n5UAQ/5c/w=;
	b=YwPK/9osBXvt4R4x0JO9zbqSA2gp0hKDam0atEGAUhsLXhZg03gOxv/kXmS7GHYzHj+AAl
	tQ3yfLv/X6arn8Yd0UMrlRbgORcZaHHQMjognVt6+N/F8Jpgdb+K4RMHF7wMEOsY2kDK5F
	P/IMmXXH8kKiXKRyQH5S02mI++ge4MG2VojkTQmRrYtNroc2snrNbTIeekPv4bwBKnu8RP
	kuWTVaNBEvFuKxuFU9NhI6mTqHyYhb+BElG7seGle4UGXeyuR8+pCjP7DtDAnNGLq9pkZZ
	MQlmFH0tWuVAbraGhhthxkYZQ2oHQGRyhqI9kKXN7ISwal3dGlDBr2hHNei5vQ==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692027329; a=rsa-sha256;
	cv=none;
	b=fOVFPStrz6l8C08suOHsomassTjeqBbXFW34OjcX1Yav37nkva6ycyDOyL+U01/TbBB4OT7YiAi8kkT44HANPm92132To8/bGUhCFKbyTiNELKZ1ffcfaRnU4SZXV9AsVUImU0ZegiQ2I7Sa8gfxvZkfQgbF1c5zUngMdsKzVbeWKxdhK73Vb3a0s1zz0WSwyk7ob5ssanr51CJkmkUf16MV25TYMoiPXbhAlDeBxCtM7RwOYXAf4Bi+q1wZvLzoDFgEkaIROk8F++3wowQ3Mhwx2RCGZW67gfxJ5q0evzRuf2S4tCk/kA1vhqfJzQMj4zTSkoOWjWHvAye3c0ZYdQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: WZS3N5NO5TBIEALV7PRIGSKLSR5XQZIZ
X-Message-ID-Hash: WZS3N5NO5TBIEALV7PRIGSKLSR5XQZIZ
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WZS3N5NO5TBIEALV7PRIGSKLSR5XQZIZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1995798.3VsfAaAtOV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 14 Aug 2023 17:35:28 +0200
Message-ID: <2296108.bB369e8A3T@prime>
In-Reply-To: <20230720043556.12163-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Thursday, July 20, 2023 6:35:53 AM CEST Linus L=FCssing wrote:
> [...]
> +
> +/**
> + * batadv_mcast_forw_orig_to_neigh() - get next hop neighbor to an orig
> address + * @bat_priv: the bat priv with all the soft interface informati=
on
> + * @orig_addr: the originator MAC address to search the best next hop
> router for + *
> + * Return: A neighbor node which is the best router towards the given
> originator + * address.
> + */
> +static struct batadv_neigh_node *
> +batadv_mcast_forw_orig_to_neigh(struct batadv_priv *bat_priv, u8
> *orig_addr) +{
> +	struct batadv_neigh_node *neigh_node;
> +	struct batadv_orig_node *orig_node;
> +
> +	orig_node =3D batadv_orig_hash_find(bat_priv, orig_addr);
> +	if (!orig_node)
> +		return NULL;
> +
> +	neigh_node =3D batadv_find_router(bat_priv, orig_node, NULL);
> +	batadv_orig_node_put(orig_node);
> +
> +	return neigh_node;
> +}

I was wondering if this shouldn't be a generic function rather than a multi=
cast-specific function. It doesn't do anything multicast specific. I couldn=
't find something similar in other code though.

> +
> +/**
> + * batadv_mcast_forw_scrub_dests() - scrub destinations in a tracker TVLV
> + * @bat_priv: the bat priv with all the soft interface information
> + * @comp_neigh: next hop neighbor to scrub+collect destinations for
> + * @dest: start MAC entry in original skb's tracker TVLV
> + * @next_dest: start MAC entry in to be sent skb's tracker TVLV
> + * @num_dests: number of remaining destination MAC entries to iterate ov=
er
> + *
> + * This sorts destination entries into either the original batman-adv
> + * multicast packet or the skb (copy) that is going to be sent to
> comp_neigh + * next.
> + *
> + * In preparation for the next, to be (unicast) transmitted batman-adv
> multicast + * packet skb to be sent to the given neighbor node, tries to
> collect all + * originator MAC addresses that have the given neighbor node
> as their next hop + * in the to be transmitted skb (copy), which next_dest
> points into. That is we + * zero all destination entries in next_dest whi=
ch
> do not have comp_neigh as + * their next hop. And zero all destination
> entries in the original skb that + * would have comp_neigh as their next
> hop (to avoid redundant transmissions and + * duplicated payload later).
> + */
> +static void
> +batadv_mcast_forw_scrub_dests(struct batadv_priv *bat_priv,
> +			      struct batadv_neigh_node *comp_neigh, u8 *dest,
> +			      u8 *next_dest, u16 num_dests)
> +{
> +	struct batadv_neigh_node *next_neigh;
> +
> +	/* skip first entry, this is what we are comparing with */
> +	eth_zero_addr(dest);
> +	dest +=3D ETH_ALEN;
> +	next_dest +=3D ETH_ALEN;
> +	num_dests--;
> +
> +	batadv_mcast_forw_tracker_for_each_dest(next_dest, num_dests) {
> +		if (is_zero_ether_addr(next_dest))
> +			goto scrub_next;
> +
> +		if (is_multicast_ether_addr(next_dest)) {
> +			eth_zero_addr(dest);
> +			eth_zero_addr(next_dest);
> +			goto scrub_next;
> +		}
> +
> +		next_neigh =3D batadv_mcast_forw_orig_to_neigh(bat_priv,
> +							     next_dest);
> +		if (!next_neigh) {
> +			eth_zero_addr(next_dest);
> +			goto scrub_next;
> +		}
> +
> +		/* Is this for our next packet to transmit? */
> +		if (batadv_compare_eth(next_neigh->addr, comp_neigh->addr))
> +			eth_zero_addr(dest);
> +		else
> +			eth_zero_addr(next_dest);
> +
> +		batadv_neigh_node_put(next_neigh);
> +scrub_next:
> +		dest +=3D ETH_ALEN;

I've read through that multiple times now, and I don't understand why next_=
dest isn't getting incremented within each iteration in the same way as des=
t. Is this a bug or am I missing something? Might be nicer to use one count=
er which is increased instead of two pointeres, e.g. &dest[counter] and &ne=
xt_dest[counter] or similar to avoid those kind of bugs.

> [...]
> +/**
> + * batadv_mcast_forw_tracker_tvlv_handler() - handle an mcast tracker tv=
lv
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the received batman-adv multicast packet
> + *
> + * Parses the tracker TVLV of an incoming batman-adv multicast packet and
> + * forwards the packet as indicated in this TVLV.
> + *
> + * Caller needs to set the skb network header to the start of the multic=
ast
> + * tracker TVLV (excluding the generic TVLV header) and the skb transport
> header + * to the next byte after this multicast tracker TVLV.
> + *
> + * Caller needs to free the skb.
> + *
> + * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
> + * code on failure. NET_RX_SUCCESS if the received packet is supposed to=
 be
> + * decapsulated and forwarded to the own soft interface, NET_RX_DROP
> otherwise. + */
> +int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
> +					   struct sk_buff *skb)
> +{
> +	return batadv_mcast_forw_packet(bat_priv, skb, false);
> +}
> diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
> index 34903df4fe93..e46ce83c516a 100644
> --- a/net/batman-adv/originator.c
> +++ b/net/batman-adv/originator.c
> @@ -942,6 +942,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct
> batadv_priv *bat_priv, #ifdef CONFIG_BATMAN_ADV_MCAST
>  	orig_node->mcast_flags =3D BATADV_MCAST_WANT_NO_RTR4;
>  	orig_node->mcast_flags |=3D BATADV_MCAST_WANT_NO_RTR6;
> +	orig_node->mcast_flags |=3D BATADV_MCAST_HAVE_MC_PTYPE_CAPA;
>  	INIT_HLIST_NODE(&orig_node->mcast_want_all_unsnoopables_node);
>  	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv4_node);
>  	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv6_node);
> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 163cd43c4821..f1061985149f 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -1270,3 +1270,73 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
>  	batadv_orig_node_put(orig_node);
>  	return ret;
>  }
> +
> +#ifdef CONFIG_BATMAN_ADV_MCAST
> +/**
> + * batadv_recv_mcast_packet() - process received batman-adv multicast
> packet + * @skb: the received batman-adv multicast packet
> + * @recv_if: interface that the skb is received on
> + *
> + * Parses the given, received batman-adv multicast packet. Depending on =
the
> + * contents of its TVLV forwards it and/or decapsulates it to hand it to
> the + * soft interface.
> + *
> + * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS
> otherwise. + */
> +int batadv_recv_mcast_packet(struct sk_buff *skb,
> +			     struct batadv_hard_iface *recv_if)
> +{
> +	struct batadv_priv *bat_priv =3D netdev_priv(recv_if->soft_iface);
> +	struct batadv_mcast_packet *mcast_packet;
> +	int hdr_size =3D sizeof(*mcast_packet);
> +	unsigned char *tvlv_buff;
> +	int ret =3D NET_RX_DROP;
> +	u16 tvlv_buff_len;
> +
> +	if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
> +		goto free_skb;
> +
> +	/* create a copy of the skb, if needed, to modify it. */
> +	if (skb_cow(skb, ETH_HLEN) < 0)
> +		goto free_skb;
> +
> +	/* packet needs to be linearized to access the tvlv content */
> +	if (skb_linearize(skb) < 0)
> +		goto free_skb;
> +
> +	mcast_packet =3D (struct batadv_mcast_packet *)skb->data;
> +	if (mcast_packet->ttl-- < 2)
> +		goto free_skb;

More of a nit (since we do the same check in broadcasts), but if ttl =3D=3D=
 0 on the incoming packet, then we will actually forward it with ttl =3D255=
 and that's a bit stupid ...

Cheers,
      Simon

--nextPart1995798.3VsfAaAtOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmTaScAACgkQoSvjmEKS
nqEBAQ//d2xFjecLAAgUupCNiEVmecOvTaPQegPacprzSPSmA0s3+OGTzB5WRurV
llULxHIdgBlZaVgqeedlwps0n4FZiRznNEnQsYe/9DYyS0JkanFIOpZktrbaf39/
S97OqJ416w1BMp8C0h20+bLGef9fPQL0GWYR5Ci9iaGB+X1g44smSkBoTZX8Jw5X
6/Ao2uW9dehwmCq0Fp6OLrMdFPgy23kXDb7KLJL/8ozWh305OSqnBth4DKvnsP/r
qmH9bDmYMcUy/RY6JtjHPzljyy3GycGzqVM9SJURKXI2ux7KfnSCNF4i94DSXsMK
kyZI1yatsLUxrhnmD7Bh4Ei+GWzWfY0ssquUq3AhhXX0NUDAcTDtCXJrv8xXVEyD
suxF0U+uAk6hFvBH7FGksxCylwsID5DQP3lbcgXOz0mmkeHLRv5cgRba+uV55E0b
UcbwKYZT8GEa6CE2unXhsMzKuY5qLidlseMXHaKS3H4cJ+29x5uYhLrG1gbpCo/E
NR33LM2RxkmD7dQ1FMlhtAp58MKb01OCZcJkaOl5L+ojcF3SNAACq+FrMs3BDFzR
VbC+kpLrq5oFm8GyGXEyNUZsuBujR1bytcWLJsW10p3CquBCCjY+y/LF8sgjbLE7
jTwh0/aLf/e1PQxkRsTFSTlgPeO2suz7F90silgVF2QH8hjB+Wk=
=HEjW
-----END PGP SIGNATURE-----

--nextPart1995798.3VsfAaAtOV--



