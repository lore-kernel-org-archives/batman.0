Return-Path: <ordex@autistici.org>
Date: Tue, 28 May 2013 09:49:21 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130528074921.GF3333@ritirata.org>
References: <1369683792-531-1-git-send-email-ordex@autistici.org>
 <1369683792-531-2-git-send-email-ordex@autistici.org>
 <201305281525.49326.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <201305281525.49326.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 01/12] batman-adv: implement
 batadv_tt_entries
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


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 03:25:49PM +0800, Marek Lindner wrote:
> On Tuesday, May 28, 2013 03:43:01 Antonio Quartulli wrote:
> > +/**
> > + * batadv_tt_entries - compute the number of entries fitting in tt_len
> > bytes + * @tt_len: available space
> > + *
> > + * Return the number of entries.
> > + */
> > +static uint16_t batadv_tt_entries(uint16_t tt_len)
> > +{
> > +       return tt_len / sizeof(struct batadv_tvlv_tt_change);
> > +}
>=20
> For the sake of consistency, wouldn't it be better to call batadv_tt_len(=
1)=20
> instead of sizeof(struct batadv_tvlv_tt_change) ?

mh..yes ok. In this way if we have to change it in the future we need to ch=
ange
one function only.



Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRpGGBAAoJEADl0hg6qKeOim8P/23Il1/F645x4cW8jkKjXUTh
qRvZdX29HKePZTfn7EmcX9ULu9vF95bw8cS6TmZZRV/8QpWzMv/wuOnLp1+VV6H5
dpNqCfYAMgpbjAF4rngeLyvR8xK1JBXuML9oFY+S5ZJ78uX1CUXK3zMF1BlPKGQj
qXPE/u18mAIFbmQ35KkdztF7GrLyOjTaMijfYlsORdCpvsc6M3qtZAcLLafUO+01
0d1N1Ee37yNilAimg46T/0WP+5hgjgxopaEPHlY0AeN87Mkzu+wzxteM1ZVlpDge
QzSmviI4Gtkg/4qHNppOFXog2D0/me5VF9fmDboUmVpusznJvwrGK2IMqglUfJyy
uj9o21AxkgQhrKxCQy67Ec5/p+xVtt/+9YGCR/bQJSuNttyC2M3Wp9ZHa2RxFGcN
DjxH2IxjGNTGzruNjvkyUI4oOjaWrXy1h3+uihUQYok7TtUVZX0BsM86UgeYoTKb
uuS+A8AOgpHG1+j1WKDxn1TbHdTNpjRGwZEA5FedCP4MLTJfk5+LPJFbOIs4UBK3
MHs35V4PuoCJVfVg7Z4tQLrMoFLh6+Ffr941J9kfgpNj+2fMf4bM824w8rpaw9oe
OHbWtWg+1M5jiifaa3gzAUzsaIiZs22s+dCFJqQQ1AwQYrIbm5MmjkuCbAeH+QiT
MPr4nhPnXcF8CTGjtDaq
=eeSb
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
