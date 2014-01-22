Return-Path: <antonio@meshcoding.com>
Message-ID: <52DF6D2B.2070304@meshcoding.com>
Date: Wed, 22 Jan 2014 08:03:07 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>
In-Reply-To: <86lhy8pn5v.fsf@coulee.tdb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q0jqShQwbOouqED6n3eOqBnC9F2AnQN74"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
 computation
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
To: Russell Senior <russell@personaltelco.net>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q0jqShQwbOouqED6n3eOqBnC9F2AnQN74
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22/01/14 07:04, Russell Senior wrote:
>>>>>> "Russell" =3D=3D Russell Senior <russell@personaltelco.net> writes=
:
>=20
>>>>>> "Antonio" =3D=3D Antonio Quartulli <antonio@meshcoding.com> writes=
:
> Antonio> The current MTU computation always returns a value smaller
> Antonio> than 1500bytes even if the real interfaces have an MTU large
> Antonio> enough to compensate the batman-adv overhead.
>=20
> Antonio> Fix the computation by properly returning the highest
> Antonio> admitted value.
>=20
> Antonio> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com> ---
>=20
> Russell> This seems to fix the bat0-MTU-unnecessarily-small problem I
> Russell> observed last night and reported on the IRC channel.  I
> Russell> haven't actually passed any traffic over it yet, but the
> Russell> interface is up with the expected MTU value with the patch.
>=20
> Antonio> This patch is missing a Reported-by clause because I did not
> Antonio> have "russell"'s email address at hand.
>=20
> Russell> Reported-by: Russell Senior <russell@personaltelco.net>
>=20
> Followup, as requested, I tried setting a smaller MTU (1400) on the
> adhoc0 interface.  When fragmentation was enabled, this resulted in no
> change to MTU (still 1500) for bat0.  When I disabled fragmentation,
> the bat0 MTU dropped, as expected, to 1368.  Interestingly, the MTU on
> the bridge that bat0 was a member of remained 1500 despite the lower
> bat0 MTU.  Should that be?
>=20

I don't really know how the bridge code behaves. As far as I remember it
should adapt to the smallest MTU.

But thanks for testing! This shows that the patch is working fine ;)


--=20
Antonio Quartulli


--q0jqShQwbOouqED6n3eOqBnC9F2AnQN74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS320wAAoJEEKTMo6mOh1V7+QP/jOOtbgu6Rz5OJl/l5WT9ZoW
a9ZEOpzvQa3sY+zX6rdS1Fg5vtlmjtdGBR9XRkzrJLOrumuOMcCzcNZiMmeFf6v8
c9HqdXLDY54GZKQFbQAhq4n9/Diuug2Aw83WcrkBqTQuay9YKQFHaCHL/vhoGSej
BlGTqJHZPCfcHGVvWTXnXbp/scOY7GCgmXnjRNs7KFPls6MqRiPS+ZW4HTJeCBmX
BqfwbEtKM2S2aGrapjfrjfYEN7nUS99XpV3PJUSkOZrHTx3cFnoX8SYGovqYJ3d0
xg57EZkX8ByzuWZLMNi6LEtEQ8Tr6epHI6X+0/tYVsK0krEwNbVTJKl5TmWc8WsT
VKiVrU2n+BGOwO6ZZLoFk0/ap/FUjhA1Hzp/LX41HuHbZ+zTUbFymrTZgS9DOvdR
DsXj4mBuW8ySAyThol+zkZ/y3IzKoF/9vmoimZ5Wn5UEhR8BEcpdqdahslBYWB9D
zEJ0WNLQh+vgDpmRGEKI4F/HgqOata8PyQFKock6NThriNBTeG9JE9THFTpZ5/fE
VEC8DLoI9YOlbLSbMNp7oB/4zmSwfaBbstqRzx0Oqf0De9bgBsxWrqcD+Gmm4Bki
Jv8UIguMxyh8tNCNep5MWIQLwu6ZrNbSa1nJduEKHWIs2c28uTTLawFFxAlvqVze
x/cosXSu+bv2AIJ50z9J
=HNTc
-----END PGP SIGNATURE-----

--q0jqShQwbOouqED6n3eOqBnC9F2AnQN74--
