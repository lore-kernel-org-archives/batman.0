Return-Path: <a@unstable.cc>
Date: Mon, 28 Mar 2016 22:59:13 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160328145913.GL5258@prodigo.lan>
References: <1457484919-3935-1-git-send-email-a@unstable.cc>
 <13752331.CEKO7ckMJS@sven-edge>
 <20160310011545.GI13448@prodigo.lan> <3060601.PWvBBNIS4A@voltaire>
 <20160328145734.GK5258@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gWRamliw218YCZO9"
Content-Disposition: inline
In-Reply-To: <20160328145734.GK5258@prodigo.lan>
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


--gWRamliw218YCZO9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2016 at 10:57:34PM +0800, Antonio Quartulli wrote:
> On Mon, Mar 28, 2016 at 10:30:12PM +0800, Marek Lindner wrote:
> > On Thursday, March 10, 2016 09:15:45 Antonio Quartulli wrote:
> > > > > - * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv con=
tainer
> > > > > + * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv co=
ntainer
> > > > >
> > > > >   * @bat_priv: the bat priv with all the soft interface informati=
on
> > > > >   * @orig: the orig_node of the ogm
> > > > >   * @flags: flags indicating the tvlv state (see
> > > > >batadv_tvlv_handler_flags)>
> > > >=20
> > > >
> > > > You've missed some (see
> > > > https://git.open-mesh.org/batman-adv.git/commit/94399934a5e050073e1=
146ecfc
> > > > 48fe58ac3551b3
> > > > for the update patch):
> > > May I resend this patch with your sign-off as well ?
> >=20
> > Is that updated patch yet to come ?
>=20
> Yes. Will land shortly.

Actually Sven took care of this already. Thanks Sven!

Cheers,



--=20
Antonio Quartulli

--gWRamliw218YCZO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+UbBAAoJENpFlCjNi1MRrIsP/ReWsueBQ+zBOt4fKIzliC/R
Em/ogEzYFpDv5p8v/TpTEdUiy8riqGqYNlvN9jzQ3a5zOKGumWWSB7Hx5I0LZZi1
HIWsuVSgWos3OA5uBJshIMcg3g/ewHDZveF6a3s2q3PnvtJ6tVmGnIxfqFb4RwCO
2RRKVvMESC50OKa5eaJcGJzfKu8Iy4WxVr8GRJT1MT9W+WeiP5G9xx1qnKbnGtlT
ZvDpiyA9n31zCubipMilOFO3jEknXULnKPFsoECYZXMXJk+zAW8c7deMzEHT+M4S
2eaeYTqpF6RZwrzb0wlOwAPz9byWjgtL4VeqjViYgKRxRdOl6sLD3oNqX3N9zzy8
QWBemanGCdeVyRlKsv4nF7DA3RMb63UfYG5ptqNVqHoDR2S6RTFPFRQmx6IyrxDh
IYE1N7QZDfWrgKARRU5aZE3PYjdhgu7Pd3zeU2uMCSFv+WP8ZxGFXZfP+KNfStAL
l3Ltd2i+VIx7XucsiXSr9HQ7c/krz5tz7H4h0AFFm6cJgLqsSzrROPkCaY82swMz
OGQw3YzKQPhRVpJzQh40adkpnbAMQkwP3UtUtG3fI5yEMQ3eHzcJhGaPGK9S/VBy
WBPipy84xkUoecT7+o6b+qJcNHplVbBqC/jgmNRUe3PWG9W7ZDspOvCtGx3VY2rY
4M8jTpOb/MsHexriWzSv
=rkvp
-----END PGP SIGNATURE-----

--gWRamliw218YCZO9--
