Return-Path: <ordex@autistici.org>
Date: Tue, 25 Dec 2012 11:51:23 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121225105123.GB2604@ritirata.org>
References: <1355577056-28833-1-git-send-email-ordex@autistici.org>
 <201212251627.37792.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <201212251627.37792.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: a delayed_work has to be
 initialised once
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 25, 2012 at 04:27:37 +0800, Marek Lindner wrote:
> On Saturday, December 15, 2012 21:10:56 Antonio Quartulli wrote:
> > -	batadv_start_purge_timer(bat_priv);
> > +	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
> > +	queue_delayed_work(batadv_event_workqueue,
> > +			   &bat_priv->orig_work, msecs_to_jiffies(1000));
> > +
> >  	return 0;
> >=20
> >  err:
> > @@ -396,7 +392,8 @@ static void batadv_purge_orig(struct work_struct *w=
ork)
> >  	delayed_work =3D container_of(work, struct delayed_work, work);
> >  	bat_priv =3D container_of(delayed_work, struct batadv_priv, orig_work=
);
> >  	_batadv_purge_orig(bat_priv);
> > -	batadv_start_purge_timer(bat_priv);
> > +	queue_delayed_work(batadv_event_workqueue,
> > +			   &bat_priv->orig_work, msecs_to_jiffies(1000));
> >  }
>=20
> If the same numeric value is used multiple times we should have a define.
>=20


Correct. I'll fix and resend.

Thanks a lot!

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ2YUrAAoJEADl0hg6qKeOgHoQAIxluYhKhmjj6jXbtoXQjsMu
0NvnpqhRcRqmsxVeRbSZ8NufiaZulQVD9ghhfTYHFEJfNpzIDmPOHCv2Q47ZuQEa
WNr9WFeDDmjcbU2ZvJQMjoGET78sltRJ4QHO/mJuv4l+coWbVzFgJ+OrSbfBz+1q
KjZgOsPrKvkmJTulQekgGx673Urm1tBGvgR1nb8r1W3QQ+RAs3/UVkmjvJ1IjOe9
ss6LzbhV1Cr2VPAWln2g8v24RAnL7b7VXnMXlSjkniZwBi5C6ume5eUGQf6rVSDD
RAwIYV7HjmvJv1zDJLi0SnbuHgQ5tXmSkqHwGCc7/Hrpg0m741b3yAnao9kHvTr0
8t4S7VyGsSZwdg+Tpu2aRRf3PBNdtC0YYvm/h/XS6iIKU047/PTEPFXLv3GGWlLl
bCrMHtO8kC5vyslZBaHZplojGYLyYDsYtN1OLkULqr0ONDokkrsYNMBwjrBUQsc0
Gzw0nhn0gn9mh/WhEPUqRcuXLDUhffU97wtWI4kd41NW3RP5tnc1KRvLSJY8bfbk
gDbQg/AsTXdgX/zqLcFpjgsaujjALT+qYN4sT7kKXPdKaQtAIDRR1DRYzY8aO21h
Z0d6QQ7u0EPvl7E9ZDWQvbyo8ECxh22abbY5W2LWLhp/Cy3LdCN1j6eBXLWRd5eF
3MYh8zF4mXZa4VkgDGZS
=NQGS
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
