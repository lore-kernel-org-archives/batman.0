Return-Path: <mschiffer@universe-factory.net>
Message-ID: <510148D3.1010807@universe-factory.net>
Date: Thu, 24 Jan 2013 15:44:35 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <201301242136.11695.lindner_marek@yahoo.de>
 <20130124133858.GB2507@ritirata.org>
 <201301242147.51470.lindner_marek@yahoo.de>
In-Reply-To: <201301242147.51470.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TCAKEHMGCFBQJKXAVINE"
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TCAKEHMGCFBQJKXAVINE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 01/24/2013 02:47 PM, Marek Lindner wrote:
> On Thursday, January 24, 2013 21:38:58 Antonio Quartulli wrote:
>>
>> I thought the same, but in batadv_arp_get_type() we have a general che=
ck
>> that discards wrong/bogus ARP request.
>>
>> Here instead we are filtering "correct" ARP requests that DAT should n=
ot
>> handle.
>=20
> What is the difference except for the naming ? In both cases we don't w=
ant=20
> these packets to be handled by DAT.=20
>=20
> Feel free to move these extra validation checks into a separate functio=
n that=20
> gets called from batadv_arp_get_type() if you wish to emphasize the dif=
ference=20
> between the types of checks. Having all checks in the same place will h=
elp to=20
> avoid overlooking things later (as already happened).
>=20
> Cheers,
> Marek
>=20

In my opinion, the DAT should handle the sane one of source and
destination if one of them is sane and the other is bogus. So I would
maybe rather move all the checks to batadv_dat_entry_add()? There it
will only catch the add case though, not the lookup case...

At least a check for ff:ff:ff:ff:ff:ff should be added to maint as soon
as possible, as such entries were actually overwriting correct DAT
entries on my test node (and maybe even preventing ARP resolution as the
DAT node answered with these instead of the actual addresses).

Matthias


------enig2TCAKEHMGCFBQJKXAVINE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEBSNMACgkQq3qIxbiQM9j9uwCgxACaifjlLyjH9mGCmY1W8K2s
z04AoMXlLnLub/69hoXGYNvrnQ7bplUv
=TwCZ
-----END PGP SIGNATURE-----

------enig2TCAKEHMGCFBQJKXAVINE--
