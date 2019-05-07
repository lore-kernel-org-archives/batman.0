Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2] batman-adv: Introduce no noflood mark
Date: Tue, 07 May 2019 09:30:46 +0200
Message-ID: <3693433.LtgH54LjNc@bentobox>
In-Reply-To: <20190507072821.8147-1-linus.luessing@c0d3.blue>
References: <20190507072821.8147-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21935947.6gBjiiaz1F";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart21935947.6gBjiiaz1F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 7 May 2019 09:28:21 CEST Linus L=FCssing wrote:
> This mark prevents a multicast packet being flooded through the whole
> mesh. The advantage of marking certain multicast packets via e.g.
> ebtables instead of dropping is then the following:
>=20
> This allows an administrator to let specific multicast packets pass as
> long as they are forwarded to a limited number of nodes only and are
> therefore creating no burdon to unrelated nodes.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

I still don't see why this has to be implemented in batman-adv and not as a=
n=20
external filter (tc-ebpf or something like that).

Kind regards,
	Sven

--nextPart21935947.6gBjiiaz1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzRNCYACgkQXYcKB8Em
e0aXyRAAgG9fa9pNza0iqdGh2yy61KI6EM9PyYPJof4okfcogmjtiyGIvjcoBbIF
W/IEzETTT/nAsYgBSP3iyFQm8WE3PTulW8aUauQOapHfO8ovAp/HSp4xnfEHH+J1
Abm6+NgwdaKb3E8+yX4Smq1B81DeSlV8MXsrK7LqYzbnabk4iPjk1uxdmCCAlnOO
g7D+XalBiNui5hbtloLIbkthvrCL+bqZF/Zfp73gL/t48gjT+QAkBP/A2Bk8qQ5N
mUfm5o//pEUXd3sFzREQKDgY8J1a1NVd3xkknX9VEc+e605N8YTKXyMXWkO1noNi
Fap5KKnPTOCz+5L/8oqK19aFWVQ56Eob/FKA5qkzYt6Tlfki/Ehx0WCefO3OJlys
MgeMqozB5DYw7oJYVs0H1rWrBt+yx91BByJA4ebYLIUtdtX+aKlgr9wJ6BAZBYyH
xMknmuvW7T88T6eIdUufSUVU6vSEAAx4wbgiQXsUj4miFT04KKExVVKHJfbM5juY
jtl/dlf+RW4Ixdy/C3vzddyk6eE1NcaFOhe9KrEFaVHfcA+r9W7IUdrbi4B6UFF1
X+t6+RaY+n40P0iNbLVvOlszLo2h0rq3O8t0i1yZRY/iHAvWjGZDhI6qRgL9xtPh
OPEkcn5t/08YeM0Ed4Quh3IHeKgjMnYQywbRi5b1ZsS0GFDtLSg=
=+kgl
-----END PGP SIGNATURE-----

--nextPart21935947.6gBjiiaz1F--



