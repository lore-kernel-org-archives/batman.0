Return-Path: <a@unstable.cc>
Date: Mon, 28 Mar 2016 22:57:34 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160328145734.GK5258@prodigo.lan>
References: <1457484919-3935-1-git-send-email-a@unstable.cc>
 <13752331.CEKO7ckMJS@sven-edge>
 <20160310011545.GI13448@prodigo.lan> <3060601.PWvBBNIS4A@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="I4g3zIzscEHdx6fd"
Content-Disposition: inline
In-Reply-To: <3060601.PWvBBNIS4A@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typ0 in kerneldoc
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--I4g3zIzscEHdx6fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2016 at 10:30:12PM +0800, Marek Lindner wrote:
> On Thursday, March 10, 2016 09:15:45 Antonio Quartulli wrote:
> > > > - * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv conta=
iner
> > > > + * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv cont=
ainer
> > > >
> > > >   * @bat_priv: the bat priv with all the soft interface information
> > > >   * @orig: the orig_node of the ogm
> > > >   * @flags: flags indicating the tvlv state (see
> > > >batadv_tvlv_handler_flags)>
> > >=20
> > >
> > > You've missed some (see
> > > https://git.open-mesh.org/batman-adv.git/commit/94399934a5e050073e114=
6ecfc
> > > 48fe58ac3551b3
> > > for the update patch):
> > May I resend this patch with your sign-off as well ?
>=20
> Is that updated patch yet to come ?

Yes. Will land shortly.

Cheers,


--=20
Antonio Quartulli

--I4g3zIzscEHdx6fd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+UZeAAoJENpFlCjNi1MRqysQAKqynOyzPWmDOFKdJQYCAlz9
hY4Fo7/Yqt3xiqHuErP7WROaUZH7D/v3zZ0ztRQI8QSNw96GJegQIn52/8InLqFH
NZPE0v779yuwd7Ht1QsBt9h0eE9fQmWhw7GWOVEWVXqbtopDmKiopsYErvo5uDP0
NZ0F4dMA5xVZ4Qy/snRwWn4nUVO98+/QeBBmq+Igp/nhACAD4bkX1Rf4JybN8CmW
ZWuAUSLXuWM6j7BW42l5EWe5Jbzc8YLwNByDTNFPiqXQkr/KKNrMD3h2yBMtWAkz
JvDmv/4OJ+jibmK0begN3MNnFQNrQ1Hi4bgld0HlNpwdAB99E4kXxPFmEpZ+DZly
xGZ97JvveoRNYLy8quAt+asBX1b18EA40xvKhkVUIwhd6DlMj8I/5p2axd2e69MB
AigswEDEX1G2jHIcIB/te+0VdBSdhRZHOHmvGT31kzsO6Jn0RTz6TDRgxtn4uOEg
ZZtVgQRzHfAKbBQxspKPYNdBSZ/MimJXIFYR5wCbYwWabC5hGNg35YtK4z3nXqBk
FeUuiosF5EfbAk3o4wH2R+yYUyPgT1IKDVyIMztSZbURE6b5jvguW2IUELffzTja
MzLqwQFRKsQofeIo6gbgFFozB0V0Sq4GWATEu+QT7p4a167B9U0+ywgKsUBfYLBo
SgdxnWbuX247Q9/n+65E
=W1Oc
-----END PGP SIGNATURE-----

--I4g3zIzscEHdx6fd--
