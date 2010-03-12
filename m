Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 12 Mar 2010 20:09:02 +0100
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<201003121004.56182.sven.eckelmann@gmx.de>
	<201003121616.07084.sven.eckelmann@gmx.de>
In-Reply-To: <201003121616.07084.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2794967.WhcYXabcJT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003122009.02956.sven.eckelmann@gmx.de>
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

--nextPart2794967.WhcYXabcJT
Content-Type: multipart/mixed;
  boundary="Boundary-01=_OFpmL899hSyLK9w"
Content-Transfer-Encoding: 7bit


--Boundary-01=_OFpmL899hSyLK9w
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sven Eckelmann wrote:
> Sven Eckelmann wrote:
> > Now it gets real cruel, but who cares... C++ wasn't accept in the kerne=
l,
> >  so we have to deal with it using some GNUish stuff.
> >
> > #define seq_before(x,y) ({typeof(x) _dummy =3D (x - y); \
> >                           _dummy > 1u << (7u + 8u * (sizeof(_dummy) -
> >  1u));}) #define seq_after(x,y) ({typeof(x) _dummy =3D (y - x); \
> >                          _dummy >=3D 1u << (7u + 8u * (sizeof(_dummy) -
> >  1u));})
>=20
> After a small discussion with Marek I would like to suggest a easier
>  readable and symmetric definition
>=20
> /* Returns the smallest signed integer in two's complement with the sizeof
>  x */
> #define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
>=20
> /* Checks if a sequence number x is a predecessor/successor of y.
>    they handle overflows/underflows and can correctly check for a
>    predecessor/successor unless the variable sequence number has grown by
>    more then 2**(bitwidth(x)-1)-1.
>    This means that for an uint8_t with the maximum value 255, it would
>  think: * when adding nothing - it is neither a predecessor nor a success=
or
>  * before adding more than 127 to the starting value - it is a predecesso=
r,
>  * when adding 128 - it is neither a predecessor nor a successor, * after
>  adding more than 127 to the starting value - it is a successor */ #define
>  seq_before(x,y) ({typeof(x) _dummy =3D (x - y); \
>                          _dummy > smallest_signed_int(_dummy); })
> #define seq_after(x,y) seq_before(y,x)

@Linus: Here a small testcase - just as prove that I tested it this time :D

Best regards,
	Sven

--Boundary-01=_OFpmL899hSyLK9w
Content-Type: text/x-csrc;
  charset="UTF-8";
  name="seq_before_test.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="seq_before_test.c"

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


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

#define type uint8_t

int main(void) {
	int first_round =3D 1;
	type x, y, i;
	type parts =3D ((type)~0u >> 1); /* 2**(bitwidth(type)-1)-1 */
	int error =3D 0;

	for (x =3D 0; first_round || x !=3D 0; x++) {
		first_round =3D 0;

		y =3D x;

		/* Equal */
		{
			if (seq_before(x, y)) {
				printf("Wrong seq_before(%u, %u) =3D=3D true\n", x, y);
				error =3D 1;
			}
			if (seq_after(x, y)) {
				printf("Wrong seq_after(%u, %u) =3D=3D true\n", x, y);
				error =3D 1;
			}
			y++;
		}

		/* Successor */
		for (i =3D 0; i < parts; i++) {
			if (!seq_before(x, y)) {
				printf("Wrong seq_before(%u, %u) =3D=3D true\n", x, y);
				error =3D 1;
			}
			if (seq_after(x, y)) {
				printf("Wrong seq_after(%u, %u) =3D=3D true\n", x, y);
				error =3D 1;
			}
			y++;
		}

		/* Undefined */
		{
			if (seq_before(x, y)) {
				printf("Wrong seq_before(%u, %u) =3D=3D true\n", x, y);
				error =3D 1;
			}
			if (seq_after(x, y)) {
				printf("Wrong seq_after(%u, %u) =3D=3D true\n", x, y);
				error =3D 1;
			}
			y++;
		}

		/* Predecessor */
		for (i =3D 0; i < parts; i++) {
			if (seq_before(x, y)) {
				printf("Wrong seq_before(%u, %u) =3D=3D true\n", x, y);
				error =3D 1;
			}
			if (!seq_after(x, y)) {
				printf("Wrong seq_after(%u, %u) =3D=3D false\n", x, y);
				error =3D 1;
			}
			y++;
		}
	=09
		if (x !=3D y) {
			printf("In round %u only tested till %u\n", x, y);
			error =3D 1;
		}

	}

	if (first_round) {
		printf("Not done a single test\n");
		error =3D 1;
	}
=09

	/* 0 is successor of 0-1 */
	{
		x =3D (type)~0u;
		y =3D 0;
		if (!seq_before(x, y)) {
			printf("Wrong seq_before(%u, %u) =3D=3D false\n", x, y);
			error =3D 1;
		}
		if (seq_after(x, y)) {
			printf("Wrong seq_after(%u, %u) =3D=3D true\n", x, y);
			error =3D 1;
		}
		y++;
	}
=09
=09
	/* 0 is predecessor of 1 */
	{
		x =3D 1;
		y =3D 0;
		if (seq_before(x, y)) {
			printf("Wrong seq_before(%u, %u) =3D=3D true\n", x, y);
			error =3D 1;
		}
		if (!seq_after(x, y)) {
			printf("Wrong seq_after(%u, %u) =3D=3D false\n", x, y);
			error =3D 1;
		}
		y++;
	}

	return error;
}

--Boundary-01=_OFpmL899hSyLK9w--

--nextPart2794967.WhcYXabcJT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLmpFOAAoJEF2HCgfBJntGhMcP/06HeeyaiLQoYdzBu2Aa4o5Y
rGi/p04AwpeJ9dvjoIPanMsgCqQFsgcGuofzgdslSU73oqq5lCgjl5DsUsYZbhN1
OGVs0aqSA/V5AWEM7ziTAj6flUuulzjh/O6oKD3tNat5x/0thW2p3lbzV887kggv
cbmeNVNf0Q0xYKBYB4757tTtjJuHeMTrz8eMCE4dFkx0L/zg2YGkq+TTv7yOn2cO
84WOWjbF4FUyCnSRM8YxGlC5yorzjPRvZ93idswi/G0clvDxHElZNwBZlJdYbxPC
WGuJp6wPg63sciBFggRsFg16K7T8x+Ml0vgmbE3Hnuj11GPxAHy6YySkD5MOilvd
9rb/5Hcf1k/x/lXMu3ygMdi/PrXJ+5S8yBpU3xLWzgPXpAxLMe2bQKjtceM5qO+/
zmcFn/7fP/6lBI+ueNFsExBEaDdNY+k/sxlnSGOaitHd7oOeYsd8alEQmR5gVVLz
o8XhxDLg96B5Ajh0NR+wq1vHQZT6hemHNhx5kFZx3u+v7y8fbFw4fWmihIhBzWRC
WgHxBHKDzLGk98Xt52uDPJ8jkMKq20tSM8e9aWw6txuB/woIS5cnNBFUXZedvjpH
SC8EPw7njbC37iu3lye2MMjAatLwRDQPLo0zN+iZDv3GbvxUcXnEErNE5uXZ0Rv0
NAq4TUQU2xP2nvfXqggN
=vCxs
-----END PGP SIGNATURE-----

--nextPart2794967.WhcYXabcJT--
