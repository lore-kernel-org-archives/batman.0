Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 09 May 2018 22:08:56 +0800
Message-ID: <2420912.gZVJyty8xz@lafayette>
In-Reply-To: <20180506195559.32602-1-me@irrelefant.net>
References: <20180506195559.32602-1-me@irrelefant.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2105340.yTZFibcTWB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: mitigate issue when
 empty vlan is received
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

--nextPart2105340.yTZFibcTWB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, May 7, 2018 3:55:59 AM HKT Leonardo M=F6rlein wrote:
> -               if (!vlan)
> -                       return false;
> +               if (!vlan) {
> +                       /* Due to a bug, some originators send TT
> +                        * announcements for empty vlans. As the receiving
> +                        * nodes will ignore those empty vlans (they do n=
ot
> +                        * add a batadv_orig_node_vlan into the transglob=
al
> +                        * for the originating node), crc check will fail
> +                        * here. To circumvent this issue, we skip the
> +                        * verification for the vlan if the crc is
> +                        * equal to 0x00000000.
> +                        */
> +                       if (tt_vlan_tmp->crc =3D=3D 0x00000000)
> +                               continue;
> +                       else
> +                               return false;
> +               }

There are some issues with this approach:

 * As you might be aware, a CRC of 0x00000000 is not an invalid or=20
uninitialized CRC. That means it is conceivable the CRC over the translatio=
n=20
table entries and flags results in a CRC of 0x00000000 without any bugs bei=
ng=20
present. Applying this patch would lead to introducing a bug in these=20
conditions.

 * The second concern is about how to deal with 'the bug' (referring to you=
r=20
patch comment above).  In your case 'the bug' results in missing TT entries=
=20
for a given VLAN plus a CRC of 0x00000000. What if the CRC was 0x00000001 d=
ue=20
to some other bug ? Then you're check would totally miss the mark and we're=
=20
back at the beginning.
If we wish to deal with such misbehavior on a scale where we assume the cod=
e=20
should be able to deal with garbage values in some or all fields a differen=
t=20
approach is needed. Relying on a magic number (CRC 0x00000000) is as bad as=
=20
the current behavior (assuming each VLAN has an entry).

Shortly, I will send a patch to prevent sending an empty VLAN around. Pleas=
e=20
note that this patch still is more of a band-aid. We still don't know how t=
he=20
empty VLAN came into being in the first place. Plus, that patch won't prote=
ct=20
against garbage packets which certainly requires more effort.

Cheers,
Marek


--nextPart2105340.yTZFibcTWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlrzAPgACgkQU1VOj+62
HMAYYQgAusLgHoVXRQjXq+YUUbA/w2+dmEvMDQcLU4hVRLazUIdhF8WJDztA1F3L
r/EcMsXAGGupCsg8b7CEX4YatpKNNVUEzI2BNdqTRsTLC4V8A6ws/+s+0ct+LjoX
iHSIPVOv03rjr4uEhULA2aV0iNgNHVGQfDueA5FSPgkW6NW8muiK8UFPgkbcJBXm
R6BI5KdxYs99/AFMPJOkJlSfvkLqXv8NroodKnllWa9YCrvZRH7Ykxg1XJBvWzBc
NfBa/yLVX7ctjarQd8xfKdxodeEtddA7IVuFEKR2o7FEGPobDCf+46VDEjOaCxKM
SFw/UHPaMuOUO9RzIJ2sebZ97oQ92w==
=ne56
-----END PGP SIGNATURE-----

--nextPart2105340.yTZFibcTWB--



