Return-Path: <martin@hundeboll.net>
Message-ID: <52D631FB.9070106@hundeboll.net>
Date: Wed, 15 Jan 2014 08:00:11 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
In-Reply-To: <52D5B47D.8090406@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vTrGVHaEIrJMwXTgLuo4KbVEswXDdxrbm"
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vTrGVHaEIrJMwXTgLuo4KbVEswXDdxrbm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 2014-01-14 23:04, cmsv wrote:
> batman_adv: bat0: The MTU of interface adhoc0 is too small (1528) to
> handle the transport of batman-adv packets. Packets going over this
> interface will be fragmented on layer2 which could impact the
> performance. Setting the MTU to 1546 would solve the problem.

Did you enable network coding? That would explain the message, as NC
uses a larger header to make decoding possible at the receiver side.

As far as I can tell from a quick look in packet.h, the required MTU
should be 1532 now. (10 bytes unicast + 8 bytes extra for unicast_4addr
+ 14 ethernet =3D 32 bytes). Or am I bad at counting bytes?

// Martin

--=20
Kind Regards
Martin Hundeb=C3=B8ll
Frederiks All=C3=A9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net


--vTrGVHaEIrJMwXTgLuo4KbVEswXDdxrbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJS1jH/AAoJEI7EM4tTnYEZYTMQAJNE7Y3jeQq/aqqSuyFhhxp+
GqguhLpMLnnaJv7ryLs4AwTwjDYkyF1msrXnOY83+Y7f1e6GnDaxTs5+oB6t+mrN
I6qXUiHSDuuXnYp+m3YBRhOvGZfMIlBifB4ysXQO7bTh29/UI5NfDmNLZtusqmQh
RTvmTM+z6SdWVshnLE6Pdgwil0cXVoDLde6KbelH4eI6/JLEdcnD4bmKyX2JRcN0
OiYCeEWgsqZW2TQ2CttE8Ts/2REW0IRQFkOAGsUh3SkxPRhOHC65XTq29UgA0vDi
66ZuuBtLho98db81GpWzlb/qQMFg57tLt2N0vhnI54Kp021zEf3qlb1NJr6SvuZj
Wyptl+opVZ0iEDGorBmDv3n5JiNrSY926/NIAvm7lxiGXWTs1uxagmQ34yTVLd3N
3zlvEVNFIPapL6seeaxhqwUn2Hv6/Z6G4EWzZ8sFkA7dZmvIY+mVECvS9PR0NAFr
m92U99qjUK4hz7zXtihvU3fCayCTxWLIMMBifcXhPTsvrYaW5fSZQb/y9VTgUeym
EwTODM/LOfmqtyEuXGWZbdxZyb/kqL2NaABckkZrbEh/f/t8YhMD0L2/CESrNzpc
CnY6YbS7rV61PO9CgZkpkANVJ7h3ZKmwK5ahEkpWDIzml0mqJePVzUlze5TJbPvy
Vg//GvD9R7aNx+fBRJUC
=bAHz
-----END PGP SIGNATURE-----

--vTrGVHaEIrJMwXTgLuo4KbVEswXDdxrbm--
