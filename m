Return-Path: <antonio@meshcoding.com>
Message-ID: <54D5D3C9.1090502@meshcoding.com>
Date: Sat, 07 Feb 2015 09:58:49 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1423153373-17033-1-git-send-email-sven@narfation.org>
 <2688831.HMc8mZG1gy@bentobox> <54D4BF9C.5010409@meshcoding.com>
 <54743686.1YRlhzGWHK@sven-edge>
In-Reply-To: <54743686.1YRlhzGWHK@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eG6NX3wwVMr20HOwgdh31SqigEouxR7nd"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use safer default config for
 optional features
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
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eG6NX3wwVMr20HOwgdh31SqigEouxR7nd
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/02/15 08:27, Sven Eckelmann wrote:
> On Friday 06 February 2015 14:20:28 Antonio Quartulli wrote:
>> To me this looks like the caching effect of DAT: bat0 is likely to
>> change MAC address everytime you recreate the interface (unless you
>> statically assign the MAC) therefore I presume that the other node (th=
e
>> one which did not reboot) was still caching the old bat0 MAC address
>> (each entry requires some minutes before being invalidated/refreshed).=

>=20
> Thanks for the explanation.
>=20
> So you are basically saying that DAT cannot detect when some nodes foun=
d a=20
> conflict in their ARP table (when receiving IP packets with a different=
 MAC=20
> for an IP or similar things)?=20

Right.
Well, the scenario "incoming packets altering the local ARP table and
generating a conflict" was never really considered.

> And there is also the problem when no local=20
> information is stored and only a conflict with some data data on anothe=
r=20
> unrelated node is happened.

I haven't really understood this issue.

>=20
> The first conflict (the conflict in the local ARP table) is not detecte=
d=20
> because David wanted that batman-adv isn't accessing the ARP table?

Even without reading the the ARP table we could "detect the conflict" by
checking incoming packets and by matching their IP/MAC couple with what
we have in DAT...At the moment we only assume that the IP/MAC couple is
stable enough and that in the worst case the user will wait for the
cache to get invalidated.


Still, I think this is an optimization that we may want to implement,
but not a real issue that pushes us to disable DAT by default.

>=20
>> This means that any communication willing to contact the rebooted node=

>> was targetting the old address and therefore the two were not be able
>> talk until the cache was refreshed.
>>
>> Can this be the case?
>=20
> Yes, unfortunately I hadn't the time to analyze it further and have no =
logs of=20
> any similar problem. Thats why I cannot check if this is contradicted b=
y=20
> anything I've done (or not done). So it is a very plausible scenario wh=
ich=20
> you've described.

No problem, I just wanted to get your feeling/feedback about that :)


Thanks a lot.

Cheers,

--=20
Antonio Quartulli


--eG6NX3wwVMr20HOwgdh31SqigEouxR7nd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU1dPNAAoJEJgn97Bh2u9e8eAP/jQFi37QQNLlzTfbOVAK+nUI
cRusrcQ27GyaPaQDVwaR87AKr1g0Wcv3B7oAuF906ctFiZfPqRrWNMHhzAkZKTre
7vjOEjKU1d+6e5scA3LUSP66bsj2FbobY78gWUZ51ZUW1MxWOgiIwexWOqnaIC35
McHf+Av8cUw5pSTZtB5i+O2JLFlk7D1hSb3XsqzAOTW+j79s4KjwCLPI+3Cmje9s
jwB/typoVQ3yYl/wJQfn57bQTP+H8RUsYb2nkfZeltmd9GGiOzh8vS+9s3a1CQeH
/psv3ZvNy0bI6WWlEdG1+xrVTsoIDnCjqf2FGAFCiIlYU/jSktAy9cq263cutSH3
fFjI/fu9enj983iRemFwqfqPtuBE9IvjbrWPSdbuWCJ6VfICIeOlEImNCWWkF3oQ
fV2BFmBYLFFcX2jlNCmE46dnDNo0GQ+1bShHBei70h9aEhrE21Zc7ZKD6nmBlpbj
mmY/ojY3uONyeyZPkAHuNjAyKTR9bzBAHSVvVkWX6FDdJ1idmueqoFICs7odFjZJ
CGZGAUkWjgmLc4+Lk27RNY4grYJwsqqokhGCPAfBC/zyDaz+PQQA23SNUUT63rKR
srCaiZacGXEPGTWVMkwLezetuQBPcUTQHKCRkL2UbZm1nsoEkCrBS/7YrYcpN36+
nK2HKSAQC4tpDyVmO79K
=LJQU
-----END PGP SIGNATURE-----

--eG6NX3wwVMr20HOwgdh31SqigEouxR7nd--
