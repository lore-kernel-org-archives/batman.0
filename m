Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 2 May 2011 17:27:36 +0200
References: <1304348024-11681-1-git-send-email-lindner_marek@yahoo.de>
	<201105021702.33522.sven@narfation.org>
	<201105021709.31468.lindner_marek@yahoo.de>
In-Reply-To: <201105021709.31468.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11246464.lx7knjbt8l";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105021727.37709.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: purge unnecessary include
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart11246464.lx7knjbt8l
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 02 May 2011 17:09:31 Marek Lindner wrote:
> On Monday 02 May 2011 17:02:32 Sven Eckelmann wrote:
> > On Monday 02 May 2011 16:53:44 Marek Lindner wrote:
> > > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> >=20
> > [,,,,]
> >=20
> > >  #include <linux/version.h>   /* LINUX_VERSION_CODE */
> > >=20
> > > -#include "bat_sysfs.h"               /* struct bat_attribute */
> >=20
> > This is necessary for kernels older than 2.6.24
>=20
> Aarrrgh, I was afraid of something like that. We are running into an
> include dependency issue as soon as bat_sysfs.h contains something like
> "struct bat_priv" which is likely to come soon ...
> Any better idea how to fix this ?

Wait a second - why do you want to have a struct bat_priv in bat_sysfs.h?=20
Isn't it possible to use 'struct bat_priv*" for a function declaration?=20
'struct bat_priv;' can be used as forward declaration and used below in a=20
function declaration.

struct bat_priv;
void test(struct bat_priv* a)
{
}

Kind regards,
	Sven

--nextPart11246464.lx7knjbt8l
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNvs1oAAoJEF2HCgfBJntGWn4P/RD6xLL6iZNTwM0D3kHeoBZg
YjhVRGExHf9ywSjfCY45x8X5jJC6M1rw834hHBTY786snj5VQHQ+oSgGbXhiKK+U
TY/dLIe79POzwe4cGu6opFejxnv9Fpeku/fyfs1nnmgwlNxQBj1FON0TM9m6l73Y
7ct3Hc2QDbWdNP65WUaRyMg2PllZKGF4bWG0IOINJq3xPYRiNfqkI4UnnVk3Ah29
b8gVa3SFZi30bmHWq2cY7JNlxJTzk8q0Q7NkIN6VTnbaujqF3Idh20A6624UaBVo
zqGONYRBG0vSDjp+b7lFshR50G26zQjf87CK2A+3dhE21hWXnLDZnL9Kj9pN9EYH
0gR/Jonk9gUdPVhXamqgt+C5AP48QHImVNZCZk30/yVIQrog8+oc/87D/kenq3/n
/RqP9ftfI0Ls+x5rpzJAmxIyO9udTM6dfmkxm5ROmMvUNPA4nyKDFKf5p4p4tgCC
Fhs3oBbN3K/2oWnEDzMonoi/7f9gI0+1qWgb4fe6DpAIPKoTukhK+HSEG9immrg3
SN+wDnln6FsH8EUeAk968NUmUpPwiuBQTxgM/B4fHzaBHFHpuy9Hx9JGI/4DW9OG
H0gTMyLlEvaHJ0YaiY/GjfTJJcGLKkeQsbybiIo9yioyDhzva0xnzTSOUk+/+cAD
t9NMVTGp6+KSImOV9+y2
=5j/e
-----END PGP SIGNATURE-----

--nextPart11246464.lx7knjbt8l--
