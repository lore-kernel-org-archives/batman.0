Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:01:20 +0200
Message-ID: <1602209.FqTUcbAN8W@bentobox>
In-Reply-To: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1745774.9bUffLMSrx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v2,
	1/2] batman-adv: Add wrapper for ARP reply creation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1745774.9bUffLMSrx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 5. Juli 2016 20:01:36 CEST Linus L=FCssing wrote:
> Removing duplicate code.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> ---
>=20
> Changes in v2:
> * Rebase to master
> * Moved skb_reset_mac_header to earlier position (to avoid calling it on
> NULL)
>=20
> Changes in RFC -> non-RFC:
>  * Added kerneldoc
>  * Added Signed-off-by
>=20
>  net/batman-adv/distributed-arp-table.c | 67
> ++++++++++++++++++++-------------- 1 file changed, 40 insertions(+), 27
> deletions(-)

Applied in 6be651ac911060ef7e0364650275b56a6af28cfd [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/6be651ac911060ef7e03646=
50275b56a6af28cfd
--nextPart1745774.9bUffLMSrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBh0gAAoJEF2HCgfBJntGI+gQAMIFDI8I8nOiB2/4FeGQiMZ+
VIPQsuKKZp4J+7Ovafq6pAhYYC/YMHhk862mJmEZNSOdxT0FcrM4xsilcFXiH/WG
HMQPmoqQO7uizhIZd/839gDNE4vyGch43RrLBWp2H7QgTk1beFxcGhjclByZ3MnC
/rxH/VWM34VNj1klEQ9GvI0Keyop71QuWGsU3Jx07g2GzSPnOZh+tVGXswDfIj6+
GwXzxxKuywqZbE8e0PQgY+xKln30xXBWHOBK7XZs3M8OoigUNB15pg7qds60F4W/
vP7gw/oIhS4ifLR+RbwMV/VDDOUK8uIV+I7CWStFtk2G5l2gnhpc49dcEr+bw/PP
6kBezdHfOWuQlR1A81lqbHUrmSAOJL5K3Vvc9/e2f3EoKcwDYsJhYVrMlKv9t8+x
BpxlrFE7YWqFrrZpCIXs9io7NpzlLaGtQjBYkGP907Yv7ir+C13zdqeLfnXd/Shx
gh6EpwJMfcM2dZkl+mBi/NnCuH/YM60eZ9t7HRb8UQrGlzyplZP1UpD+OchUXRNt
+NOmh0jQulyqzL2hlgZS5b64fyaQCLnS6fiXitmyWPAc9SGA9l6s+ZoBI62RW22Y
fzMlSAB5ZCZd0EKjImw0n0HPulw5kitNeZxu0/o5iKWpKmZxuy/aKTDv2d6L722C
ENp/dOmX7lEeXwNACHOD
=GhI3
-----END PGP SIGNATURE-----

--nextPart1745774.9bUffLMSrx--

