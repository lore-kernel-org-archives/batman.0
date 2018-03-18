Return-Path: <mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
 <2516855.xl4cPWQeEn@sven-edge>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <032705b9-b1b5-0656-cd56-8cb1791aff53@universe-factory.net>
Date: Sun, 18 Mar 2018 11:45:07 +0100
MIME-Version: 1.0
In-Reply-To: <2516855.xl4cPWQeEn@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PBOVy43GGqHO1b3UAzXp2oCWWxQW4MBYq"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: do not modify
 batadv packet header before pulling it
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
--PBOVy43GGqHO1b3UAzXp2oCWWxQW4MBYq
Content-Type: multipart/mixed; boundary="Wal8BCZtp12nilfeFlx36aHpahxa1V591";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <032705b9-b1b5-0656-cd56-8cb1791aff53@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: do not modify batadv
 packet header before pulling it
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
 <2516855.xl4cPWQeEn@sven-edge>
In-Reply-To: <2516855.xl4cPWQeEn@sven-edge>

--Wal8BCZtp12nilfeFlx36aHpahxa1V591
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/18/2018 09:15 AM, Sven Eckelmann wrote:
> On Freitag, 16. M=C3=A4rz 2018 11:29:11 CET Matthias Schiffer wrote:
>> batadv_check_unicast_ttvn() may modify the batadv header, leading to
>> checksum errors in the following processing of the packet.
>>
>> Rather than fixing up the checksum, simply pull the batadv header befo=
re
>> modifying it (and push it back in case the packet is rerouted).
>>
>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>> ---
>=20
> This patch is so invasive that it breaks the batadv_dbg_arp check which=
 you've=20
> just fixed a patch before.
>=20
> Kind regards,
> 	Sven
>=20

Yes, it's the main reason I improved the check; I should have mentioned
that in the commit message. As mentioned on IRC, batadv_dbg_arp will stil=
l
print what information is added to the DAT cache, but it can't tell which=

batadv packet type the ARP packet was encapsulated in anymore (this
information is still available through `batctl td`).

In my further cleanup patches, I plan to

* make the broadcast case match as well (pull before calling snooping
functions)
* move snooping calls to batadv_interface_rx
* remove header size argument from incoming snooping functions (will alwa=
ys
be 0)
* remove the now dead code from batadv_dbg_arp

This will improve symmetry between the incoming and outgoing snooping pat=
hs.

Matthias


--Wal8BCZtp12nilfeFlx36aHpahxa1V591--

--PBOVy43GGqHO1b3UAzXp2oCWWxQW4MBYq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlquQzMACgkQFu8/ZMsg
HZyUOBAAng00obs5vSaoZOnv+BoZbYh9qifNFIgrWVBC/w1iPpUkF4OXa36WfSNb
/zbxbzRGwU1bLg/fiPpkOfkTlz7KXqS9svV872tbZiaGJ3wldplME8Jm39A7D304
yzcpIfcCupFYA8qgIMRc2RTqGSkWLhsXeC52G8ET22U765sVp9KRKAaJnPHIoo5L
ujTwdPKVd/6eTS5WAw4hWNC88uikXdGqIaRV6ENqDsp8Y7q+3adu4DV1V7ksX26c
XH3PDInd1Ami7NczxKebOH0pqr7b4n6PchxaPbNAx0xuhror0r7mVCfx/8ac45Ak
DNNd5rCaAxuty1A0d3B3W3PhUY/1KKGQtbEvXGRfkS8McQ0cEK/EtR9SsreIESzz
Aa1bcwjMzRP4zbC996OjY6uvTib0ZB++jnwP92iZ9jDCFQmlcy6z803fsGkTPfqL
mkDEtDcrtXHF7kcbExA8/2VLHmoZI5csMMSgqNaZGqbJudVXOPZLgB4Rfzl1LnS+
4arpJVaD6vSORUxlQrVuoHzbdVhPyF2VMybPxXLkN7XX8qOaiPE80vs82cddz84r
GcqoyMKKGsJXvWoZBbglcUuv9iPP0I5qKYh5KPthIUkxkfLJ6NhXebU3FTeSgHpp
WwpO7hVoPWUn/tojFBuQzVjsOA3CdzZ/j5EJn7eWzxNq63lEjQM=
=cBBR
-----END PGP SIGNATURE-----

--PBOVy43GGqHO1b3UAzXp2oCWWxQW4MBYq--
