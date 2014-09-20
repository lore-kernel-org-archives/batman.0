Return-Path: <antonio@meshcoding.com>
Message-ID: <541DA8B4.5000107@meshcoding.com>
Date: Sat, 20 Sep 2014 18:17:56 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1410937316-23199-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1410937316-23199-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ciJVI33EjtW65G8SLsKuTibL7ENSN4rER"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: avoid NULL
 dereferences and clarify if check
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ciJVI33EjtW65G8SLsKuTibL7ENSN4rER
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On 17/09/14 09:01, Antonio Quartulli wrote:
>  	gw_node =3D batadv_gw_node_get(bat_priv, orig_dst_node);
> -	if (!gw_node->bandwidth_down =3D=3D 0)
> +	if (!gw_node || (gw_node->bandwidth_down =3D=3D 0))

This is not the right way to fix this condition. A new patch is coming.

Cheers,

--=20
Antonio Quartulli


--ciJVI33EjtW65G8SLsKuTibL7ENSN4rER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUHai4AAoJEJgn97Bh2u9et08P/0nKhJtVQKjbUSTGZPcu9qoj
d0Nr7xHXKIhYyVwmWKptEdnJKoIEDBcZhUIFZzWXaYNY33iHwEcd1M0gRD3TMfsy
/GCGHMjjxymIKclgrE4eO/sq/S9J2WgYtgaLHO6lpZ6n8QcYnyEEspTDCWDgsoRJ
uvZhRjgfuTpxQu8G2aVun4gpQ8XuxUYeKRSpfIRwMXm/Ke86ir/CPpRaWkq9SJvO
byBtEGor/cRl2Y06OdR28Qk0/fyUWYohsBBtvEYxV1QBqIWc4bkg9WeZFRSHS8rj
9rWYSVnntG/FJcxetqiYsZu8jLq27QdfbuyK9wLbqzD4UFQpQO08yEGML2tk9TDE
0Z9TKZ1ZnPpjwJ7KGwS0A2N/gHlaY2YUdSKWU7uN3TemcrfNBoEom/ceVAhuUjYo
7bg7yelMNwhUu7C76zGiC2AtwF3FLzrFgv034T82r6ngtsxrkgdTIyJLDCKP1Pi2
1JSQrCPe7LKmpAzV+OA97k4i51nN/GaiYRlJxse8grI8/BJZOcC526IUAbV78paO
xdKazTqbEfEN4H7SkmpAD+oXe8IxO3LUNwAQNlR4ajo4vzOrzBhNaRP66QlJ8YJP
ALLj4/3BElJogl3hEpIuBgav2kQOjE554bC34hAWwk2wCxbRL08eKArxGiY1cNlA
rFTnHOfmZdeAa9V1hYrg
=gmH9
-----END PGP SIGNATURE-----

--ciJVI33EjtW65G8SLsKuTibL7ENSN4rER--
