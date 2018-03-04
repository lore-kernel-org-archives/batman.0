Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 18:34:27 +0100
Message-ID: <2479551.zDrGEAAfck@sven-edge>
In-Reply-To: <3744465.nJcBpx8pQg@sven-edge>
References: <20180227081016.13122-1-linus.luessing@c0d3.blue>
 <3744465.nJcBpx8pQg@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2391846.OdKlY8ig8n";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add DAT cache netlink
 support
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

--nextPart2391846.OdKlY8ig8n
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 4. M=E4rz 2018 17:41:26 CET Sven Eckelmann wrote:
> On Dienstag, 27. Februar 2018 09:10:15 CET Linus L=FCssing wrote:
> > +       if (nla_put_u32(msg, BATADV_ATTR_DC_ADDRESS, ip) ||
> > +           nla_put(msg, BATADV_ATTR_DC_HWADDRESS, ETH_ALEN,
> > +                   dat_entry->mac_addr) ||
> > +           nla_put_u16(msg, BATADV_ATTR_DC_VID, dat_entry->vid) ||
> > +           nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
> > +               genlmsg_cancel(msg, hdr);
> > +               return -EMSGSIZE;
>=20
> Just found that there is a function to send IPv4 addresses=20
> (BATADV_ATTR_DC_ADDRESS) to userspace: nla_put_in_addr. It requires that =
you=20
> provide the IPv4 address in __be32 format and not in host format.  It is =
maybe=20
> a good idea to use it and keep it more consistent with the rest of the ke=
rnel.=20

Btw. this function was introduced with linux-4.1 [1] and older kernels will=
=20
need compat code for it.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D930345ea630405aa6e6f42efcb149c3f360a6b67
--nextPart2391846.OdKlY8ig8n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqcLiMACgkQXYcKB8Em
e0aMqw/9Gld4jk3Hx9OWFbgiBQdJTJu5j2lVj+b6AfNh6vgxq7gT5Z5+NIcvMNAm
4ITRFh2ZyD2EpcXRM1+jqD63JCby1dWcYsbWtXBlEz4H+dpBozjkKmVcDStp8Imr
koHdkJpVhSgMKiB+l+a1en3QACHvr1RtQbgqxi2dUoyhBdOgRIwqsjIao9qvvPsA
3GE4fH+a/o3gic6A+CDMYheYom3DSRx5n2iwi4prWLKu/sEw5bPIFSUI0s+jzveW
1ELCUzqLPOKACxF+YM2IlkfEQsknIQpLPuah0i3VnfvrqF/MnXVaQuIY5mRmmmO4
ItENvfxlZl4zMMrddACxRJz/pXWxm81rnFoenMCUzSuhI1Hi8f7Ga0DhaoyceV6g
0xfSU0ySMh9TbxTlJG+pXxLiI0vmJk6cV3z+GI3uspYB7LCMTkclNSAlVYjDWwku
QhW+uHOtA1KOLbAv3uodSpf0U5rfEfpva9av+iY5y/tgnnN5AYqGwfK2hRi7rgfX
C5F5vx/1mh+C8xCkAhasknP0INhbtc0lP7FWj4Q/HN2efIRmPmPLGp+BfbBEJ3/l
hHbuVdP2PbU7tgtwtXomx69cE+Hhl2VOma5s6k6g/nasxRYrVG7j0krFuP+WM3if
TrESnGJKBKeynU8I5iAC70KwbdX0pn9mbfJzDhqOFvhyRWVWLrQ=
=l4Ad
-----END PGP SIGNATURE-----

--nextPart2391846.OdKlY8ig8n--

