Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16D1CD6E5D
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 13:33:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D90AF80479
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 15:33:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780234395;
 b=SI8iTw6/OkR6aljO7ix6QOUKMUwfmtoV8mmqc0i51LC9cO/VFjmEcC7KdRvu3PTxrxFxi
 VZNcn5PbQKKdQ8vF0/XaBjgFMB4VuvcCY97CMUik3qSmCWsss/kZ816IWhthPpB7/AbWaVM
 MAoTZ7mEGlRVqBz3rZUirDD6xXcIKVQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780234395; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yNu0Ngqlw7jm9Gx2PC0N0bokxRwrguc+uiDKdvkHyo0=;
 b=xPrfR4lpX4G9DVfysbMbOvIt9gy7ldxI40Gir5tQyx1E6p6yE+M+tV/7AmOVjEHGoWFlM
 mUyNrK82jaSFxWXq4SS1mL+xUplJYDBkqoNyP7HLDC6e7ns2cQRfL74Odhxdald5KMGdU2S
 OjQtKHmMIGaLRhZ78mVAgqs1lwbkh8Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 95B1080268
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 May 2026 15:32:44 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780234364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yNu0Ngqlw7jm9Gx2PC0N0bokxRwrguc+uiDKdvkHyo0=;
	b=IQDYFrtboYh5yHflSQtDLgNDSJgTl5KKvdAUV26ZApGksUb6c6fQjXX1BhmpDtM7z1IzDO
	LcUchcCPKP/CqtS0wQXp+2CDTccBvwZrowFf20AFyE/PiKPzIrxddMwqpmS9lFDel+mRVx
	//mNQ5NCLYH1RzKkKJbjj0zUTsoLl0w=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780234364;
	b=Kc88p+vw/FALOapxWdHhOrlIrVHmg+jSfSSYSKsl/9bCSoYsHuNJSoYk8opefAy64gHYxU
	wCxlYj4BL3+YdGNiXHxorTx7/cSsRAVHb6qVCfDigvEi4zE5YohUD6Ip4xFKd468VDgu9J
	LrsD0wiRQVBZjKqn5qQMsduc9ZJ2Opc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=j9zBW19T;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D65821FEDD;
	Sun, 31 May 2026 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780234363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNu0Ngqlw7jm9Gx2PC0N0bokxRwrguc+uiDKdvkHyo0=;
	b=j9zBW19TmW8CSOdv+WeqCxIt4WL4lvTwjxLo0pRkKdcgx9J/sCnMvalO6dfoPueUau94tJ
	OA7MPwxSaBA4e6XaII+kdy4gk3dMAvn/cvcsKZH65WZN1b55fHT5u37+TtWPkNWGHc7/SX
	13lQLJbypEWC0pnvgreAegJqSM53wh8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Nora Schiffer <neocturne@universe-factory.net>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 31 May 2026 15:32:39 +0200
Message-ID: <2615910.tdWV9SEqCh@sven-desktop>
In-Reply-To: <4860101.CbtlEUcBR6@sven-desktop>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
 <4860101.CbtlEUcBR6@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2923807.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: FMOGISOPJABBSDAYWVQPXHSG2IHNN4FV
X-Message-ID-Hash: FMOGISOPJABBSDAYWVQPXHSG2IHNN4FV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FMOGISOPJABBSDAYWVQPXHSG2IHNN4FV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2923807.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Nora Schiffer <neocturne@universe-factory.net>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 31 May 2026 15:32:39 +0200
Message-ID: <2615910.tdWV9SEqCh@sven-desktop>
In-Reply-To: <4860101.CbtlEUcBR6@sven-desktop>
MIME-Version: 1.0

On Saturday, 31 May 2025 11:56:34 CEST Sven Eckelmann wrote:
>=20
> Signature created on Samstag, 31. Mai 2025 11:56:35 Mitteleurop=C3=A4isch=
e Sommerzeit with certificate: Sven Eckelmann <sven@narfation.org> (EC37 14=
82 9567 81AF)
> The signature is valid and the certificate's validity is ultimately trust=
ed.
> On Monday, 19 May 2025 22:46:31 CEST Matthias Schiffer wrote:
> >  struct batadv_hard_iface *
> > -batadv_hardif_get_by_netdev(const struct net_device *net_dev)
> > +batadv_hardif_get_by_netdev(struct net_device *net_dev)
> >  {
> >         struct batadv_hard_iface *hard_iface;
> > +       struct net_device *mesh_iface;
> > =20
> > -       rcu_read_lock();
> > -       list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
> > -               if (hard_iface->net_dev =3D=3D net_dev &&
> > -                   kref_get_unless_zero(&hard_iface->refcount))
> > -                       goto out;
> > -       }
> > +       mesh_iface =3D netdev_master_upper_dev_get(net_dev);
> > +       if (!mesh_iface || !batadv_meshif_is_valid(mesh_iface))
> > +               return NULL;
> > =20
> > -       hard_iface =3D NULL;
> > +       hard_iface =3D netdev_lower_dev_get_private(mesh_iface, net_dev=
);
> > +       if (!kref_get_unless_zero(&hard_iface->refcount))
> > +               return NULL;
> > =20
> > -out:
> > -       rcu_read_unlock();
> >         return hard_iface;
> >  }
>=20
> This code is now relying on rtnl_lock() (see `ASSERT_RTNL` in=20
> `netdev_master_upper_dev_get` and most likely some comments somwhere abou=
t the=20
> lists used by `netdev_lower_dev_get_private`). But `batadv_tt_local_add` =
is=20
> using this function without holding this lock all the time. For example d=
uring
> packet processing.
>=20
> See for example `batadv_tt_local_add` calls in `batadv_interface_tx`. Thi=
s=20
> will happen when `skb->skb_iif` is not 0 (so it was forwarded).

I am currently gathering the changes in an RFC branch=20
https://git.open-mesh.org/pub/ecsv/batman-adv.git/log/?h=3Db4/drop-hardif-l=
ist=20
and will post the result after the v2 version of the net-next.git PR was=20
(first submitted and then) merged.

I came to the conclusion that the batadv_tt_local_add() part must already b=
e=20
handled in "batman-adv: only create hardif while a netdev is part of a mesh"
(or earlier). And since we have an rhashtable for it, I would propose=20
something like:

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translatio=
n-table.c
index 25acbb346a17297a558a021a717a2cfc1753ae91..2abf0e35e2eafe3d19f37ebd566=
c926deca082b5 100644
=2D-- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -636,20 +636,22 @@ bool batadv_tt_local_add(struct net_device *mesh_ifac=
e, const u8 *addr,
 	struct net *net =3D dev_net(mesh_iface);
 	struct batadv_meshif_vlan *vlan;
 	struct net_device *in_dev =3D NULL;
=2D	struct batadv_hard_iface *in_hardif =3D NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added, table_size, packet_size_max;
 	bool ret =3D false;
 	bool roamed_back =3D false;
+	bool iif_is_wifi =3D false;
 	u8 remote_flags;
 	u32 match_mark;
=20
 	if (ifindex !=3D BATADV_NULL_IFINDEX)
 		in_dev =3D dev_get_by_index(net, ifindex);
=20
=2D	if (in_dev)
=2D		in_hardif =3D batadv_hardif_get_by_netdev(in_dev);
+	if (in_dev) {
+		u32 wifi_flags =3D batadv_netdev_get_wifi_flags(in_dev);
+		iif_is_wifi =3D batadv_is_wifi(wifi_flags);
+	}
=20
 	tt_local =3D batadv_tt_local_hash_find(bat_priv, addr, vid);
=20
@@ -724,7 +726,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface,=
 const u8 *addr,
 	 */
 	tt_local->common.flags =3D BATADV_TT_CLIENT_NEW;
 	tt_local->common.vid =3D vid;
=2D	if (batadv_is_wifi_hardif(in_hardif))
+	if (iif_is_wifi)
 		tt_local->common.flags |=3D BATADV_TT_CLIENT_WIFI;
 	kref_init(&tt_local->common.refcount);
 	tt_local->last_seen =3D jiffies;



It is still required to adjust the netlink code to not run into rtnl_lock=20
problems when running things like batadv_pre_doit() -> ... ->=20
batadv_netlink_get_hardif_from_ifindex() -> batadv_hardif_get_by_netdev().
Most likely by a simple rtnl_lock() in
batadv_netlink_get_hardif_from_ifindex().

Regards,
	Sven
--nextPart2923807.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahw4dwAKCRBND3cr0xT1
y2QiAQDcz3quJupRzbhsHHaKbVWKoIAFmCWKwfRjdEke16nVIAD+MJRBUYRRnoII
eu9W8pkTi5M8w8j7tkKQRU8WVzU5rA0=
=d11N
-----END PGP SIGNATURE-----

--nextPart2923807.irdbgypaU6--



