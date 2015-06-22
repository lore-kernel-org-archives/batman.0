Return-Path: <antonio@meshcoding.com>
Message-ID: <5588386B.50604@meshcoding.com>
Date: Mon, 22 Jun 2015 18:31:39 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434904911-12504-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434904911-12504-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7jI740NgF5L7qPnhpi8A8mko0093p3cOR"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: protect tt request
 from double deletion
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7jI740NgF5L7qPnhpi8A8mko0093p3cOR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/06/15 18:41, Marek Lindner wrote:
> The list_del() calls were changed to list_del_init() to prevent
> an accidental double deletion in batadv_tt_req_node_new().
>=20
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--7jI740NgF5L7qPnhpi8A8mko0093p3cOR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViDhwAAoJEOb/4TMchkvfR3EQALgxOuAbbRbB6UygBnaN9efy
B+tDWzFV9tSG+jDtoeIKbgIVLKYrnTdMC92cYCYfjmAPNJ8/nqmWO8z2UbKtOlXF
NL3qIbqWcTpnXsj/8ghaQHW4dMFVTJDyyNWLqI0/fz/cpgd8G2eOeGoG6Q8iubuI
3TsiSVibIp0hFXieg8Q8Sq8wilAbhfC0mzdzC21d7gYju4O9sbPC+eElQ1xqlOlW
rvuafwKy5Pkic7mlpKZkg9Tyc1MsfVmy2918VTaBpCQAtrVOwEux8XEPRozjLz7X
HG51Yv4b8U0i/RLyghCP6eZpHMwspoBRyFQwnGaweZ/+STHJywx265N3Ss8rv6xg
+8Nvi2lZChX8CM9YfzmyQoLOdlZ+ZmkqsrI4IJ1bMudh2hJzOhZ0u/pcAHuFtkjA
CYTwxCe5FeF/e8XJFI/VXW9WODizZzdgcH5hCZWmU4FjIsw+5w2JdD/RF9yteYW9
3WOuA19R+8FOuY2XI4/I9m6tBGsLmEHR/A9nyFgy86Bxsv+MUvj60+LA6V2dvoZQ
N+CM5xGkQY/cKXVg8ewaYyAQ4JSGDNmaGT3Nb0bhlvaJmthJH2+it1uu+pFOvfkg
clVOwhrTdXVgfiz7x2M8kjuhG81rijxiB1vYmF9CpLJD2ouacI4z7L61r7ED3LY4
obxvrV0y2rpoowPHdHOl
=9uur
-----END PGP SIGNATURE-----

--7jI740NgF5L7qPnhpi8A8mko0093p3cOR--
