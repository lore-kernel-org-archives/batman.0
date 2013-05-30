Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 30 May 2013 21:59:51 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130530195951.GA1788@pandem0nium>
References: <51A68F85.8@wirelesspt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <51A68F85.8@wirelesspt.net>
Subject: Re: [B.A.T.M.A.N.] alfred and ipv6
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 07:30:13PM -0400, cmsv wrote:
> As i am about to try out alfred i already face myself with a couple issue=
s:
>=20
> http://www.open-mesh.org/projects/open-mesh/wiki/Alfred
> http://git.open-mesh.org/alfred.git/blob_plain/refs/heads/master:/README
>=20
> I the past i had removed ipv6 support since i do not need it and it
> helps trimming up the final image. (most routers and people still use 4
> mb flash)
>=20
> I would like to use alfred and would also like to know if compiling the
> image with
> <*> kmod-ipv6................................................... IPv6
> support
>=20
> Leaving out :
> [ ] ping6
> [ ] Enable IPv6 support
> [ ] Enable IPv6 support in packages
>=20
> will allow Alfred to work as intended. As anyone tested?

You will only need basic support for alfred. I don't know if "Enable IPv6 s=
upport"
is mandatory or not. alfred relies on link local addresses configured on yo=
ur
interface.
>=20
> Another problem with using ipv6 is the final image size.
> kmod-ipv6_3.3.8-1_ar71xx.ipk  is at least 138K
> An that is quite a bit ...

You can disable IPv4 in return. :D

Just kidding ... but IPv6 will become more popular, we can't deny it foreve=
r.
Anyway, alfred is built on top of IPv6 link local multicast and there is no
plan to change that.

>=20
> What are exactly the reasons why alfred does not use ipv4 ?

We wanted to have alfred working without requiring user configuration of the
interface (IP addresses etc). This left the choice to use either another
Ethertype and special Ethernet frames, or IPv6 multicast. As we did not want
to add more custom Ethernet types (some switches don't like that, and alfred
is payload traffic and does not just stays in the Ad-Hoc WLAN), and IPv6=20
allows longer messages due to built-in fragmentation, we decided to go for
IPv6.

Cheers,
	Simon



--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGnr7cACgkQrzg/fFk7axY5AgCgyVF7DZDDqsmfO5uPyI0QfBAF
lWYAoJye8rlaz5FbsH6a+RIs0wmnvKNO
=hfxm
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
