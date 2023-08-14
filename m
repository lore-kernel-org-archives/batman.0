Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CA4C001E0
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 15:54:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E45D48321D
	for <batman-adv@archiver.kernel.org>; Mon, 14 Aug 2023 17:54:14 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692028454;
 b=xoptawDp8WggHPIQDHNlsUR099+do8g1iMyzAv7Rmixh+5DALB32UIrrVPWaFym7U8HBT
 yGX5rncR4H2ISO+/OYKI2c2AzZ5ztO6IKndzWvqz7cu0coIbptSyuDihSDubPO7+BRfaLLb
 FqocgJCVMSGdFVwoYO67gSDPiNPGDz0=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692028454; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oADH0Q1xwpqgTIegSKHI/tfuSD4CiSFz44IfCER1dko=;
 b=c/fDqMZOys38as/4DFiTT3RHRNnw1AEKfLEDhdePXQWTBSJ9B1O2mgTAETDekQm501ftq
 KOsQfGi5Z79wIcY8DDEoOBPC/67m0hXUqTtjR2DMWSvGy3nVyaisoNjlzHyYeXXa6q8DV5F
 dnzM5XqPXWN3IdaWXqV/l6HAabIZUHs=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 84DDC80937
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Aug 2023 17:53:39 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692028420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oADH0Q1xwpqgTIegSKHI/tfuSD4CiSFz44IfCER1dko=;
	b=xhJ/QOPEggOdSrwhcaTMsKygl540Kdh6kVQ9yFt8tTE4G8OWNXXWgkr3wVeh/D/P8TJuP2
	zQRKUjrpK64aWCxlcq64mXpWBpZjcXW5rgxsA8Zx+Nc+i5afSF4/ljpezRcI20EbowTeRG
	dC+TZRdQIZob6y/JGfm7iVDtim0NsRg=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=IK273sRr;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692028420; a=rsa-sha256;
	cv=pass;
	b=KUtIw71SDOAZs4Am7Hfu7gYA4tRWhwbGzrVK/126bEnaAK5naZDDftoFn8ks+oTzCwMQeD
	iDaON6lAd38GjkLVWsMyOEmKn01R3+MiAQNowY2y8IrNScFsaKpBd9Bkq9lg8XNTbx2kIY
	EiPy0cw0TC69WWF9clQPTALaPiBfQwA=
Received: from prime.localnet
 (p200300C5970E8aD8A82608F38C359cBd.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:8ad8:a826:8f3:8c35:9cbd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3EBD0FB5B0;
	Mon, 14 Aug 2023 17:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692028419;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oADH0Q1xwpqgTIegSKHI/tfuSD4CiSFz44IfCER1dko=;
	b=IK273sRrfDluqkIxy4yHvtgAg2VgLCLBZbjho0XQK2zmTDlB+Qj/LV5VBn0EveWt7D+2v6
	9Kn5DTtwpjBhxOzdonNgbvd6/I/8IxeVjUScyl36EUuslqdiGo+4fkcPurjoZG0LEiLQ+J
	Uopyv4vy3uNhsL9fbT0QPeFF1aCvO6M6o/vlyygnz6KVbTaJSvQLKsQMY8fTWysb6k1I5V
	LaPmdr7SabcNsaYJsZ+WKEJPpN967eELFRk4zgstOFj2V3+NrnIIhueLwSnTTiTHXmJOLz
	gwVavgHhDH/WASEDBhUx3CmtdktlOkRIHJMP0MbwlSORCvP4Znp+zcJQ8HknXw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 1/3] batman-adv: mcast: implement multicast packet reception
 and forwarding
Date: Mon, 14 Aug 2023 17:53:38 +0200
Message-ID: <38662377.10thIPus4b@prime>
In-Reply-To: <2296108.bB369e8A3T@prime>
References: 
 <20230720043556.12163-1-linus.luessing@c0d3.blue>
 <20230720043556.12163-2-linus.luessing@c0d3.blue> <2296108.bB369e8A3T@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3703112.V25eIC5XRa";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692028419;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oADH0Q1xwpqgTIegSKHI/tfuSD4CiSFz44IfCER1dko=;
	b=rtpXdqY0ZjyalfFVKBssmzPORl4At67Ggc9jfFXhgA+s0kGV+ifg8PIwbpPdhUJNrRv63T
	01ludkiKn87Tt9wzodXvvW01/d9WntAy2AIgDTEl6RprK/j/PF6paKHzuqk4RdCYp7QSKv
	WPnmjE/+if7+Uo7l6HBsW5Z+U9a2jFyCdj7kXMfsR2Ej4XmtutvlF74+pYGCuOL4hd4K2h
	q4AXRXwj48kEbENhaBw/g8qP6zWnipr74L4HQf/T7hDY9fw8UUkOz6gfY9CJ22KzxJxVL0
	qFz/M0NzsuHJqKdAgbr/PbK0R4ak1SgDDmiQhupQs/8/RxYnj9LtxCBGm5aI1A==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692028419; a=rsa-sha256;
	cv=none;
	b=byBlh37IiUHtBwDl/b41VXTsj3ib6b3JGTTc9yQnTkDxXre/Gs1+NKeUGiMabGFfjs5QnEK1z2yFLx2uRwvUzdnlWwQGl7a/76bAHfqaK23kYbvUcaUnqlCG8oo0FJ9O43BP+tndV8SOo5ynfZl7d8vTyHchVVMxAHJ1mZJrvTyaCVhiI4E8z28zdn74D8YwiDADr3fbhuSIkL7Zc35ZVFgBvwY8eC/4m3hEwDIQSku6lbgnkn0//lHcgAt1xE1cfAX+M7MU188cgiejRdkHtbvRPgJrl+6kySwxapP+2lVezfJ0opMprAMREnXmwpJM9RyT3+eZLgu9YqxIzLfxng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: ERFTHI23LDTLSSFPD6SKLC4DDR2DWIVZ
X-Message-ID-Hash: ERFTHI23LDTLSSFPD6SKLC4DDR2DWIVZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ERFTHI23LDTLSSFPD6SKLC4DDR2DWIVZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3703112.V25eIC5XRa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 14 Aug 2023 17:53:38 +0200
Message-ID: <38662377.10thIPus4b@prime>
In-Reply-To: <2296108.bB369e8A3T@prime>
MIME-Version: 1.0

On Monday, August 14, 2023 5:35:28 PM CEST Simon Wunderlich wrote:
> I've read through that multiple times now, and I don't understand why
> next_dest isn't getting incremented within each iteration in the same way
> as dest. Is this a bug or am I missing something? Might be nicer to use one
> counter which is increased instead of two pointeres, e.g. &dest[counter]
> and &next_dest[counter] or similar to avoid those kind of bugs.
> > [...]


Discussed with Sven, next_dest is actually the iterator so it should be 
incremented at the other place.

I still think this is very hard to read, both Sven and I spent quite some time 
with pen and paper to understand this function. I would appreciate if it could 
be simplified.

> > +/**
> > + * batadv_mcast_forw_tracker_tvlv_handler() - handle an mcast tracker
> > tvlv
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @skb: the received batman-adv multicast packet
> > + *
> > + * Parses the tracker TVLV of an incoming batman-adv multicast packet and
> > + * forwards the packet as indicated in this TVLV.
> > + *
> > + * Caller needs to set the skb network header to the start of the
> > multicast + * tracker TVLV (excluding the generic TVLV header) and the
> > skb transport header + * to the next byte after this multicast tracker
> > TVLV.
> > + *
> > + * Caller needs to free the skb.
> > + *
> > + * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
> > + * code on failure. NET_RX_SUCCESS if the received packet is supposed to
> > be + * decapsulated and forwarded to the own soft interface, NET_RX_DROP
> > otherwise. + */
> > +int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
> > +                                          struct sk_buff *skb)
> > +{
> > +       return batadv_mcast_forw_packet(bat_priv, skb, false);
> > +}
> > diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
> > index 34903df4fe93..e46ce83c516a 100644
> > --- a/net/batman-adv/originator.c
> > +++ b/net/batman-adv/originator.c
> > @@ -942,6 +942,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct
> > batadv_priv *bat_priv, #ifdef CONFIG_BATMAN_ADV_MCAST
> > orig_node->mcast_flags = BATADV_MCAST_WANT_NO_RTR4;
> > orig_node->mcast_flags |= BATADV_MCAST_WANT_NO_RTR6;
> > +       orig_node->mcast_flags |= BATADV_MCAST_HAVE_MC_PTYPE_CAPA;
> > INIT_HLIST_NODE(&orig_node->mcast_want_all_unsnoopables_node);
> > INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv4_node);
> > INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv6_node);
> > diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> > index 163cd43c4821..f1061985149f 100644
> > --- a/net/batman-adv/routing.c
> > +++ b/net/batman-adv/routing.c
> > @@ -1270,3 +1270,73 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
> > batadv_orig_node_put(orig_node);
> > return ret;
> > }
> > +
> > +#ifdef CONFIG_BATMAN_ADV_MCAST
> > +/**
> > + * batadv_recv_mcast_packet() - process received batman-adv multicast
> > packet + * @skb: the received batman-adv multicast packet
> > + * @recv_if: interface that the skb is received on
> > + *
> > + * Parses the given, received batman-adv multicast packet. Depending on
> > the + * contents of its TVLV forwards it and/or decapsulates it to hand
> > it to the + * soft interface.
> > + *
> > + * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS
> > otherwise. + */
> > +int batadv_recv_mcast_packet(struct sk_buff *skb,
> > +                            struct batadv_hard_iface *recv_if)
> > +{
> > +       struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
> > +       struct batadv_mcast_packet *mcast_packet;
> > +       int hdr_size = sizeof(*mcast_packet);
> > +       unsigned char *tvlv_buff;
> > +       int ret = NET_RX_DROP;
> > +       u16 tvlv_buff_len;
> > +
> > +       if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
> > +               goto free_skb;
> > +
> > +       /* create a copy of the skb, if needed, to modify it. */
> > +       if (skb_cow(skb, ETH_HLEN) < 0)
> > +               goto free_skb;
> > +
> > +       /* packet needs to be linearized to access the tvlv content */
> > +       if (skb_linearize(skb) < 0)
> > +               goto free_skb;
> > +
> > +       mcast_packet = (struct batadv_mcast_packet *)skb->data;
> > +       if (mcast_packet->ttl-- < 2)
> > +               goto free_skb;
> 
> More of a nit (since we do the same check in broadcasts), but if ttl == 0 on
> the incoming packet, then we will actually forward it with ttl =255 and
> that's a bit stupid ...

Mistake on my end on this one, the original value should be used for the 
comparison so this is okay.

Cheers,
       Simon



--nextPart3703112.V25eIC5XRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmTaTgIACgkQoSvjmEKS
nqEuwg/9GWsHUjqCYkzrK7PbHKTtziajPudl/4OwVHYA2ZaD9ITytxwfDNnXsDMs
F3vXUoYf3r5OBTCvoxcjVF1Id6KOMhfUuIsv3VqSRPYWoqjX3jNXahmo4s0cCqoi
+jDjU7MINTnyYAUAitWQOahqA3FCfNZZ8b5Z3mwajQJ69wWARVXRVcGG5GwftPEF
XCD7Dgcwe/wfgk+m+5cRb1J8VsfpGTxpU3ENVYPARV+PcmU11wCIvTCSRNBlRyi1
8lo+P7jDnx6sYtZPVzRL00qiQzrzkkj6tgJ4Jdr/DmHJIuQe0FAatFJ+k+OQk415
kalMKaPTChsWBEPmP84JUhcTfnA3muM8ZZtXjIQ5c4/1DeFOvInFGkYPE+Hp1WZc
kA+kqsiqaE8G45zzzAGP+ITVEGW8PHfBj/PwyuO9n32tmAJRlrmU+cXLYklUotIo
I/DXQtTmFdGTYfh1u+N7pSSV8yccUy4UKBKWvmqwHBGKEHDfH5VYNL0ThOmMMtyK
4sgWqCYqKjGnPwG3j97NeHdRp/l747Z+pvaEYuwhgSfRZiboloCSWr+K4/Ve8cQ9
JIHIDpgv3sJYB6VftAPmrhcuSZq5BR46gTeJDFqn3EqSaS5DjtBqu8buAbu78PuD
x7vxD11KMiGaizc9IrxF2RXvnrL4G/pWRmmekqKLJos78VPTvuE=
=xNF8
-----END PGP SIGNATURE-----

--nextPart3703112.V25eIC5XRa--



