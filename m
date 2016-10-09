Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 09 Oct 2016 08:25:52 +0200
Message-ID: <2564843.cfrtCYxXsO@sven-edge>
In-Reply-To: <20161009020710.GC5216@otheros>
References: <20160915135249.1925-1-sven@narfation.org>
 <20160915135249.1925-3-sven@narfation.org> <20161009020710.GC5216@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart98401976.IEZT3sIvvJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2 3/3] batman-adv: make netlink
	attributes const
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

--nextPart98401976.IEZT3sIvvJ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 9. Oktober 2016 04:07:10 CEST Linus L=FCssing wrote:
> On Thu, Sep 15, 2016 at 03:52:49PM +0200, Sven Eckelmann wrote:
> > +sed -i \
> > +	-e 's/^static const struct genl_multicast_group batadv_netlink_mcgrps=
/static struct genl_multicast_group batadv_netlink_mcgrps/' \
> > +	-e 's/^static const struct nla_policy batadv_netlink_policy/static co=
nst struct nla_policy batadv_netlink_policy/' \
>=20
> For the second thing: Replacing the string with itself?

Damn, you are right. This line can be removed anyway. So it is not
"a big problem" but ugly as hell :)

> Just wondering... I simply tried casting the const away and that
> seems to compile without a warning:
[...]
> Or does this lead to some dangerous behaviour on the compiler side?
>=20
Yes, this will crash because it is const aka read-only and the compat
code cannot write to the struct (actually, the read-only page).

Kind regards,
	Sven
--nextPart98401976.IEZT3sIvvJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX+eLwAAoJEF2HCgfBJntGoEAQAKRCmN0jP0vpdyVx1VPedbGx
I5kCniVf/cL7D6h4IDUGg2caTzdV8qOPTjLKm1LUvmBpkr/Zv2fgafXww768MOnG
14V6k7uq9c4pxKmQpCCtDhB21+0HSd+w9Xq+iRhIvNrtHi+PjIOCMcmeiBMFl8Xx
uSz2vTBtiKtjRIvKVSiSRmZXwIGpnHeydFDtZgO+SZZ3CnfLgrXgT+vfDsWhb7Ra
My3Nhh0laU+m2IyDw415tHGocYmefs7nut2rIrqTDk0Jl+fVOUve1ds09Z2lF3RY
QUB1qTFspSWX/Y1frXHI+HAmn5JsVGeaiAA3IolQO83QM7qbhQIzNFcP1NrUbCYZ
vCI0saMZNnf0zR39Ct/rLGwnoJgCfxLyrqMYFYkiFxs4iHYiB9hZoRPCQSloPIL5
0Tz/325GFNQuO9q+OG0rOJalQ5cT3l22MulTUWVwoLukZezo8o1Fg4IRqTLNgY/i
8jIkDh+lhaMKjivdKAhHUIii5/An2ecXkbpHqVZ+hrKHcLTl0HubCvsMpMGVNIJo
tnqPyhdEuk230j7sdOlmiUjSrzzXFRFu3gyZPsQUDpjghrNLOGfJUMp2+EOuzgBr
gCgJKQfBJqFkrGOz2aSXQqkcSHmWhhXyqU5uZWx7Mo8n32ZS7L+Mqc72g3d6b3/O
Bzy5z8QXSlMgTDtwviZt
=OGOO
-----END PGP SIGNATURE-----

--nextPart98401976.IEZT3sIvvJ--

