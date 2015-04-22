Return-Path: <antonio@meshcoding.com>
Message-ID: <5537064E.4000803@meshcoding.com>
Date: Wed, 22 Apr 2015 04:24:14 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <OF5389A718.644E8229-ONC1257E0D.00566F9A-C1257E0D.0056A5A0@phoenixcontact.com>
 <550AF2DD.5000707@meshcoding.com>
 <OF05EC2858.5AFC84BB-ONC1257E0D.0059D034-C1257E0D.005CE3EF@phoenixcontact.com>
In-Reply-To: <OF05EC2858.5AFC84BB-ONC1257E0D.0059D034-C1257E0D.005CE3EF@phoenixcontact.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nwSwv41xuxfCl0rnaFj1n14XB8qKBun56"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCH] batman-adv: bugfix for
 kernel crash in batadv_tt_local_table_free
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
To: APape@phoenixcontact.com
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nwSwv41xuxfCl0rnaFj1n14XB8qKBun56
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Adreas,

sorry for waiting so long before getting back to you, but this bug
slipped away of my todo list..

Anyhow, I have some questions inline:

On 19/03/15 17:54, Andreas Pape wrote:
> Hi Antonio,
>=20
> I saw the crash, but only in the case when I add the non-IP traffic

What is this non-IP traffic? Can you mention what type of traffic are
you sending?

> using VLAN ID 0.=20

Are you saying you are creating a bat0.0 ? If not, can you clarify the
meaning of VLAN ID 0 ?


Thanks!
Cheers,

--=20
Antonio Quartulli


--nwSwv41xuxfCl0rnaFj1n14XB8qKBun56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVNwZSAAoJEJgn97Bh2u9ezJ0QAI0SLdMJtxA7nOoyU8SkUMr0
4rybtixDggazM1gijFceFonh/GTwP9qcVsvSS4WKY4V+d0rXae/qtvZDYkV1kfEY
3iWPRMVjVgcimmH0RFShg8QXOxmqCqiLX8Y2mwsKT0Lg6kPpC/W9cYusWZhqPg/I
wVGHjfe+ooZAqxZX/gBLShjgec020W0btgdQCxDYXKYas2CW8viXO52cIev6j0Lw
NkCJXT6h9V/m6RPE+G1+Df66RUpOUzluY2p3j/+1M8652eRzxyz+2vKFNplYE+u3
62+sO/UCz5h4dffjh7Na94pIEG7PtvZLT4VeLFzxIhtmwHpyWlSm2hzNLpn8uElJ
6kKeDBU6GPN+cn3D068Mh8qf8RJ/WWI/8aIPfdb6h0pBRXStiGNkeCW6h9Z62qqi
8otAmJUWCNjytdBLvhMrVgK9A9FpI/jlEZpu+O1lSQ+h+yIuHQg0786lf1UI/qlh
oUT7hgshtkMh4jz8PhpDcgQnvH8lqS7Ugk66XR+Ni+3jLNqUJsSHv3pdUzqXaz6c
Dql6JvXtegpdMkWV6eZjqajd8bxjoROkVQNXGAu5k4q6J/6Cs/XVCTSyKXG12TVi
8E1Y7MzbsVXubC7Q/qEm65FHGCwxcVJxGdUp6/MBI5UlGMSUD0IcCL57oKMeVjmi
Km+xFIZjPZz2gvBFVNcu
=yaQZ
-----END PGP SIGNATURE-----

--nwSwv41xuxfCl0rnaFj1n14XB8qKBun56--
