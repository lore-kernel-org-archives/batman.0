Return-Path: <a@unstable.cc>
Date: Tue, 21 Jun 2016 04:24:00 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160620202400.GE10666@prodigo>
References: <1465575241-1754-1-git-send-email-sven@narfation.org>
 <1465575241-1754-2-git-send-email-sven@narfation.org>
 <20160620164115.GD10666@prodigo> <1634830.ALRq2khRYv@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o8DTQsiwS+K7TY1f"
Content-Disposition: inline
In-Reply-To: <1634830.ALRq2khRYv@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: Free tp_meter ack skb
 when it was not consumed
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--o8DTQsiwS+K7TY1f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2016 at 06:55:49PM +0200, Sven Eckelmann wrote:
> On Tuesday 21 June 2016 00:41:15 Antonio Quartulli wrote:
> [...]
> > However, how about changing the patch this way ?
> >=20
> > --- a/net/batman-adv/tp_meter.c
> > +++ b/net/batman-adv/tp_meter.c
> > @@ -1206,7 +1206,7 @@ static int batadv_tp_send_ack(struct batadv_priv =
*bat_priv, const u8 *dst,
> > =20
> >         /* send the ack */
> >         r =3D batadv_send_skb_to_orig(skb, orig_node, NULL);
> > -       if (r =3D=3D -1)
> > +       if ((r =3D=3D -1) || !dev_xmit_complete(res))
> >                 kfree_skb(skb);
>=20
> Wouldn't this cause a double free when r !=3D -1 and !dev_xmit_complete
> is true?  dev_queue_xmit would have consumed it anyway, right?
>=20
> And did you mean r and not res?

Yes, I meant 'r'. 'res' was the result of a copy/paste error. Sorry.



--=20
Antonio Quartulli

--o8DTQsiwS+K7TY1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaFDgAAoJEJ4aZjxxc6bKshUQALNjFHSi5XSYSyJD6Chy1CHV
7B5znM6AwW309Iy9HkF8u2R9OUMpTEObLR0jYN+xOXn0p3shtEDxnUzi1+wRDxaF
ROLFtkIaRQhx0VPpupSQaDt7ReJnrWf4X+Hhl+l9g2Vf6mvhXcNbhke5T6yTt9eI
5PSBf2fKpK0qQ6UXNG0ouAYOAyaNKh0SjSqqLt3+lgT7NpV1FYpZGARYsa7gmDXP
LFvPr5Q2HkOOt8sKNKUqhwwUErSydFnQufawtDRD7vdlR543IrapT0RyHHtFm5iU
C140rORgc/IdGaN/GjwPz2QQ9fNIWiGDqJIZHPPxXY3PUCOtQAe6pPDt40cI1Pux
kgkE2J/4WEjtNsZBsLWfQCwyBVlekn32hjCasKLe6htP2YJ4y7jsc8HI08ZFih1L
/2nCafcLhSHv4MqQMr9LTuVgw5IFC13mAI9m7ohgoJMmaUmsDTnQjoyD0NCP8IA7
DfuVMZYSqZg4c+4kJ6NZy2zeitQUeBOy5k13N/TqY9EHNB5oJYCuGOqDQPSS9n6d
z0PkYiSrDB1k0rietXtXFUTkiIDlCt/OZBviAuY5bLoHq8TcW2um8SBKsdRAid4l
3bZuR5bv+M5SNNzFHNYvVe2QmAU2TYkzEHc3ZRlZpQQlxZFgxCWUlsOA6iMPIDgj
k6+AiFWMdDjNREngaTAk
=14tT
-----END PGP SIGNATURE-----

--o8DTQsiwS+K7TY1f--
