Return-Path: <antonio@meshcoding.com>
Message-ID: <553703EA.7000405@meshcoding.com>
Date: Wed, 22 Apr 2015 04:14:02 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CACQgX2EGOT8WD0wTiSqMCoF=GeOJKeyTZtLBuKfHH3wkh4F40Q@mail.gmail.com>
In-Reply-To: <CACQgX2EGOT8WD0wTiSqMCoF=GeOJKeyTZtLBuKfHH3wkh4F40Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mh3ji9EWeHD7DGLkqmLsKV882MEQGsHTe"
Subject: Re: [B.A.T.M.A.N.] Installing issue (Makefile configuration doesn't
 exist)
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
To: odshrit@gmail.com
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mh3ji9EWeHD7DGLkqmLsKV882MEQGsHTe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Omar,

On 21/04/15 17:26, Omar Shrit wrote:
> HI everybody:
>=20
> I have four Raspberry Pi's, connected as a mesh network, I am trying
> to  use Batman as routing protocol (the batman-adv module is used),
> however I need to have the log file, and debug folder, as they already
> doesn=E2=80=99t exist in the installed module in the Linux kernel.
> The FAQ page explained that I have to re-install the module and
> modifying the Makefile Debug option to y ,
> In fact I have found that only the module which exist in the website
> of Batman have these options in the Makefile, the makefile of the
> module that exist in the Linux kernel is different, and doesn=E2=80=99t=
 have
> any option ,
> by default the batman module in the Linux kernel doesn=E2=80=99t enable=
 the
> Debug option as I'm using in my RPI's Raspian with kernel version
> 3.18.5
> Does anyone have any idea about how to change the options in the
> module Makefile in Linux kernel before installing it ??, I need to use
> cross-compile for compiling the kernel.
> All suggestions are welcomed.


have you just tried to search in the "make menuconfig" dialog ?
There you should find all the batman-adv compile options and you can
choose the one you prefer (including debug).


Cheers,

--=20
Antonio Quartulli


--Mh3ji9EWeHD7DGLkqmLsKV882MEQGsHTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVNwPuAAoJEJgn97Bh2u9eIoYP/RnKdJZZMDj2RJRAV2E8BNZl
tvudW4c6AMqG+W1n5KZsSM7TU2RGiE/NYR9QQ22Feg/vyvE8SVxwzlqrLzwUHnpO
8YyVNINUjJ9lZYzvlpFsm+r7W3dAYu/B6SQQdQNg0gJ6C7b8EdQCOnr8bCRh7rfW
XiUIzIvYiVYdM+LxheDe3pxOh/m5UfHRB9DlL+ncvf1AW1iVYLsvbX+qaafFysc5
IUlUFBEIGq1FeY4Uo+FxdgeRnlK5vnZD783y6sOCjSgrG8VF8EhCi5VNnFJbMauB
ipY7XVQ45hcod3h2CFhH3Wle1GVJjnHRGDvxfMKFzvdGNPwvQj7es4b1FITTu76W
DSRa0zg3nZYj0YZ9Cy/j0JQ03jDqfEXyWl5mFe+iOvkwrxg8qaUEmmUVjRcvwiRv
/yV/VWDnNAIVkYfJIFJ8f867RBQEj5QODgeafJfSPXpr68ifn454lD8db2rGls4n
sCQCqK4ijrl/dH9SCDTwY9lTqP4NwHEApQtltgnNRe8MGExCeFQVWG8GksW9V/0D
GCD6t5qrk3dzeC1Q1oTKDSJ5XDc9SomtK47s+TKjBYqDqx3MX2pM4D5shAIFDIqM
ezo5xLHYzoMTfqkE6TOKmt45EiD9ahZtv8FGGy2uzLcWTpQGotd/XfGBAwCvnKQw
miorcZREFqsU2tNUe32e
=Lj4q
-----END PGP SIGNATURE-----

--Mh3ji9EWeHD7DGLkqmLsKV882MEQGsHTe--
