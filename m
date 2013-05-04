Return-Path: <ordex@autistici.org>
Date: Sat, 4 May 2013 19:07:45 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130504170744.GF3773@ritirata.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-5-git-send-email-ordex@autistici.org>
 <201305042042.44881.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline
In-Reply-To: <201305042042.44881.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: make the GW component
 vlan-featured
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


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2013 at 08:42:44PM +0800, Marek Lindner wrote:
> On Tuesday, April 23, 2013 22:34:32 Antonio Quartulli wrote:
> > @@ -635,7 +635,8 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb,
> > unsigned int *header_len) }
> > =20
> >  bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
> > -                           struct sk_buff *skb, struct ethhdr *ethhdr)
> > +                           struct sk_buff *skb, struct ethhdr *ethhdr,
> > +                           unsigned short vid)
>=20
> Kernel doc ?

Sorry but as written my previous email, this patch has been sent by mistake.
There is another 4/7 in the patchset which is the correct one.

I'll simply ignore this comment :)

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRhUBgAAoJEADl0hg6qKeO8DgQALHQQMizaX/dHqLcAdC/Ou1P
MSi8BP62oG09MtIqK9eEmOMn7nThlZvpg0fmMTcSHgPI9VSV5boUSHDn1BnQjkrE
JHRdFOH8ieNKymrq40dctYrHx76ySynpSvNJCKhK0+y/KA8+CQnxBhYFskiPWGya
jb7LQBgLjJEHiDnl/iHlRlGDnBYKLe2QdbL4fraqBmzyMrElFlEot+o2NKQJ1K9A
9l/bztHt9Jg7e2qhx2osWTUcdl9Ipv7237/SoJzKT9O38nqqiHPpVJ6rCNpfWilG
hK5f4ZQua7boSGzAQm4Gm/JY1qhJHHadvytslwmrnOwVFmFAUAUMU1etRH3Z0XY3
MKlnjqoGklfd6ElMi1/kul28sg+MkFGUokPoGjcr1v+pZmqSZ1eQNn1MOGVchRuF
Yc40RF3e1+BHpCy4cH0INUgkKX3SLzSP/vWfAKTiVC+LbbJwJWxuGHNlprc7JLe0
NW7hf0UNGPSfKMSXu70AL2Rmc9HGR0NSB6N47D9Brk7nCF67lFL2L9bzM2eYRhOD
LXXMLda/Vx8t2LTar+tw9HhazvmC87nRvuP/j21zWCXsBWR3uUl+dIMoQ8E+/j9u
aBPTnP7tzupPMvReQF5+AJjMofCobdHzKR0wUG+QXwA1e6ZZgrxqGZ/nVf79PEsJ
Xn+YaTpRZ6oPqbnlUnHx
=q+C9
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--
