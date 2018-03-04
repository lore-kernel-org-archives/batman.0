Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 13:47:45 +0100
Message-ID: <17302272.4pDdH2vvSt@sven-edge>
In-Reply-To: <20180304120817.4852-1-linus.luessing@c0d3.blue>
References: <20180304120817.4852-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2186969.cJECcxgDMm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v3] batman-adv: Fix multicast
 packet loss with a single WANT_ALL_IPV4/6 flag
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

--nextPart2186969.cJECcxgDMm
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 4. M=E4rz 2018 13:08:17 CET Linus L=FCssing wrote:
> As the kernel doc describes too the code is supposed to skip adding
> multicast TT entries if both the WANT_ALL_IPV4 and WANT_ALL_IPV6 flags
> are present.
>=20
> Unfortunately, the current code even skips adding multicast TT entries
> if only either the WANT_ALL_IPV4 or WANT_ALL_IPV6 is present.
>=20
> This could lead to IPv6 multicast packet loss if only an IGMP but not an
> MLD querier is present for instance or vice versa.
>=20
> Fixes: 391b59cdb111 ("batman-adv: Add multicast optimization support for =
bridged setups")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied in edba00d56efb [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/edba00d56efb1d55cdd4095=
7e010fba80580b5e2
--nextPart2186969.cJECcxgDMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqb6vEACgkQXYcKB8Em
e0ZHcg/+Kc8Q/7GMlZE+m9hTrU70/gkSUr2P0JnwuLToPZUFwSJ/YcyjoKVOlE8n
YcVovFOg/COyWC83KLxzQ6715eQoj7JC7oyxrS/TG3PE4AbQH8ULiW3/soHGRhS0
V+fJ3TxJ0ryPRJpbUOXudQBvIEoHZ616cBO4VKct6j67/UivH//NODJW8hqCPsl4
OLo2dHiHCLiUKsXsEi9n+LRSNk0efRBx4Lvpu35g97XiwLH4TwT03+1aFKmGdq9N
xf85XS+AWQUR7MJPO7U77jj8z9QHewGPxoWf+WdFnVIDJ7TsdMoHrXGZXoXoF7a3
g2KJ3dQveU8MoqJFTkswUCDyeqPj9jAot9zXbreHrhwdKIroQjsfVvN1avMofp0y
L51q/AJcxAFHhL1rdRYNpav/epMLHINAbxe6zEAI+2hgi0ygUEFdfcOmNMM2S8gF
YSZOJjdrYyQppIE25N49TQBIWqKuYOCSjnIMaCD/dQWxeI53STpjsudDLFRrLAI2
R1d29usnmMVIQ566lp8Z/I97t95a58UCOge1zq8B8v24oOjH7k1re4srpxhegwEu
rHs5h0mpxj0/nqYc/vcvsZs2qT7AD5PzBZnApHXZkWO7WpwueXw4zjpXLHAE1Mgb
TUQdtBJNEfKISRmfh9CnOx71n2c7MS1tk4jcucvyumA50tFgB9g=
=erpv
-----END PGP SIGNATURE-----

--nextPart2186969.cJECcxgDMm--

