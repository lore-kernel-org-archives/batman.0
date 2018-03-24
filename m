Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Mar 2018 10:41:42 +0100
Message-ID: <1790898.vTTmh1kdvY@sven-edge>
In-Reply-To: <20180320021327.30877-1-linus.luessing@c0d3.blue>
References: <20180320021327.30877-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5476954.Vscsdb36XS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix
 multicast-via-unicast transmission with AP isolation
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

--nextPart5476954.Vscsdb36XS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. M=E4rz 2018 03:13:27 CET Linus L=FCssing wrote:
> For multicast frames AP isolation is only supposed to be checked on
> the receiving nodes and never on the originating one.
>=20
> Furthermore, the isolation or wifi flag bits should only be intepreted
> as such for unicast and never multicast TT entries.
>=20
> By injecting flags to the multicast TT entry claimed by a single
> target node it was verified in tests that this multicast address
> becomes unreachable, leading to packet loss.
>=20
> Omitting the "src" parameter to the batadv_transtable_search() call
> successfully skipped the AP isolation check and made the target
> reachable again.
>=20
> Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for multi=
cast packets")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> ---
>=20
> This issue currently cannot appear in the wild. See explanation here:
>=20
> https://www.open-mesh.org/issues/335#note-16
>=20
> However if we were to legitimately start using these flags for
> multicast's own purposes then we would start to see issues in AP
> isolation setups. Therefore, and because the fix is tiny and "obvious",
> I think it would still make sense to send it through stable@.
> ---
>  net/batman-adv/multicast.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Applied as 67a50c93bceb [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/67a50c93bceb534937d6a18=
8eded79272ff6d55d

--nextPart5476954.Vscsdb36XS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlq2HVYACgkQXYcKB8Em
e0Y9Dw/+JcJRU+zW8HpS8CeNiuDWntqIbcLKx8wsWCSAR78hlszWgFQ2iDQxJJqs
nQyv2IyFqEQc3XCFiO3G6Yu6fFUhPqD0bKr6NLcfNjKCJBlwtwSzYn61OaWPi98+
JCwIA3VJPk+fZ8vg+a+ZKmaEO7PSjaFejV+u/Fr9jzocGgNnyUZuMegnbACfKDZ6
vnDgl5cjG7zmbP2oS7KFq+kvl8HjafqC/AEnIT/offSH3DHWLf3d5NEOl6SGu2Be
cqsJGNGEfkcAqtxqKTnAM6USxucJJ9I8zPlx7SUjIX8vZRT0rv2nJB9BhyVjxmzY
6J9G0Bo2iyIEWQV76BrnVeAQEokvoL5/i8AZFMiuWBbRHtBKhtuQ0Ro8gEo37mS0
eV3xhc9YJykikV8nCQ++F1ZfoBZj4VCYDvzhb6ZDASN3zQiXWiFMmmOFeFn9JHjV
uWTfbROjGRI2iwZjGVS0yEP3XqQ82XrwTSP7/FxxwTttXOPLbhgTD9qAJVGhNOz2
/wUM+rpGRgCy+3frFm7IPfjbOBNqbazh29DBDaj5L6qrMhOYHVxcoJbZE7z+Nb3h
kUI8DC/ONomXipyWEPM55fJWiYPCEcbohJqsQTKAkn61SswmLV2RIdNW4yRbh/av
bGwVPc19gmxDUzTU9wv30eJqVTaQ4LONED9tIWRhv2uKCiwUjWY=
=YXHN
-----END PGP SIGNATURE-----

--nextPart5476954.Vscsdb36XS--

