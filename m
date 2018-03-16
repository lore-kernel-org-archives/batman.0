Return-Path: <mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <3cc8fb9bb6b983a5b7972af2fd803041095d8c90.1521196151.git.mschiffer@universe-factory.net>
 <1575600.30KXpZVktj@bentobox>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <37901fe9-d320-b181-8aa3-9213fd308307@universe-factory.net>
Date: Fri, 16 Mar 2018 16:05:39 +0100
MIME-Version: 1.0
In-Reply-To: <1575600.30KXpZVktj@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ljwfa1pXaxdaBgz80Orkjykz8C54IvqZ5"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: fix header size
 check in batadv_dbg_arp()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ljwfa1pXaxdaBgz80Orkjykz8C54IvqZ5
Content-Type: multipart/mixed; boundary="1uE6TSKnYi869Z0Lm20v7ZMqSk1bVFqnq";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <37901fe9-d320-b181-8aa3-9213fd308307@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: fix header size
 check in batadv_dbg_arp()
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <3cc8fb9bb6b983a5b7972af2fd803041095d8c90.1521196151.git.mschiffer@universe-factory.net>
 <1575600.30KXpZVktj@bentobox>
In-Reply-To: <1575600.30KXpZVktj@bentobox>

--1uE6TSKnYi869Z0Lm20v7ZMqSk1bVFqnq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/16/2018 12:31 PM, Sven Eckelmann wrote:
> On Freitag, 16. M=C3=A4rz 2018 11:29:10 CET Matthias Schiffer wrote:
>> Checking for 0 is insufficient: when an SKB without a batadv header, b=
ut
>> with a VLAN header is received, hdr_size will be 4, making the followi=
ng
>> code interpret the Ethernet header as a batadv header.
>>
>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>> ---
>=20
> Fixes: 0591c25abca9 ("batman-adv: Distributed ARP Table - add ARP parsi=
ng functions")

I think this one would be more appropriate:

Fixes: 3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan awa=
re")

>=20
> Kind regards,
> 	Sven
>=20



--1uE6TSKnYi869Z0Lm20v7ZMqSk1bVFqnq--

--Ljwfa1pXaxdaBgz80Orkjykz8C54IvqZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlqr3UMACgkQFu8/ZMsg
HZzKuRAAkqj/8imtfZQ54oRJYO6/Gu+6xWzJgBoj298DULECbTqJEvzhBlArHcqV
kkSCbgTGQdQO9RKv5YDjz6rlTzM7jsQd2tMS3X/GaYpAyL3C3pxMgASlrqjd1Ova
xYj/1Z/8osCmKWfZAFlITZPFIxrKPjd7H9GH5zoNHtw1Vp28VdhwbqzVXwFDnHjD
sMqspS7Vqn9UULEmumLS28SXB8pL2Ii/BovGNPSBORxv8NxiE2W277KO1mwqcwn4
sf5s8lCgLPzu5ejQsorHqFTqrzs3cB0BrRPh2oaHfW9wdSNdDNL54pSI/1wY52b+
PHMURpM8p4AgPLj8abNTPY4fW2GHSi1jp7LlSckUHEI0+x7i1uQBILRy70+BWxxF
VOEPRZtO7z2pxGCGqiz1nZSF2Gm5/3T3EmbWQnS87X6neb0XcJBTn17TJOvjSbBu
4SUgZACFw9Pu0ggUNMYZC0iNtlV4bZr9dldWbs17jbMpqKsNbHbBXQgHTvB3+BDH
+r1J65Og2phryBbxE2I6SsZKk+UVPKpy1ZhAjppqrLXnYK1OYt1DbBVc39+tjJcS
Fdw82b9YYXSHst/WFbNbyjhUXUqq2T2xmoj0mwyRWZXp139LWhTXiMUD23PvigIw
qNw3+WKbfH7x+a3guElD8id7EjhmOH0NjGGe6SckDisziRwvoA0=
=DD5D
-----END PGP SIGNATURE-----

--Ljwfa1pXaxdaBgz80Orkjykz8C54IvqZ5--
