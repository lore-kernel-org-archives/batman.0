Return-Path: <antonio@meshcoding.com>
Message-ID: <558AFF5E.9020109@meshcoding.com>
Date: Wed, 24 Jun 2015 21:05:02 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6hWXFTkLSsP210AMeeK6OMX5jfXxehPFm"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: initialize up/down
 values when adding a gateway
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Simon Wunderlich <simon@open-mesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6hWXFTkLSsP210AMeeK6OMX5jfXxehPFm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nice catch!

On 24/06/15 14:50, Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> Without this initialization, gateways which actually announce up/down
> bandwidth of 0/0 could be added. If these nodes get purged later, the

as clarified on IRC here Simon was referring to the orig_node purge
routine (_batadv_purge_orig()) that calls batadv_gw_node_delete().

> gw_node structure does not get removed since batadv_gw_node_delete()
> updates the gw_node with up/down bandwidth of 0/0, and the updating
> function then discards the change and does not free gw_node.
>=20

I have witnessed situations where nodes in the mesh receive GW TVLV
with bandwidth 0/0 even if it shouldn't be such. Therefore the situation
scenario described by Simon is more likely than what one might think.

I also think that we should investigate why we see this 0/0 announcement
when we should not. But this is for another thread ;)

> This results in leaking the gw_node structures, which references other
> structures: gw_node -> orig_node -> orig_node_ifinfo -> hardif. When
> removing the interface later, the open reference on the hardif may caus=
e
> hangs with the infamous "unregister_netdevice: waiting for mesh1 to
> become free. Usage count =3D 1" message.
>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Good job!

--=20
Antonio Quartulli


--6hWXFTkLSsP210AMeeK6OMX5jfXxehPFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViv9jAAoJEOb/4TMchkvfHR0QAMiV82ty+CKGHdlqfxi2vca0
pNxIUnQ8LOFdj2jaSdQEJo4UHZH3Pw4fx1r9tWLsVdZDItruhQwVCgosWcadtj08
IaPNdWfsLZ0OvqpvKxdf0B01izZMNj+jbv/aWNfQUSoYs2v3/bnVXwzCS+9blxef
67pBNAeO43jrkR0MTiwCsnYv6gW15h+vPpbxGUEiiONQCMy+w/2g+481IuaFk2Vb
yeqDraZYRxR+bi5l1b0QHVVOWONWvm40MsOzIe18jzhpJwBgfzwJjvYzYjnfnJ3z
KmPHqHQNbh1zgWVB+r9JKd0mMCTi8rm0XekP2AyILNQBaQmb7jGIleeCZJasZDOm
+q9V+odp96XQ1UdwapcIc77etrrxiREIg1aTMvSfyLSe0F9OYEGuK/HJejJtl3VO
twI0Te8GJu3s7OzxtdLP5x7ojGubGsXEmMZBsAK4kzva+osK/jurw8MdpNWjDqmF
NX4LRMHSgICU5IHUtsSE3H/6ulJFN/5pTZq/N/dHlsWAct6l2Q7rgfglwUSvabtK
wH4LKrnInAzKZPy8rirpg52mM48MfXELL/7rsSq5eOlUV6hd91TdFTmByCUN/LH6
5aDyAo+Zlp3z85eGCDsvoot4+6sCxBNY18eJ8AUduzWZ7V2MRZBWGtOOu3OzoCxq
PY8N17r1tGtVsFw/PRAw
=RIWp
-----END PGP SIGNATURE-----

--6hWXFTkLSsP210AMeeK6OMX5jfXxehPFm--
