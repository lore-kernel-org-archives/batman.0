Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4706DC56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 16:03:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 569D284239
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 18:02:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786032179;
 b=Hf1FK13r+/QVnB5n0NXOSRziFBakEr6u65Z6SkWR85G3+emPOo0W8hx9pGBedkC9Y8xAq
 0WbSpVYuqpRy2Xm2rnz8vL7J4aVFdJq69SY+HIEQN8MdPrvL3Zhqp8qZIDbsAd6hMoxUYKn
 XJ28D/YsCZPHR0ArFG29dHYLxlm+oO8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786032179; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=h+v7fdLYRLY/mfW8T/A9/gsRMVxejYlstFTAF6GuefA=;
 b=um7b2aaz78PH7seOio+gC+EqRLSPg7DYhkN7KH4Ysms/sPf+dfIy/mW65U9DKRZc2WJDZ
 lm+rA4fG72xfXgG3wOgTDr0AX64WWRSH4L4U+LHsJX/Mk7uXAe1V8Qg9R40scDSCpGxEfku
 Kj9jYjnoMAJRbi6S2v3tcPfw6pKCpjY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AB31B80268
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 18:02:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786032161;
	b=C1n+9rT1OmHub2j5qF25snQHG0R9WU8lgejRh3EAP/F3ocSeOAj3vwQ6q2j7mf0lodbgG8
	lVvFaX7a7mWVr3gPtaFrr4k15yBhLZlzD8jxy3H5dPrLny4BVdqFcVkMx3/1x3rH/yuMRP
	zg3lcuwv4O+T0jC3nPRj7gyFDP3K2cc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786032161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=h+v7fdLYRLY/mfW8T/A9/gsRMVxejYlstFTAF6GuefA=;
	b=ZFJuIVMSWJm5DcA0yACw+v1FEoPsrnV/QNnByO4VmU5oL7r/1Ij00qLXPjFfku8AI8dKnM
	a1VJ9b6LT/gAggxX0CDI+f4LsTXN1HQ9NU2OfJiDm6f35mq1ciY/oZWdX0D/4KBBgyfLiC
	/Loiog4odLSX8XkHrRgrpe74lMHx39A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=j+uI9yU4;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2DBE92049B;
	Thu, 06 Aug 2026 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786032146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+v7fdLYRLY/mfW8T/A9/gsRMVxejYlstFTAF6GuefA=;
	b=j+uI9yU4QN+bIeHHVGQsRKaf6XFhAuuZknB3Pt5tvPCs4OsPweJnrlXlOZqhdEvvzpygt7
	VWfPZPaWSzsqwXueUKGBRdvBbHD+AWi4hhdHNDZdEAhOUASp1Ytd7aStSKr87W3YlOkWQD
	z8WqPJL3Z9+g/j+FkuwlSVtcyMqJN6w=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 03/10] batman-adv: add missing kernel-doc
 comments
Date: Thu, 06 Aug 2026 18:02:17 +0200
Message-ID: <4118698.kQq0lBPeGt@sven-desktop>
In-Reply-To: <20260805143200.722098-4-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-4-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3863999.iIbC2pHGDl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: IS5K47IWWBVJX73C6MXGZ4AFMHXDRROU
X-Message-ID-Hash: IS5K47IWWBVJX73C6MXGZ4AFMHXDRROU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IS5K47IWWBVJX73C6MXGZ4AFMHXDRROU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3863999.iIbC2pHGDl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 18:02:17 +0200
Message-ID: <4118698.kQq0lBPeGt@sven-desktop>
In-Reply-To: <20260805143200.722098-4-sw@simonwunderlich.de>
MIME-Version: 1.0

> --- Patch [3]: [PATCH net-next 03/10] batman-adv: add missing kernel-doc =
comments ---
[...]
> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index 22622283f59b0..a9e80330fcb63 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -171,6 +171,14 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_pri=
v, const u8 *addr)
> >  	return NULL;
> >  }
> > =20
> > +/**
> > + * batadv_iv_ogm_neigh_new() - retrieve or create a B.A.T.M.A.N. IV ne=
ighbour
> > + * @hard_iface: the interface where the neighbour is connected to
> > + * @neigh_addr: the mac address of the neighbour
> > + * @orig_node: originator object representing the neighbour
> > + *
> > + * Return: pointer to the neigh_node or NULL in case of failure
> > + */
> >  static struct batadv_neigh_node *
> >  batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
> >  			const u8 *neigh_addr,
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Should the Return: line mention that the neighbour comes back with an
> elevated refcount?  batadv_iv_ogm_neigh_new() just forwards the result of
> batadv_neigh_node_get_or_create(), so the caller owns a reference that has
> to be released with batadv_neigh_node_put().

Often not done this way. Somebody interested in writing kernel-doc is free =
to=20
adjust this everywhere in batman-adv.

I will not submit directly a patch.

>=20
> [ ... ]
>=20
> > @@ -1765,6 +1873,14 @@ static void batadv_iv_ogm_process(const struct s=
k_buff *skb, int ogm_offset,
> >  	batadv_orig_node_put(orig_node);
> >  }
> > =20
> > +/**
> > + * batadv_iv_send_outstanding_bat_ogm_packet() - work-queue helper to =
emit a
> > + *  queued forward packet
> > + * @work: work item embedded in the forward packet
> > + *
> > + * Emit the queued OGM forward packet and, for own primary-interface p=
ackets,
> > + * schedule the next periodic OGM. The forward packet is freed afterwa=
rds.
> > + */
> >  static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_stru=
ct *work)
> >  {
> >  	struct delayed_work *delayed_work;
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is "for own primary-interface packets" the condition that is actually
> implemented?  The body reads:
>=20
> 	if (forw_packet->own &&
> 	    forw_packet->if_incoming =3D=3D forw_packet->if_outgoing)
> 		batadv_iv_ogm_schedule(forw_packet->if_incoming);
>=20
> and batadv_iv_ogm_schedule_buff() queues own OGMs of secondary interfaces
> with own =3D=3D 1 and if_incoming =3D=3D if_outgoing as well:
>=20
> 	scheduled =3D batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf, ogm_buff-=
>len,
> 					    hard_iface, hard_iface, 1, send_time);
>=20
> so the re-schedule branch is taken for secondary interfaces too.

It is about the primary interface packets. See __batadv_forw_bcast_packet's=
=20
call of batadv_forw_bcast_packet_if. See parameters primary_if (incoming_if=
)=20
and hard_iface (outgoing_if). Check batadv_forw_bcast_packet_to_list() to f=
ind=20
the only place which sets own_packet.

[...]
> Separately, is "The forward packet is freed afterwards" true in all cases?
> The free only happens when the steal succeeds:
>=20
> 	if (batadv_forw_packet_steal(forw_packet,
> 				     &bat_priv->forw_bat_list_lock))
> 		batadv_forw_packet_free(forw_packet, dropped);

See documentation of batadv_forw_packet_steal. For the caller, the skb is n=
o longer usable.

> [ ... ]
>=20
> > @@ -2328,6 +2461,14 @@ static void batadv_iv_init_sel_class(struct bata=
dv_priv *bat_priv)
> >  	WRITE_ONCE(bat_priv->gw.sel_class, 20);
> >  }
> > =20
> > +/**
> > + * batadv_iv_gw_get_best_gw_node() - retrieve the best gateway node ba=
sed on
> > + *  the B.A.T.M.A.N. IV metric and the configured GW selection class
> > + * @bat_priv: the bat priv with all the mesh interface information
> > + *
> > + * Return: gateway node with the highest score for the current selecti=
on class,
> > + *  or NULL if no eligible gateway exists.
> > + */
> >  static struct batadv_gw_node *
> >  batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
> >  {
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Same question for the returned reference here: curr_gw is returned with an
> extra kref taken inside the RCU loop:
>=20
> 				curr_gw =3D gw_node;
> 				kref_get(&curr_gw->refcount);
>=20
> Should the Return: line say the gateway node is returned with increased
> refcount, like batadv_gw_get_selected_orig() does?

Often not done this way. Somebody interested in writing kernel-doc is free =
to=20
adjust this everywhere in batman-adv.

I will not submit directly a patch.

> > diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
> > index db6f5bdcaa985..0068f0e238da6 100644
> > --- a/net/batman-adv/bat_v.c
> > +++ b/net/batman-adv/bat_v.c
>=20
> [ ... ]
>=20
> > @@ -444,6 +475,16 @@ batadv_v_orig_dump(struct sk_buff *msg, struct net=
link_callback *cb,
> >  	cb->args[2] =3D sub;
> >  }
> > =20
> > +/**
> > + * batadv_v_neigh_cmp() - compare two B.A.T.M.A.N. V neighbours by thr=
oughput
> > + * @neigh1: first neighbour to compare
> > + * @if_outgoing1: outgoing interface to use for @neigh1
> > + * @neigh2: second neighbour to compare
> > + * @if_outgoing2: outgoing interface to use for @neigh2
> > + *
> > + * Return: a positive value if @neigh1 is better, a negative value if =
@neigh2
> > + *  is better and 0 if both have equal throughput
> > + */
> >  static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
> >  			      struct batadv_hard_iface *if_outgoing1,
> >  			      struct batadv_neigh_node *neigh2,
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is 0 only returned for equal throughput?  batadv_v_neigh_cmp() also retur=
ns
> the initial value on the error paths when the ifinfo lookup fails:
>=20
> 	int ret =3D 0;
>=20
> 	ifinfo1 =3D batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
> 	if (!ifinfo1)
> 		goto err_ifinfo1;
>=20
> 	ifinfo2 =3D batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
> 	if (!ifinfo2)
> 		goto err_ifinfo2;
>=20
> A caller cannot distinguish that from "both have equal throughput".  Shou=
ld
> the Return: description cover the failed lookup case?

A person more proficient in writing kernel-doc is free to do this and updat=
e=20
it everywhere. Will not submit a patch.


> > diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-inte=
rface.c
> > index b6867576bbafa..1950b8809d99f 100644
> > --- a/net/batman-adv/hard-interface.c
> > +++ b/net/batman-adv/hard-interface.c
>=20
> [ ... ]
>=20
> > @@ -467,6 +478,14 @@ int batadv_hardif_no_broadcast(struct batadv_hard_=
iface *if_outgoing,
> >  	return ret;
> >  }
> > =20
> > +/**
> > + * batadv_hardif_get_active() - retrieve an active hard interface for =
a mesh
> > + *  interface
> > + * @mesh_iface: mesh interface to search
> > + *
> > + * Return: first hard interface in BATADV_IF_ACTIVE state attached to
> > + *  @mesh_iface, or NULL if none is active.
> > + */
> >  static struct batadv_hard_iface *
> >  batadv_hardif_get_active(struct net_device *mesh_iface)
> >  {
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> The returned interface carries a reference taken in the loop:
>=20
> 		if (hard_iface->if_status =3D=3D BATADV_IF_ACTIVE &&
> 		    kref_get_unless_zero(&hard_iface->refcount))
> 			goto out;
>=20
> Should the Return: line state that the caller has to release it with
> batadv_hardif_put()?

Often not done this way. Somebody interested in writing kernel-doc is free =
to=20
adjust this everywhere in batman-adv.

I will not submit directly a patch.

> [ ... ]
>=20
> > @@ -502,6 +530,15 @@ static void batadv_primary_if_update_addr(struct b=
atadv_priv *bat_priv,
> >  	batadv_hardif_put(primary_if);
> >  }
> > =20
> > +/**
> > + * batadv_primary_if_select() - select the new primary interface
> > + * @bat_priv: the bat priv with all the mesh interface information
> > + * @new_hard_iface: new primary interface, may be NULL
> > + *
> > + * Replace the currently selected primary interface with @new_hard_ifa=
ce,
> > + * invoke the algorithm-specific primary_set hook and update the origi=
nator
> > + * MAC address.
> > + */
> >  static void batadv_primary_if_select(struct batadv_priv *bat_priv,
> >  				     struct batadv_hard_iface *new_hard_iface)
> >  {
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Would it be worth documenting the locking context here?  The writer
> serialization of batadv_primary_if_select() comes from RTNL only:
>=20
> 	ASSERT_RTNL();
>=20
> 	if (new_hard_iface)
> 		kref_get(&new_hard_iface->refcount);
>=20
> 	curr_hard_iface =3D rcu_replace_pointer(bat_priv->primary_if,
> 					      new_hard_iface, 1);
>=20
> A contributor promoting this helper based on the new comment alone would =
not
> learn that RTNL has to be held.

Often not done this way. Somebody interested in writing kernel-doc is free =
to=20
adjust this everywhere in batman-adv.

I will not submit directly a patch.


> [ ... ]
>=20
> > @@ -534,6 +578,15 @@ batadv_hardif_is_iface_up(const struct batadv_hard=
_iface *hard_iface)
> >  	return false;
> >  }
> > =20
> > +/**
> > + * batadv_check_known_mac_addr() - warn about duplicate hard interface=
 MAC
> > + *  addresses
> > + * @hard_iface: hard interface that was just added or had its MAC chan=
ged
> > + *
> > + * Iterate over all hard interfaces of the same mesh interface and emi=
t a
> > + * warning if another in-use interface shares the same MAC address as
> > + * @hard_iface.
> > + */
> >  static void batadv_check_known_mac_addr(const struct batadv_hard_iface=
 *hard_iface)
> >  {
> >  	struct net_device *mesh_iface =3D hard_iface->mesh_iface;
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Same question for this one: the lower device list is walked with the
> non-RCU iterator, which requires RTNL:
>=20
> 	netdev_for_each_lower_private(mesh_iface, tmp_hard_iface, iter) {
>=20
> Should the new comment note that the caller must hold RTNL?

Often not done this way. Somebody interested in writing kernel-doc is free =
to adjust this everywhere in batman-adv.

I will not submit directly a patch.

> > diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> > index 73becb0549488..78b81daaeff9a 100644
> > --- a/net/batman-adv/main.c
> > +++ b/net/batman-adv/main.c
>=20
> [ ... ]
>=20
> > @@ -492,6 +513,13 @@ int batadv_batman_skb_recv(struct sk_buff *skb, st=
ruct net_device *dev,
> >  	return NET_RX_DROP;
> >  }
> > =20
> > +/**
> > + * batadv_recv_handler_init() - initialise the RX handler dispatch tab=
le
> > + *
> > + * Initialise all entries of the RX handler table as either "unhandled=
" or with
> > + * protocol indepentend handlers, and perform compile-time size sanity=
 checks on
>                     ^^^^^^^^^^^
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Typo, "indepentend" should be "independent".

Will not send a resent the patches because of thos. But an interested=20
contributor can go through the whole code and fix various typos.

>=20
> > + * all on-wire packet structs.
> > + */
> >  static void batadv_recv_handler_init(void)
> >  {
> >  	int i;
>=20
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index dae5e1d8c0385..b12ec8d1b5451 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
>=20
> [ ... ]
>=20
> > @@ -1224,6 +1239,17 @@ int batadv_tt_local_dump(struct sk_buff *msg, st=
ruct netlink_callback *cb)
> >  	return ret;
> >  }
> > =20
> > +/**
> > + * batadv_tt_local_set_pending() - mark a local TT entry as pending re=
moval
> > + * @bat_priv: the bat priv with all the mesh interface information
> > + * @tt_local_entry: local TT entry to mark
> > + * @flags: TT change flags to announce together with the pending remov=
al
> > + * @message: debug message describing the reason for the change
> > + *
> > + * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDIN=
G on the
> > + * entry. The entry is kept in the local table until the next TTVN inc=
rement
> > + * so that a consistency-check response can still be answered.
> > + */
> >  static void
> >  batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
> >  			    struct batadv_tt_local_entry *tt_local_entry,
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Should the calling context be part of this comment?  One caller runs it w=
ith
> the TT hash bucket lock held:
>=20
> batadv_tt_local_purge() {
> 	...
> 		spin_lock_bh(list_lock);
> 		batadv_tt_local_purge_list(bat_priv, head, timeout);
> 		spin_unlock_bh(list_lock);
> 	...
> }
>=20
> and batadv_tt_local_purge_list() then calls batadv_tt_local_set_pending(),
> so the helper runs in atomic context with that spinlock held.

Uhm, but the list_lock is there because of the list access in=20
batadv_tt_local_purge_list() and not because of batadv_tt_local_set_pending=
().

And it is rather uncommon to document what callers do.

>=20
> [ ... ]
>=20
> > @@ -2338,6 +2419,16 @@ static void batadv_tt_global_table_free(struct b=
atadv_priv *bat_priv)
> >  	bat_priv->tt.global_hash =3D NULL;
> >  }
> > =20
> > +/**
> > + * _batadv_is_ap_isolated() - check whether two clients are AP-isolate=
d from
> > + *  each other
> > + * @tt_local_entry: local TT entry of the sending client
> > + * @tt_global_entry: global TT entry of the destination client
> > + *
> > + * Return: true if traffic between the two clients should be dropped b=
ecause
> > + *  either both are WiFi clients or both carry the ISOLATION flag; fal=
se
> > + *  otherwise
> > + */
> >  static bool
> >  _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
> >  		       struct batadv_tt_global_entry *tt_global_entry)
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Do the sending/destination roles hold for both call sites?
> batadv_is_ap_isolated() passes the destination as the local entry and the
> source as the global entry:
>=20
> 	tt_local_entry =3D batadv_tt_local_hash_find(bat_priv, dst, vid);
> 	...
> 	tt_global_entry =3D batadv_tt_global_hash_find(bat_priv, src, vid);
> 	...
> 	if (_batadv_is_ap_isolated(tt_local_entry, tt_global_entry))
>=20
> which is the reverse of the documented roles, while batadv_transtable_sea=
rch()
> matches them (local from src, global from addr).  The current test is
> symmetric, so nothing misbehaves today; would a wording without the
> sender/destination roles describe both callers?

Might send a patch later because this can really be confusing.

Regards,
	Sven
--nextPart3863999.iIbC2pHGDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSwCQAKCRBND3cr0xT1
yy0sAQDAoasTg1muYUe4tUl3/xZQffAwGXgW106MRYdnBxbT2QD/THue0XQZ3f8u
XCC9vMUa2gOEOFmik0el7o0aKsxI0A4=
=qbct
-----END PGP SIGNATURE-----

--nextPart3863999.iIbC2pHGDl--



