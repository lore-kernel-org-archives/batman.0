Return-Path: <antonio@meshcoding.com>
Message-ID: <530AEB3B.1050501@meshcoding.com>
Date: Mon, 24 Feb 2014 07:48:27 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1393196418-4001-1-git-send-email-antonio@meshcoding.com>
 <1702820.sOKJFjBZI7@diderot>
In-Reply-To: <1702820.sOKJFjBZI7@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LMlnQAhrlV1CnERw0ral6Mlhpc46cPLAi"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix merge resolution
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
--LMlnQAhrlV1CnERw0ral6Mlhpc46cPLAi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/02/14 01:36, Marek Lindner wrote:
> On Monday 24 February 2014 00:00:18 Antonio Quartulli wrote:
>> --- a/send.c
>> +++ b/send.c
>> @@ -255,8 +255,8 @@ int batadv_send_skb_unicast(struct batadv_priv
>> *bat_priv, struct batadv_orig_node *orig_node,
>>                             unsigned short vid)
>>  {
>> -       struct batadv_unicast_packet *unicast_packet;
>>         struct ethhdr *ethhdr;
>> +       struct batadv_unicast_packet *unicast_packet;
>>         int ret =3D NET_XMIT_DROP;
>> =20
>>         if (!orig_node)
>=20
> Don't we want longer declarations before shorter declarations ?

Yes, but the point is that there is no patch doing this change.
This line was moved during a merge...

If you want to rearrange the variable declaration I'd suggest to do it
with one patch changing them all.


Cheers,


--=20
Antonio Quartulli


--LMlnQAhrlV1CnERw0ral6Mlhpc46cPLAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTCutFAAoJEEKTMo6mOh1Vh3MP/R7qM0lQqEiC0VOzYXqIQij5
F092dTmc44KKtNKaRwTWLKWjq3u/ZeNnBfJMfGGS1fq4aIIh4c2fkfuZ1knr1jVC
xZ24dZGBAOw+wR+GWlDQ0vf9P8ZB0ikCHyUL0HhS2bxElXMZuyv8By64ykmsLzy+
qUJvdoEwEvq18amu+OOuM1XJ8RM7PUl8ptnIYQWlmI2aU+wnbYSPgGz1xgulMWEC
MHgE6+Mt1eLYT36ownbJVNefQRPdayk2gATA0+JN3+UnZclfAiJZNDJKtMsdg+WV
sZYaf1jGnwNPRqwgGjlYL+PlBg3mMct2BPa0NuCwYPqHWRE4ZExX7NFQDaElCzwE
Z8MMbGYhKP4ar6ibF7TN6+Fmn05jsOidINRNnb++5gMTPgphuUBuTd/4r/Jho7e2
3nf2cEsk7hATdqH0ZGzk4VmhO1WeQDvjEU1uAzCE38OGqEUTx4eikhFkPAQexHCy
c5B7DH80aVs5Kd2KD4gChMkUcVW7VfC0xrbWaRumPPbu3NPAOiemK0xAKBJBmfiL
PDOmKcDbYqNbtVGEuJS8+YKfcrq3SgaOjOLMdrOQDLncwffHEvSVVNIasIyNP1rY
ysteRN2xY4vDia/K2a9MwcE6D4Ns4+NptR/5B6URrwJJRo5Xo1/sY8SUBBx4MJza
QvyBQRyF3uXVe1EaIUw+
=uAvN
-----END PGP SIGNATURE-----

--LMlnQAhrlV1CnERw0ral6Mlhpc46cPLAi--
