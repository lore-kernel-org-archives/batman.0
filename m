Return-Path: <mschiffer@universe-factory.net>
Message-ID: <51005B89.6050506@universe-factory.net>
Date: Wed, 23 Jan 2013 22:52:09 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <4b41fb1f387acd24ecab6e4e47b2126b6dbddb5a.1358961079.git.mschiffer@universe-factory.net>
 <20130123210730.GA10344@ritirata.org> <51005884.7090106@universe-factory.net>
In-Reply-To: <51005884.7090106@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2SPRQLFHGRLQCUVLUGLHC"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2SPRQLFHGRLQCUVLUGLHC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2013 10:39 PM, Matthias Schiffer wrote:
> ipv4_is_zeronet() checks if the first byte of the address is zero, to m=
y
> knowledge there is no special funtion for checking for the unspecified
> address, as the case is trivial and independent of byte ordering.
>=20
> It might make sense though to check for different types of addresses
> that are invalid for ARP (zeronet, loopback, multicast, etc.), but I
> wanted to keep the patch as simple as possible. If you think these
> should be filtered as well, I'll prepare a v2.
>=20
> Matthias

Oh, I shouldn't top post. Well, continuing here now...

I just noticed that batadv_arp_get_type() already checks for loopback
and multicast addresses, so adding ipv4_is_zeronet() should be enough.
I'd keep that in batadv_dat_entry_add() though as the source of ARP
replies with 0.0.0.0 destination is still valid and can be should to the
DAT.

Matthias


>=20
>=20
> On 01/23/2013 10:07 PM, Antonio Quartulli wrote:
>> On Wed, Jan 23, 2013 at 06:11:54 +0100, Matthias Schiffer wrote:
>>> Due to duplicate address detection and other strange ARP packets, som=
etimes
>>> entries with broadcast MAC addresses or unspecified IP addresses woul=
d get into
>>> the Distributed ARP Table. This patch prevents these and some other k=
inds of
>>> invalid entries from getting into the DAT.
>>>
>>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>>> ---
>>>  distributed-arp-table.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
>>> index 9f4cff3..e28be57 100644
>>> --- a/distributed-arp-table.c
>>> +++ b/distributed-arp-table.c
>>> @@ -274,6 +274,18 @@ static void batadv_dat_entry_add(struct batadv_p=
riv *bat_priv, __be32 ip,
>>>  	struct batadv_dat_entry *dat_entry;
>>>  	int hash_added;
>>> =20
>>> +	/* filter invalid MAC addresses that are sometimes used as
>>> +	 * destinations of ARP replies
>>> +	 */
>>> +	if (is_zero_ether_addr(mac_addr) || is_multicast_ether_addr(mac_add=
r))
>>> +		return;
>>> +
>>> +	/* ARP requests with unspecified source address are used for
>>> +	 * duplicate address detection, we don't want those in the DAT eith=
er
>>> +	 */
>>> +	if (!ip)
>>
>> Hi Matthias,
>> what about using ipv4_is_zeronet() ? Even if this is a base case, I wo=
uld rather
>> prefer to use an already implemented function.
>>
>> Cheers,
>>
>=20
>=20



------enig2SPRQLFHGRLQCUVLUGLHC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEAW4kACgkQq3qIxbiQM9iZWACgsXH9AN8dbeNkklLA2HXHhsH4
rqYAoIyzZmoSw79rnTIO2WGVFRc0HCnu
=4DqU
-----END PGP SIGNATURE-----

------enig2SPRQLFHGRLQCUVLUGLHC--
