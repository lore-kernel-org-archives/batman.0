Return-Path: <ordex@autistici.org>
Date: Mon, 30 Jul 2012 11:20:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120730092047.GE2578@ritirata.org>
References: <1343602203-11584-1-git-send-email-ordex@autistici.org>
 <201207300956.51449.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <201207300956.51449.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use check_unicast_packet()
 in recv_roam_adv()
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2012 at 09:56:51AM +0200, Marek Lindner wrote:
> On Monday, July 30, 2012 00:50:03 Antonio Quartulli wrote:
> > @@ -687,21 +687,9 @@ int batadv_recv_roam_adv(struct sk_buff *skb, stru=
ct
> > batadv_hard_iface *recv_if) struct batadv_priv *bat_priv =3D
> > netdev_priv(recv_if->soft_iface); struct batadv_roam_adv_packet
> > *roam_adv_packet;
> >  	struct batadv_orig_node *orig_node;
> > -	struct ethhdr *ethhdr;
> > -
> > -	/* drop packet if it has not necessary minimum size */
> > -	if (unlikely(!pskb_may_pull(skb,
> > -				    sizeof(struct batadv_roam_adv_packet))))
> > -		goto out;
> > +	int hdr_size =3D sizeof(struct batadv_roam_adv_packet);
>=20
> Shouldn't we do: int hdr_size =3D sizeof(*roam_adv_packet); ?

right. I copy/pasted the old code and I forgot to change it.
Will fix.

Thanks

>=20
>=20
> Regards,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAWUe8ACgkQpGgxIkP9cwcNtgCgk+7Db74ruspAXO0NqdH11sNv
lxUAoIoCzu+pqXbDaBKaKDg/3pM03TJT
=5cXr
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
