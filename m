Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Feb 2017 11:33:31 +0100
Message-ID: <3917105.FHGCDfL2DZ@bentobox>
In-Reply-To: <20170205064550.30262-3-linus.luessing@c0d3.blue>
References: <20170205064550.30262-1-linus.luessing@c0d3.blue>
 <20170205064550.30262-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3095051.Ped0tiDpCP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 2/4] batman-adv: Store and transmit
	own neighborhood hash
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

--nextPart3095051.Ped0tiDpCP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 5. Februar 2017 07:45:48 CET Linus L=FCssing wrote:
[...]
> +       size =3D sizeof(*nhh_data);
> +       elp_buff =3D skb_put(hard_iface->bat_v.elp_skb, size);
> +       nhh_data =3D (struct batadv_tvlv_nhh_data *)elp_buff;
> +       nhh_data->min_throughput =3D htonl(0);
> +       nhh_data->max_throughput =3D htonl(U32_MAX);
> +       memset(nhh_data->neigh_hash, 0, size);

This looks to me like a buffer overflow by memset. Maybe you want to use th=
e=20
size of nhh_data->neigh_hash in this memset and not sizeof(*nhh_data).

Kind regards,
	Sven
--nextPart3095051.Ped0tiDpCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlisF3wACgkQXYcKB8Em
e0aSZw/+JcADeJJvC5KjxKquZMtMf0CLpibvBAJ2kwE27+WlsHXrJ4AvetCDH5mC
NoxTCswcX0obWlv5Lyn+2jL735VPC1rNsu4LZmzO7U9ku718HPjCn+vcCQytsGOz
6DXmLIFaIFYfhzsdbjbBZZiP6iMUMkYdCPssjYNm1oxltlKKI88zNgdfXM2VGClY
VqfhBQzfP2EtWm+5F2LkS9503R9D9bcLCBJIhMDekqMD52vQEo0oJoTep8HLdoFx
65rdig7VFpgdfocsv+RODiw3bpnlqVM1EolJynMcTft5n0Z6hJwewCUG2kZBudgu
affkN0yMPX23xFboKsL4tYDW4ACd7GAbDnw9y3OaZZhoWNglgWK/ajvg+hfh89Gf
apOq7sulwN8sSlRZK/ytNjsiufL0p3ZHWk+zL/NEsiRwIqM0vb/LlWtYHXs15a07
gvuQ0IIXIVFwQiFLM2+QK+h4Oc/b5tIT7ke57dcd/QmcFQkYw/pL4f3HjBwg585R
Ghue73vGVcSg7DWG4qzOBB5ETneKn5urcuyqnsUaDNT3keo2ZrXTU5/NMNsnQBaY
Be9BdvHrL9wZ5k+D6Xu/pJhKN0edrMFGyRUWwTwn0nt4nciXDHmfZYRAQJ6SERyb
nx1QGzhwQ1EcpTxJci7ARgRx4DwlsAaMYI0OrvK4h+WZcYs8xNw=
=29vN
-----END PGP SIGNATURE-----

--nextPart3095051.Ped0tiDpCP--

