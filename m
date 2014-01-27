Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 27 Jan 2014 15:45:09 +0800
Message-ID: <21735459.pkRxIXDLhN@diderot>
In-Reply-To: <52DD3BC9.4070603@meshcoding.com>
References: <1390212404-9726-1-git-send-email-linus.luessing@web.de>
 <52DD3BC9.4070603@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1677729.su3QVinpV0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint] batman-adv: fix potential kernel
	paging error for unicast transmissions
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1677729.su3QVinpV0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 20 January 2014 16:07:53 Antonio Quartulli wrote:
> On 20/01/14 11:06, Linus L=FCssing wrote:
> > batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
> > data. If it does then our ethhdr pointer is not valid anymore in
> > batadv_send_skb_unicast(), resulting in a kernel paging error.
> >
> >=20
> >
> > Fixing this by refetching the ethhdr pointer after the potential
> > reallocation.
> >
> >=20
> >
> > Introduced by b46c60b9e1ee7a1909c542413a85875a750955d6
> > ("batman-adv: improve unicast packet (re)routing")
> >
> >=20
> >
> > Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
>=20
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 41b3872.

Thanks,
Marek

--nextPart1677729.su3QVinpV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS5g6GAAoJEFNVTo/uthzAO8IIAIBCYMa0bmboLDZndCBtF33b
EZgY/OIKvbDASM96fnf1pwUcvJuBWdlPi3GM6YfgrhWMN1JDIgKd02U+Y/q+wIku
rGxDHCZCAgAk4LXdPjTXyKVPbu1Sfuyp4PAPf8KrDbRlzHEAB/O+qZsSEKqPeE6z
C6UVBDUQOKo8bPIaZeODtPDGcAvm0eB9dbkBaC9kdaq0cti2S2rhArTHv7KhWYOb
qujbh8y4jWXyeHi+HcLoKjyCDOhEqlwnTIUWO87QrgL36DAP38HbwzsLTZoO+/bW
PyS0obboUWySNT56ZORd0+oxb+Egsg1O83vstlDSs7W5wAQZ+7V7Iu8zcyugVUI=
=61fI
-----END PGP SIGNATURE-----

--nextPart1677729.su3QVinpV0--

