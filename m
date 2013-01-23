Return-Path: <ordex@autistici.org>
Date: Thu, 24 Jan 2013 05:07:30 +0800
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130123210730.GA10344@ritirata.org>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <4b41fb1f387acd24ecab6e4e47b2126b6dbddb5a.1358961079.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <4b41fb1f387acd24ecab6e4e47b2126b6dbddb5a.1358961079.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: filter out invalid DAT
 entries
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


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2013 at 06:11:54 +0100, Matthias Schiffer wrote:
> Due to duplicate address detection and other strange ARP packets, sometim=
es
> entries with broadcast MAC addresses or unspecified IP addresses would ge=
t into
> the Distributed ARP Table. This patch prevents these and some other kinds=
 of
> invalid entries from getting into the DAT.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  distributed-arp-table.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index 9f4cff3..e28be57 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -274,6 +274,18 @@ static void batadv_dat_entry_add(struct batadv_priv =
*bat_priv, __be32 ip,
>  	struct batadv_dat_entry *dat_entry;
>  	int hash_added;
> =20
> +	/* filter invalid MAC addresses that are sometimes used as
> +	 * destinations of ARP replies
> +	 */
> +	if (is_zero_ether_addr(mac_addr) || is_multicast_ether_addr(mac_addr))
> +		return;
> +
> +	/* ARP requests with unspecified source address are used for
> +	 * duplicate address detection, we don't want those in the DAT either
> +	 */
> +	if (!ip)

Hi Matthias,
what about using ipv4_is_zeronet() ? Even if this is a base case, I would r=
ather
prefer to use an already implemented function.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAFESAAoJEADl0hg6qKeOsXAP/0FxJme4WXPvJsNE96SyHoiB
DzPGY8CeUw0tKDuCKCs4MNV4Myw2zy+4Ek1KN9EoBtKTtMcpxakagCViFLVOQudI
2Ff8bAwpelFKg7miof/bDRZZyf3TOeIzjF7PH5qO2qhvsUCV4Tmbaq8DTk0VKgs4
ePTC6jta0I64ynGvka91GM2W3CLPIcj2uFzC1MjOmZ8QjoeIiNpOnSjSeklHjky8
gFuzZFS+Zfk/rm3/zuN8AVQPy2Dfp5eR4KpLgrKDb5l5X250V+m3pV4/jpHIidvY
+AbAkN3qMMgdvib43Gtontcg0MskycukZQEuiBWtyZyhAZ5MH9D8Gjbor1jmbNwu
4z6IZGW055PJe18GJFqR4w0bcF7Z7Pw86bdZbHRG6OGqmNnkZnpOUHw2wpdWROGP
jbHXQXBE1lGqfFz0jaQbqXGcVEDfxB2tkKdUsaF0Aod1FptgkYMdYAN89DoZxmlo
KagukfdmO+7IMAmraJ3f0p+CmFxNJpVSfBvjFXgtQ6DDCXm7q5oku/BQAXq+/Iwd
sHY0SULhGw1wEd/berz0Z3yTBOPxh1xf2L8BY/yfzb6PunUIVXwPdaMBJ2ylMzW1
zTkvleyctqUIIuTwkMDfOpQTnUvRlyohXhMUT+8114DSKMGTCdzdMEVYgmvynD/7
u4vWD3uqzSrbKfUTe+Q+
=e1Ye
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
