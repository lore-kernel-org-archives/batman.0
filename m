Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 16:54:42 +0200
References: <20100916235908.51ab3bfc@rechenknecht>
	<201009170027.16080.sven.eckelmann@gmx.de>
	<20100917144811.GA3805@shadowen.org>
In-Reply-To: <20100917144811.GA3805@shadowen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1695739.gtKk6qkd66";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009171654.45015.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: unicast fragmentation enhancements
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andy Whitcroft <apw@shadowen.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1695739.gtKk6qkd66
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andy Whitcroft wrote:
> On Fri, Sep 17, 2010 at 12:27:13AM +0200, Sven Eckelmann wrote:
> > Andreas Langer wrote:
> > > Sven, any idea why checkpatch (0.31)b do this ?
> > >=20
> > > ERROR: space prohibited after that '-' (ctx:WxW)
> > > #10: FILE: batman-adv/routing.c:1146:
> > > +	    uni_diff =3D sizeof(struct unicast_frag_packet) - hdr_len;
> >=20
> > Because... what the heck? Usually it says that you should use consistent
> > spaces around '-'. So better use spaces in patch 1 and 6 and don't remo=
ve
> > the space before hdr_len as you did now.
>=20
> Because it is wrong.  I believe that I've fixed that one up in my
> development tree.  Could you confirm it is correctly left alone with the
> version below:
>=20
> =20
> http://www.kernel.org/pub/linux/kernel/people/apw/checkpatch/checkpatch.pl
> -testing

Yes, the testing version doesn't show that behavior.

thanks,
	Sven

--nextPart1695739.gtKk6qkd66
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMk4EzAAoJEF2HCgfBJntGalAP/2v5A2ovP/nHKpyhG+6mOfih
5OD4i64MHD5JOmn6lsVtH0UChbVg1oQMUC8iOiYUwtHj3XfvWCrGxq9FzS1yTDzf
MMzVpAFrXzMbfwOsjbEgn4BVTb+bDm57dBNtrtovaf+ZzQ7vXObU6x4itbOiBvQ5
uG3gHr6+Q+5g/2ybue7vbTZjmehWE1LPwZzHWKnL0Z/JfdgBLFJAA+GwHQz8k9LS
JDDpS1hzj3SbDX1u9CFYz0KxMUp8ee57rOP7rDvjMpbwvqhYebWa3LmJEhIxlh+d
POKhOmL+7DUP2fwNXsjq1E9V/cvv+CQqQAS6F6oMBXt4tyT7q8J/DeOLAvK+Z+RO
cawtTeiB0H2op7sImQDyM3KMPHyTfbILJoB8Mxmj51WzvVu7Z9NVkOlCkkY0FbmS
n02kGd0waCy4H5+TAgAVH6iotpCsT08OnVOykx0pwoFdBLt4ZuMCyLT4fxJfa8dK
GotrVH9+E91AMtx6H1GfNXPP44ABZ940BtL2LZ9YiUYxxr5KZyy6e8316o5vXVv1
SJe9JwFzIYEZrQ8sLiRTzhOE0zfHtjsoXgyAPc1XWQGRVpV2/cEuLrbKCkTHIY27
2DwAeEaaKdNBHMpMJGxDdCdTQHULGcjj+FBGLpq4uvsp6MzbjNK1q6frDtprWX5r
e9wwuFOb4uwZPVROFY77
=Q4zF
-----END PGP SIGNATURE-----

--nextPart1695739.gtKk6qkd66--
