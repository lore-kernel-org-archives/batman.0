Return-Path: <ordex@autistici.org>
Date: Sun, 17 Jun 2012 00:11:18 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120616221117.GB15888@ritirata.org>
References: <1339709917-15971-1-git-send-email-ordex@autistici.org>
	<1339828061-15884-1-git-send-email-ordex@autistici.org>
	<201206170300.14767.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <201206170300.14767.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: don't try to re-route
 tt_request for me
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 17, 2012 at 03:00:14AM +0800, Marek Lindner wrote:
> On Saturday, June 16, 2012 14:27:41 Antonio Quartulli wrote:
> > -static bool
> > +static void
> >  batadv_send_my_tt_response(struct batadv_priv *bat_priv,
> >                            struct batadv_tt_query_packet *tt_request)
> >  {
> > @@ -1656,7 +1656,6 @@ batadv_send_my_tt_response(struct batadv_priv
> > *bat_priv, struct batadv_neigh_node *neigh_node =3D NULL;
> >         struct batadv_hard_iface *primary_if =3D NULL;
> >         uint8_t my_ttvn, req_ttvn, ttvn;
> > -       int ret =3D false;
> >         unsigned char *tt_buff;
> >         bool full_table;
> >         uint16_t tt_len, tt_tot;
> > @@ -1751,7 +1750,6 @@ batadv_send_my_tt_response(struct batadv_priv
> > *bat_priv, batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
> > =20
> >         batadv_send_skb_packet(skb, neigh_node->if_incoming,
> > neigh_node->addr); -       ret =3D true;
> >         goto out;
> > =20
> >  unlock:
> > @@ -1763,10 +1761,6 @@ out:
> >                 batadv_neigh_node_free_ref(neigh_node);
> >         if (primary_if)
> >                 batadv_hardif_free_ref(primary_if);
> > -       if (!ret)
> > -               kfree_skb(skb);
> > -       /* This packet was for me, so it doesn't need to be re-routed */
> > -       return true;
> >  }
>=20
> Unless I am mistake you are adding a beautiful memory leak here.

You are right. I misinterpreted this skb.
I'll send v4 soon!

Thank you

>=20
> Regards,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/dBIUACgkQpGgxIkP9cwcw0wCgkBXIgYXl0m68ClUapELltq9i
McwAoJD/Jwzrm9yxltBXnP85VHDnWSs/
=FCAR
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
