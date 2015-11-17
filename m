Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Nov 2015 13:00:24 +0100
Message-ID: <13532716.IlYpkySTOG@prime>
In-Reply-To: <1571436.PpFx5574Ye@voltaire>
References: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
 <1447082453-13117-2-git-send-email-sw@simonwunderlich.de>
 <1571436.PpFx5574Ye@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1909693.vO3g7lFSpO";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: purge bridge loop
	avoidance when its disabled
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1909693.vO3g7lFSpO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 17 November 2015 16:01:27 Marek Lindner wrote:
> On Monday, November 09, 2015 16:20:52 Simon Wunderlich wrote:
> > -BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NUL=
L);
> > +BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR,
> > +                    batadv_bla_status_update);
> >=20
> >  #endif
>=20
> Are we sure this is correct ? The post function is called whether or =
not
> there actually was a change in the setting. The check in
> __batadv_store_bool_attr() is this:
>=20
> ret =3D batadv_store_bool_attr(buff, count, net_dev, attr->name,
>                                      attr_store);
> if (post_func && ret)
>             post_func(net_dev);
>=20
> Let's ignore for now that ret should be changed to check for '> 0' to=
 avoid
> calling post_func() in case of an error. The return value is always n=
on-
> negative unless the input is broken. You could enable BLA while it al=
ready
> is enabled which would reset all claim tables. Is that intended ?

Its not intended, although my initial thought was that it didn't hurt t=
oo much=20
=2D the backbone gateway and claim tables would be dropped and the interf=
ace=20
would go into the "protected" state again, not allowing broadcasts for =
30 (or=20
60 seconds, if the second patch is applied).

However, since you brought up this point, I think we should really chan=
ge the=20
behaviour of batadv_store_bool_attr() and friends, only calling post_fu=
nc if=20
there really was a change. I've checked the other functions which use t=
hat,=20
and there shouldn't be any problem with that as far as I see - they do =
all=20
some changes which depend on actual changes of the respective parameter=
. The=20
other update functions are:

 * batadv_dat_status_update
 * batadv_update_min_mtu
 * batadv_post_gw_reselect
 * batadv_nc_status_update

If you agree, I'd send another patch to change the behaviour as propose=
d.

Cheers,
    Simon
--nextPart1909693.vO3g7lFSpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlZLFtgACgkQrzg/fFk7axYELwCeIsdsqaLcH5naQFjz2iPZ4EdF
nCMAoKdPk3PaGj9EnDBftJUPM7cXwNDw
=JmWj
-----END PGP SIGNATURE-----

--nextPart1909693.vO3g7lFSpO--

