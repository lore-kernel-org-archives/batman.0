Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Jun 2016 11:29:56 +0200
Message-ID: <1676448.D8Bl5rBhMj@sven-edge>
In-Reply-To: <B82DBCAC-EC21-4486-B498-97FF1CC89BEC@vfn-nrw.de>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1889511.W6T9spajgp@sven-edge>
 <B82DBCAC-EC21-4486-B498-97FF1CC89BEC@vfn-nrw.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2683646.txOpWsuZOd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
	snooping received ip traffic
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
Cc: Ruben Wisniewski <ruben@vfn-nrw.de>

--nextPart2683646.txOpWsuZOd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 26 June 2016 10:54:18 Ruben Wisniewski wrote:
> 
> Are new clients (Mac) not already spread as info on the network? So
> couldn't we not just snoop dhcp traffic on gateways and spread the
> info about acknowledged IPs as well?

Just a small info in case somebody wants to work on it:

batman-adv in gw server mode would only handle the DHCP replies
(ACK, OFFER, ...) only when they are sent as broadcast. But it is a
lot more efficient when the DHCPd sents replies as unicast packet.

Kind regards,
	Sven
--nextPart2683646.txOpWsuZOd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXb6CUAAoJEF2HCgfBJntGiScP/0JwQl/E3a/CRbzVGWSL6WQ0
W7dKuC9gkcsH3lQWtGQEeZK5S0OB9r8TVC5E5tklIo1eU9oUEWXmdQx8Go5eflNy
Lcxk5mL3J26eRlIlIfvZBdDO5rEcpYz+honGLLQYvNJIltfX9da7zHACFrdAGRtr
ubqMkUZ8xnXI2xv7PUEEtN8uWQoJE5OzQLSTwqUFBgxrlYVVAnjTtSP4T85O2BVj
Yfpi93GAZjTRfDET4ipfg5rIdLthkvfMSoL4q0NQ8GHVuSlpJ2sPHly9j+uPoCU4
sa9ASQxusR7yq0ZiTJ5LPJ8YTB12a+aGn/Uflf2LfWoaJ6xx2U0uq8rUilZ6R7P2
wsNk8kdrT+5pGPQi9AgJHhJLRVtlAIWo0Ug5h5xcJEV02OI7wEcZaUyBfkjILYa0
hKYobhBbQ/yQ9XwMtUwVW43URYE0m7NCMtMUZuT2TM0FgaAc20a/1mTKy7IF9aX5
STKD0IlkJZ5TOhOBqyF6u/Cw5I5K9TAZre8bcD1GCowOd47DbrVxm5+BFIxa/i0S
tVmi966iZCMo+H1FKRzlsMo8V7W9qhe3oxcz9xWXC6qRaRIucwGIiR/2BmQgTFWD
1NPuKbCLtViXniAcLALTSf4sPj3D7Zg6meDsPozUHwPIclK5ptenv8fNJPAYQoIB
qvs5Kt29OaHV1aTm5ZuF
=ALuq
-----END PGP SIGNATURE-----

--nextPart2683646.txOpWsuZOd--

