Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 8 Mar 2011 10:52:55 +0100
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201102282029.05802.sven@narfation.org>
	<AANLkTikj8oj26P_F1LTiGWnt2R=29VESfpD1ZsfeL4X0@mail.gmail.com>
In-Reply-To: <AANLkTikj8oj26P_F1LTiGWnt2R=29VESfpD1ZsfeL4X0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1866539.puH49SCkK8";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201103081052.58143.sven@narfation.org>
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

--nextPart1866539.puH49SCkK8
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 07 March 2011 22:00:25 hlabishi kobo wrote:
> Linus suggested to me that i should print the window and see how it
> looks, I did that and it returns this ef0fffffe, ffbffff, f70fffff,
> eb1b53c0, eb3950b8, eb1749c0. I am not sure if this are hexadecimal
> number or what.

I would think that you wrote the part which prints out this values. This me=
ans=20
that you know which parameters you gave printk and that you should know the=
=20
conversation specifiers and length modifiers that you used in the format=20
string.

But I would guess without having any of these information that you used %x =
to=20
print these values. Whatever you used as argument - 32 bit (size of single=
=20
int) of it were printed in unsigned in hexidecimal notation. Maybe you shou=
ld=20
think about using %lx to print unsigned long ints in hexidecimal notation i=
n=20
case you really used %x.

Which brings me to another question: Why to I see 6 numbers in your post an=
d=20
why has the first one 9 nibbles?

As said before (and also recommended by Linus): try to write a small c prog=
ram=20
which uses these values, print the single bits, try to write some test=20
algorithm using these decoded bits and play a little bit around with other=
=20
test inputs before trying random things inside the kernel.

> Again this is the results of printing seq_bits, so far
> i have not been able to print real_bits as this cannot even make a
> network ping. Could you enlighten me in this case.

I cannot understand how pings and printks are related...


May I ask how these things are related to your work/studies? It is ok to pl=
ay=20
around a little bit as small side project/hobby without having the time and=
=20
knowledge to understand what you are really doing. That is usually a good w=
ay=20
to find new interesting topics and maybe to learn something (or blow up a=20
building...). But I would highly recommend to switch the topic in case this=
 is=20
part of your thesis or work.

It is not meant as harsh criticism of what you try to do, but it seems that=
=20
right now you aren't able to efficiently work with it and to gain enough=20
knowledge by yourself to be able to understand simple parts the thing you a=
re=20
working with.

Best regards,
	Sven

--nextPart1866539.puH49SCkK8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNdfx4AAoJEF2HCgfBJntG/pcQAJEso1+Ph2mODcueA1b94xX4
DLhnoImOt6QcteqrpK4vkWNRzdgrPIAj7vyCkg3Nm1cTgDrVJ1P/G+NIGZOavGrt
ejZAr7vVksi0xorZySIATqy7s+0Oy9IqaLTkDYF4v5s0gZ+GGVA85WLbr/d4iOYW
privmyMc5uvWRHABoCIyBx0lI83zm4tkF5vlJKAX0fMBNggC/PzOoSlSIPUvqw3M
KCc8iUaxjRfKQ8FhDEM4AFhaWkTaPTjhwmj/FeOpedY/mhXYRUxEGFNcTFj6YBIu
ocZcUOEnFVyyW98GNvhRDxxcDFGB4NW5h3E5Wc3niay66VUoE0o2/65BFLaApJgH
yrgDfy9b5LPbdUylOzZR9atyo1cSw9fMZklfTd8WXInFgb6ASdUiXE31exMbODgY
n4ADBjeNHrcbKMQCVSkTnhe9gV3fHzq34452J1v/hbGfLLVfdeXb31M3zUArWbyf
GA+f4a++tbxKA402artu78MxX+EBXQIFQDOPrH96s4omKT1IEwSttt275rZYfoIC
i9d2TDHMTIv+9OlmvqY2cwoTniCKeFnJdOk4vx4kGc/eGFaic34DJHA673Ltuerz
XkQKA8tTygtX/OWlJm6bpxYWN/24uA3WaDqUWwuWozxZlTuCmGKEYXwY7Xz13bOd
Erkp024rZYzjLNNBdMyR
=u+Ve
-----END PGP SIGNATURE-----

--nextPart1866539.puH49SCkK8--
