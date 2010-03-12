Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 12 Mar 2010 16:16:01 +0100
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<20100312000931.GB13786@Linus-Debian>
	<201003121004.56182.sven.eckelmann@gmx.de>
In-Reply-To: <201003121004.56182.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7238380.IWeIJ9WnGQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003121616.07084.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart7238380.IWeIJ9WnGQ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Now it gets real cruel, but who cares... C++ wasn't accept in the kernel,
>  so we have to deal with it using some GNUish stuff.
>=20
> #define seq_before(x,y) ({typeof(x) _dummy =3D (x - y); \
>                           _dummy > 1u << (7u + 8u * (sizeof(_dummy) -
>  1u));}) #define seq_after(x,y) ({typeof(x) _dummy =3D (y - x); \
>                          _dummy >=3D 1u << (7u + 8u * (sizeof(_dummy) -
>  1u));})

After a small discussion with Marek I would like to suggest a easier readab=
le=20
and symmetric definition

/* Returns the smallest signed integer in two's complement with the sizeof =
x=20
*/
#define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))

/* Checks if a sequence number x is a predecessor/successor of y.
   they handle overflows/underflows and can correctly check for a
   predecessor/successor unless the variable sequence number has grown by
   more then 2**(bitwidth(x)-1)-1.
   This means that for an uint8_t with the maximum value 255, it would thin=
k:
    * when adding nothing - it is neither a predecessor nor a successor
    * before adding more than 127 to the starting value - it is a predecess=
or,
    * when adding 128 - it is neither a predecessor nor a successor,
    * after adding more than 127 to the starting value - it is a successor =
*/
#define seq_before(x,y) ({typeof(x) _dummy =3D (x - y); \
                         _dummy > smallest_signed_int(_dummy); })
#define seq_after(x,y) seq_before(y,x)

Best regards,
	Sven

--nextPart7238380.IWeIJ9WnGQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLmlqxAAoJEF2HCgfBJntG4KkQANM/BERMBYq2AJMMjQWtingP
sE2YradVDTWbDUkZvjCmOnHNQzRfIwNg0D6M2Bzl0eEXDiYkRGixU4uyH3klAqFU
bmCWsXbyvuhlW8XzsCM9YQWNnfA2VigkEJ8WxMoQTFEdVurJBxKSLOkdeG207Ogi
YZ0oVBfUHyEz5xhSzY6MYaIg09QNs1fjOLhzABALhixFZawD78UBpz++ydWohjfd
eQbK3odp1Q9qSr0oTJay8dLOiTRL+Lenl92an8CNotY2d+EDW4UM2ugIFwkOKSAc
qgDV6N+ZPe+6/iKz3cTeHRtewNqmCEVmqbSi28Q6wYPQcihl+0VCV+F9pilc00XD
kOnYod4vafjOgLoewiUW7B90//kSuqPEcji07BVB3RpB3/EWrJwMCcqaDS/2+QE+
tzGKk55znKKtdUDGfdpoxlUW6kHq8L+Ph3pSTrUjDyA8+c4VDB+Pf/9/8Ics/dR0
TpsovOBCk5vOwGaysnpxylB05dG2YrHG3XmquEA2cXlhopQZV0+x8Qik1D21R4WP
YD2qXZ7nLhcEDZQCU6PH0sqzEREM108JzvxRN7cdxLPAHVlhcu/A/hwx3DPnptjf
Vg43JvRfgsHpUNZe6RVwReHHvZAS1IBRXNrfNDXYrkq4W7o/lAKuLsuAaltNKajt
QKSnMVa4dtgdS+c8rT4X
=RZH/
-----END PGP SIGNATURE-----

--nextPart7238380.IWeIJ9WnGQ--
