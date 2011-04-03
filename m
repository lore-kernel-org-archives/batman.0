Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 3 Apr 2011 23:25:55 +0200
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201103220001.48909.sven@narfation.org>
	<BANLkTinL7SPtofEQsacsckPqD3ySniJF_Q@mail.gmail.com>
In-Reply-To: <BANLkTinL7SPtofEQsacsckPqD3ySniJF_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20344631.zxhKGeM16v";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104032325.56687.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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
To: hlabishi kobo <hlabishik@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart20344631.zxhKGeM16v
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hlabishi kobo wrote:
> int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
> {
> 	int i,check, count =3D 0;
> 	TYPE_OF_WORD word;
>=20
> 	for (i =3D 0; i < NUM_WORDS; i++) {
> 		word =3D seq_bits[i];
> 		int j =3D WORD_BIT_SIZE, k =3D 1;
>=20
> 		while (j > 0 && k <=3D 32){

it is wrong to assume that unsigned long is 32 bit long.

>         		check =3D (word & (1 << j)) >> j;
>        		 	if (check =3D=3D 1)
>          		   count +=3D k;
> 		j--;
> 		k++;

I would doubt that it is correct to give every set bit the same weight when=
=20
they have the the distance of sizeof(unsigned long)*8. And I cannot find a=
=20
good reason why an "old" unsigned long should get the same weights as the=20
"newest" unsigned long - at least not when the actual weights should be=20
reduced for "older" bits in a single unsigned long and the overall weights=
=20
should be monotonic decreasing with the age. And using WORD_BIT_SIZE for j =
is=20
like assuming that we only have a single unsigned long in seq_bits... which=
 is=20
not true for many architectures.

And the code is overly complicated without any good reason.

Kind regards,
	Sven

--nextPart20344631.zxhKGeM16v
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNmOXjAAoJEF2HCgfBJntGx5YP+wQGEFcTaKryMdAV/+oT6Iy6
sf6delTHXZX066X1H/aA8/kkFxV/BIiSlWLlLCBrThLHXaCo/ODXJGiXSto7Rqlw
26vpyd1xpfJkEC3Eq9qsU8jLhks8RgrKawS/4nXLiPQcCX0RP7PivMAXW4X7Zdj8
jCGsRaYGnqJVksySPAqQggRSPaLbQvzFvzP5YUvkuU1G+e7/gX6org1dZafg0jQL
cLGEz/8WNxi1K22RQ5+q4K9YU0i+9kq3EN4JQX+I8sWatomhaja5sWWFxFZyBW2t
SpfGr7GMZkl0En8pGsG4SvBrG0CKDodfB6skiw3E9hyj+VGxx61WnNAxycCn6lPo
ADjmFyPFjnG9kF1iZced1Rf61IvNE1w7iyijuUyG9Tsx7Nfax41A2IMHgai6N3Ib
kmVn4aQOv0om7zAAewrEnmMyB1GNMnAoWduhLkDAeh2ygKOy351EyZAmQ2qz4kwL
oo6EB7gcqTXWb3ZMFCyk2u+DY1H5LSwyl4sI35LIoL58WIHCf3T910PfP83VLt4y
TYKx4HVYfQOz5kwC8ObTEumrbHv9ynV7VTb3nEvS7tl15XtUXOy/70uhFIJbzLSb
6UCA+3ZMX03MqOVzQfdGvZr9URVEfAQldGX3mUH0TJzLe8GUJZtstS3bfn1yYHjZ
6FuIb8UlvtWOdfNR9eHn
=Ds/2
-----END PGP SIGNATURE-----

--nextPart20344631.zxhKGeM16v--
