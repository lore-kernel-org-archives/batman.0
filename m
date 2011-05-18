Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 May 2011 16:10:39 +0200
References: <1305703250-23111-1-git-send-email-ordex@autistici.org>
	<1305721333-28947-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1305721333-28947-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1971507.WyE9II7Hie";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105181610.41425.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC/PATCH] net: add seq_before/seq_after
	functions
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

--nextPart1971507.WyE9II7Hie
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 May 2011 14:22:13 Antonio Quartulli wrote:
> Introduce two operations to handle comparison between packet sequence
> numbers taking into account overflow/wraparound. Batman-adv uses
> these functions already to check for successor packet even in case of
> overflow.
> ---
>=20
> I added this two functions in net.h because I didn't really know where
> best placement is. I saw several modules that redefine their own functions
> for the same purpose.

Wouldn't it be better to ask linux-kernel what Linus/David/... think
about the idea to provide the functionality of seq_after and seq_before
seen at net/batman-adv/vis.c. They will tell you that this stuff
has to be placed in include/linux/kernel.h and let you know that it is a
complete stupid implementation because it never checks that the type is
the same. Then you will start to reimplement it the following way:


/* Returns the smallest signed integer in two's complement with the sizeof =
x */
#define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))

/* Checks if a sequence number x is a predecessor/successor of y.
 * they handle overflows/underflows and can correctly check for a
 * predecessor/successor unless the variable sequence number has grown by
 * more then 2**(bitwidth(x)-1)-1.
 * This means that for a uint8_t with the maximum value 255, it would think:
 *  - when adding nothing - it is neither a predecessor nor a successor
 *  - before adding more than 127 to the starting value - it is a predecess=
or,
 *  - when adding 128 - it is neither a predecessor nor a successor,
 *  - after adding more than 127 to the starting value - it is a successor =
*/
#define seq_before(x, y) ({typeof(x) _d1 =3D (x); \
			{typeof(y) _d2 =3D (y); \
			(void) (&_d1 =3D=3D &_d2); \
			(_d1 - _d2) > smallest_signed_int(_d1); })
#define seq_after(x, y) seq_before(y, x)


Or you could just sent this version as inline code and ask if it should
be moved from net/batman-adv/vis.c to a kernel header like
include/linux/kernel.h to provide a somewhat general solution for the
seq_before/seq_after. And maybe suggest the use in other protocols.
Hopefully they will say something like "no" or "yes, place it there".
Independent from the answer, we have a reference which clearly protects
our actions (your patch(es)). But somebody will still scream :)

Just look at Documentation/development-process/3.Early-stage
"3.3: WHO DO YOU TALK TO?" to find more about that "process".

Btw. I never tested the changes which does the type comparison. And
propably the ppp guys will scream because you conflict with there
definition of seq_before and seq_after - so you would have to remove
that definition from both places, get acks from both parties by proving
that everything still works the same way and get it merged by someone.
But providing a patch is propably the second step after getting the the
ok by a main kernel maintainer.

=2E.. and I will now write my own daily soap about people on mailinglist.

Kind regards,
	Sven

--nextPart1971507.WyE9II7Hie
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN09NfAAoJEF2HCgfBJntGGsYP/0zpatHjWgKs5iNjKqAcZdEq
5gF1mrci3i7DJivlcBPk7hFDxk5RNAtTh4l1wiHPltrTxTuCDYnAMfAq4XvnBLFc
4f3SPs3vK3qH/Xr98DwafiSl7k41Vch+R7NRm8B2KfZi54NaT0+B1PnU8QC7INzN
FgaeMM+3pKu3zG5ZVi8471iEew8IlFG3QR9QGx+PE8LsYUm0anCC4rV6c+HQNl+8
6osNs5Yh1waTWqeeSLOJIfi/7aiXzkdIg4e2IbjAARWwkr6tePto9bkVivMbuxr7
F8sV8FTVrv5egyrLh00nVuvXmJroOHV5dsueN/7n/f3v0kNTLF6lH+uId3XdWfXk
C8pGHt3NbVe/Cvu2iWBTutib0s77la7+OnxYnVdUYjCvW9TelHR8osGCmyQ+TzBR
uZBC3L2qbVzbF5V7vl2E7UNM2WqDxcfUTp5TjKp1xE8EkHE1p4gf63Zu1tg3PsTy
wM7fxsltjTuugKvcNcZfmsOGxuYDMnley5teBqjdVnmReSNaQZ482NC7roMbj9oV
4S9eoYlBwSd5TRYK1GBd31Kjo7vUuHdkrJDzEOWpv4fY0dj8NK58lNkknkZ5Q0sv
g7wscbHZYkwtWXeUgv6OeNOHQLuKXTeFn44A0m9Y9p+znBKoWIt+QN7LZoSey5qS
iUbaERCh4zm09ddQl+Ju
=LHhs
-----END PGP SIGNATURE-----

--nextPart1971507.WyE9II7Hie--
