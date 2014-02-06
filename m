Return-Path: <antonio@meshcoding.com>
Message-ID: <52F3831F.3080203@meshcoding.com>
Date: Thu, 06 Feb 2014 13:42:07 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
 <201402061055.11799.sw@simonwunderlich.de>
 <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
In-Reply-To: <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AqCXx8IpkoHpssTfttIsPxEgqlQWAECXP"
Subject: Re: [B.A.T.M.A.N.] How to send message/execute script on clients
 from server?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Simon Wunderlich <sw@simonwunderlich.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AqCXx8IpkoHpssTfttIsPxEgqlQWAECXP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/02/14 13:06, Le Tran Dat wrote:
> Hi Simon,
>=20
> Thanks for your response. I've read about Alfred, tomorrow I will try
> installing Alfred.
>=20
> I am browsing the source code of batman adv and if I am not wrong I
> can create and send a user-defined message.
> I think I can broadcast something like a "struct sk_buff *skb;" to all
> clients. However I don't think this one is a good way since it may
> impact to the current design of batman adv. How do you think?
>=20
> One more question, why browsing source code, I can not find the
> definition of struct sk_buff; where could I find it?
>=20
> P/S: I forgot to give the detail of my issue is that I do not know the =
IP
> addresses of all clients but I want to be able to send the
> configuration to them.
> Is it possible for Alfred to send those configuration without knowing
> cients' IP address by using mac-address only?

Instead of touching the batman-adv code or using Alfred you could just
open a socket on the bat0 interface and send raw Ethernet frames having
the broadcast address as destination.

This is something you can do with any Ethernet compatible interface (so
also with your normal eth0) and therefore also with batman-adv.

Regards,

--=20
Antonio Quartulli


--AqCXx8IpkoHpssTfttIsPxEgqlQWAECXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS84MiAAoJEEKTMo6mOh1VfYcP/2jNETgocpU67NVfRXOi3M/R
JmeEPZLXLK1JiZPrFJ1FJZRa3ZwxF6MFp3PjbpGTSbXBFwLOXqSpsIFmQnQsgTlm
JzeTsY+TlsAoULGAcGJVOfgTDSAzDVRnieP5kWSMn21fK32J8nt66Y/KGDjz6pu3
Doe0ewl5pOiVK1c98k7aiJAMeAhA7CFhjLDSBCAQAzaTxExhpVm4/juO2nr5zzoe
3V3onBxIS3WqTjR7YLSWKF4gViboY2PSdYiTDNTsKsvYJt6a50OLtsTrLNxgxTQ+
CgAJMueTyZzGt5Vk9IYSygI0ySFphoPpuZQwcPbr5RHTOjHbYEKp+WSWwOLFVVUa
kVHb+bbXzeAQ+/OqTWbGLkCyJLda5HjeCZ0AOX8VaIoAOSSu6dtMQPMx/BPo6qY9
5KgryAjPPA8DL6FHO5fDeoZP3B+Cj+jDY/eKxzZoM3qPz5XFUQv4r2ttpYYUhX6T
PwrBb9/U5bOLKb0000ii6SC/3M/w0qUCdP7o865szNeUjhlcZ0ZcrSRcrqDeXjIk
vjX5lC6xdIA9BXUeTdvrCRb7pGgdQWT9/MhCoRl0M+wkGTxHrcSC8Cse+KTP/zYG
94KabOnX0r3K1UOiWpUv+kGhFSSHIyQgDUsugs9PQw5v5my8Lk6uoRlYz7RH+qrC
yFhR+7Q1K73MKIbxmmNa
=QmtQ
-----END PGP SIGNATURE-----

--AqCXx8IpkoHpssTfttIsPxEgqlQWAECXP--
