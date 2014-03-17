Return-Path: <antonio@meshcoding.com>
Message-ID: <53267792.8080102@meshcoding.com>
Date: Mon, 17 Mar 2014 05:18:26 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>	<53218FEB.8000100@meshcoding.com>	<CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>	<5321B5AE.9080005@meshcoding.com>
 <CAMcTwKrw+U7xZckqmcurrc8z4UZTkt50SqQ_esFHKo_D2Grf_A@mail.gmail.com>
 <5325A449.3080905@itamar.org>
In-Reply-To: <5325A449.3080905@itamar.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0jxRQ3F8tarsu7HfgjpjU28IsKaG1Thwb"
Subject: Re: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0jxRQ3F8tarsu7HfgjpjU28IsKaG1Thwb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 16/03/14 14:16, Itamar wrote:
> I have compiled both the kernel module and batctl from source (2014.1.0=
).
> The problem remains. Whenever I reboot a node, its IP is never reachabl=
e
> from the network and the network can not be reached by it.
>=20
> Things I have tried:
>=20
> * DAT enabled
> * DAT Disabled
> * DAT not compiled (ticked "n" in the Makefile)
>=20
> Of course, the tests were performed when all nodes in the mesh were wit=
h
> the consistent configuration and never mixed.
>=20
> Another curious thing I have seen is that when looking at a tcpdump (vi=
a
> batctl) I could indeed see ARP requests to the pinged IP (the tcpdump
> running on the node hosting the pinged IP) but the node never replies.
>=20

Have you seen if the ARP request makes its way to the other host? (e.g.
using tcpdump on bat0 to check that the packet is getting delivered).

Then check if the ARP reply is at least sent. If so, check where it gets
lost.


Cheers,



--=20
Antonio Quartulli


--0jxRQ3F8tarsu7HfgjpjU28IsKaG1Thwb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTJneWAAoJEEKTMo6mOh1V/2AQAKDJbBzOjurU94GiRr4dF/D+
o3ykg7LAOCLyJnSEYEHU00RZfRA6n5zc6gwx6istoeJk8DOYYMq19Oz24E1R7VYs
MQrWJxm2rFgMZVpntw6K0qFXEVaX48iMlOg/dxAU8DRmPLPzwJu0G/JusNVfrDur
AcNawzCiq+Hs8EA9I23ZcnmRw2YxRkLK6S7nCp/LPfQUPM8VNExSIXc7t+DkRchV
K5RLCvgyEK4H/+k89tdItMdknKDFwcgkOJVy58/E4LidDIzQVtu0uavuAyT67XTe
yhskOTxbYgoXnxhNzhqU+ipmDC48WRaYxCw3vi3yZTxkjGqJcz+iiDo1oBBW96Ll
zGOq4eSl5Jnz3+Gp51KFNYkl+6qZ9xMYMEsSnz6p7gqyB8DsO/MDQ9gTvyrZmUMq
bj1ZUy+PZCiFFmBzTsepeJW/V75662MoBc/GIXHp1OS4e12AgVPz2ewOhzuHBj+B
TESK6vddAljQM7CWPC3Vbv28IzlFhqGhEOamXa1i/cpKTuKkGHQQCEIcvzDht9OH
jYJqlzZLwe7ek80VZ/C/UqcKF1XvqWorF9DmyUie1oHjxmKb8tGBdtL7+1Ur3xgS
v+HscmFZh2qNWwdUAwuUJxFBGY+gK1W9M0AQd1Bx2TxjVA57xsnNRRAb3+lYE1dT
MDjRojH+yL5+bZxQW2eg
=tvdK
-----END PGP SIGNATURE-----

--0jxRQ3F8tarsu7HfgjpjU28IsKaG1Thwb--
