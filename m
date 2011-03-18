Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Mar 2011 12:18:52 +0100
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201103081052.58143.sven@narfation.org>
	<AANLkTiniFmA3qES=1vfU_Y6Y+aMgTXzTOnDdSkpndxVX@mail.gmail.com>
In-Reply-To: <AANLkTiniFmA3qES=1vfU_Y6Y+aMgTXzTOnDdSkpndxVX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2034027.E8miv0JdWS";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201103181218.56535.sven@narfation.org>
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

--nextPart2034027.E8miv0JdWS
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday 17 March 2011 23:40:06 hlabishi kobo wrote:
> Hi thank you very much for your suggestions Sven, they were really
> helpful. i actually now put the below code down which i am still busy
> trying to test it.
>=20
> int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
> {
> 	int i,check, count =3D 0;
> 	int j;
> 	//TYPE_OF_WORD *word;
> 	int word;
>=20
> 	for (i =3D 0; i < NUM_WORDS; i++) {
> 		word =3D seq_bits[i];
>=20
> 		for (j =3D 0; j < 32; j++){
>         		check =3D (word & (1 << j)) >> j;
>        		 	if (check =3D=3D 1)
>          		   count +=3D j;
> 		}
> 	printk("our count is %d\n", count);
> 	return count;
> 	}
> 	//printk("our count is %d\n", count);
> 	//return count;
> }
> When i am using it on two PC's my ping seems to be recording much
> delay. I will appreciate your feedback in this regard.
> Thank you and kind Regards

Ehrm, you know that you ignore the fact that seq_bits[i] may be 64 bits? An=
d=20
you only calculate the weighted sum of a single "word" (which you static=20
casted to int....?) and not all words. And the sum is still wrong weighted=
=20
(you still give zero weight for the newest one and increase the weight for =
the=20
older). And the way you check the bits is even for a sequential implementat=
ion=20
overly complex. And it is normal that printk heavily increase the amount of=
=20
time... maybe you meant that by delay.

Sry, I have really no idea what I should say to it.

Regards,
	Sven

--nextPart2034027.E8miv0JdWS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNgz+dAAoJEF2HCgfBJntGVJUQANm7KUgA4XHS5oUUiB0Xup3g
VkryQ3l/0NuYTKmXp9ecAeazYfY1MRKCWW7oRcV98yfVBY82HKU5L+0BV7fhvmST
GafFpfHuN2OLPigEgGnt308P3r8kxgPFVDbjCt4kZDz9undCfuX59HQN0/IKg9UM
Fs82tXe/IUcqxfU/7uwMt+Q4xbfqB3x00SJuqf041Vm5ExEDcgW8bOxAnZm6SAgY
VToG9rLlm8Rh3IYGiL7giDNaHntH6xPSP59q7g1B+I8ey5RuQYjCc2MSCvGsCMS1
8ZPyQFn+i1vqoi5g4zuXw2ULW8w+mmYS2CsWjc81XZSroEvxhdyFTanaQwm7rQMf
Pg3VPFVrDpiN2gHhX60jEV0IytWg7pgBHUClCsN3DdNQpQvlk5KnL2lOcGs0gpRn
4M7x5V7iMthg47dpE/CCJQN0bBSu9+FyGm/sgIqA4KntZVV7ZTCPJv0Luq9sZqa/
UIil2xUKPmIPPG8NjDISx2zUsyd7y2O4MLHfXzy1VvTxf4u+pA3JmD14tmhDzZ+8
qisvol+mvPsWYWEKHfZOkpJMR1chn5BNL5p9FDas54AAvlyqnflk3KG5zcn7q4Wh
Wr1uINO2jtvWjWNJ4qWMfI4UKVXtLdKsQ4ygKrdxTqDqa0zRQa7Vbz5+Z0VI8tyK
YVk3kDdszdeogXtdQ3//
=FKkC
-----END PGP SIGNATURE-----

--nextPart2034027.E8miv0JdWS--
