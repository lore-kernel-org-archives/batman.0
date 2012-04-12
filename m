Return-Path: <k@jst.sm>
Message-ID: <4F86F6BF.60406@jst.sm>
Date: Thu, 12 Apr 2012 17:37:35 +0200
From: Jernej Kos <k@jst.sm>
MIME-Version: 1.0
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
In-Reply-To: <CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------enigB96FB390AA62A1E312F5342F"
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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
To: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Cc: Mitar <mitar@tnode.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB96FB390AA62A1E312F5342F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello!

On 04/12/2012 05:17 PM, Gioacchino Mazzurco wrote:
> You need a routing protocol between the gateways to do that, Batman cre=
ates

Wouldn't just need something like an announce mechanism so each node
would add an L3 route to the gateway announcing the said prefix?

Since from layer 3, the batman mesh looks just like a big LAN, any node
could simply add a route saying "prefix A via gateway B dev bat0" where
B is a mesh node known to batman via its L2 identifier, no?

Jernej


--------------enigB96FB390AA62A1E312F5342F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREIAAYFAk+G9r8ACgkQ/vhzUdYyylu/bwEAqbTOp2E7U89AgbNOwS/mm54a
WJE4DXRZSx7QnqXB/2wBALIaP399nqE5jtYVTkUKFI+ie9o19iRZXuDvhuBsOEPV
=BElc
-----END PGP SIGNATURE-----

--------------enigB96FB390AA62A1E312F5342F--
