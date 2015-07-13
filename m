Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 14 Jul 2015 00:50:27 +0800
Message-ID: <4189875.r5OON8DARS@voltaire>
In-Reply-To: <3846505.HTcyTpK9ms@voltaire>
References: <1435317085-31015-1-git-send-email-sw@simonwunderlich.de>
 <3846505.HTcyTpK9ms@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2060356.qTF6V78Ern";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: remove obsolete deleted
	attribute for gateway node
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart2060356.qTF6V78Ern
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tuesday, July 14, 2015 00:05:22 Marek Lindner wrote:
> >               curr_gw =3D batadv_gw_get_selected_gw_node(bat_priv);=

> >               if (gw_node =3D=3D curr_gw)
> >                       batadv_gw_reselect(bat_priv);
> >
> > +
> > +             if (curr_gw)
> > +                     batadv_gw_node_free_ref(curr_gw);
> >
> >       }
> >=20
> >
> >  out:
> > -     if (curr_gw)
> > -             batadv_gw_node_free_ref(curr_gw);
> >
> >       if (gw_node)
> >               batadv_gw_node_free_ref(gw_node);
> >  }
>=20
> After the batadv_gw_node_free_ref() 'bat_priv->gw.curr_gw' points to =
random=20
> memory ...

I stand corrected. bat_priv->gw.curr_gw has its own refcounter to prote=
ct it=20
from=20accidental deletion.

Cheers,
Marek

--nextPart2060356.qTF6V78Ern
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVo+xbAAoJEFNVTo/uthzAgOsIAKEOrGsqq4/d+kuY6V6cCDst
zVX00+5J/o0SX2jprTu2340LH7xAYRS5J815u5NX/OvzHGiExxV0bpGjBwKO/uaF
4lM7x+hfl6jENLcWNhP+lMrhTuSkA+pGenr+4DkVC13NV1L9+X8gMEHjf27mAET2
TT1Uz441uhiIx6fl/h6O8Y1GVCW/35mhUw5a3W4raJtrFnnFy/kFm3UJuux33n7I
G+hLXX8QaFqBaqKEsoQzZ6aUdVqDiRzQYK2KQGOxD1g8KzVE8mRlqneQ+c46o+Vl
WKBdR6gsupE2Ud7susbqP4IhP9nG34VE/T9vNv2Edfjw4YxxwrUNxwpuWXW5Wr0=
=zI1o
-----END PGP SIGNATURE-----

--nextPart2060356.qTF6V78Ern--

