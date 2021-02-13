Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: BATMAN Adv design choice and comparison to Babel routing protocol
Date: Sat, 13 Feb 2021 12:20:06 +0100
Message-ID: <2779797.dbB02zZU01@sven-edge>
In-Reply-To: <CAHw+5zrk5DoMWY8KG6W=JPxkC+WhLzOKnWm-zry195Cke1GyBg@mail.gmail.com>
References: <CAHw+5zrk5DoMWY8KG6W=JPxkC+WhLzOKnWm-zry195Cke1GyBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4891709.YNz7R0F5LP"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Tushar Malpani <tusharmalpani20@gmail.com>

 
--nextPart4891709.YNz7R0F5LP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Tushar Malpani <tusharmalpani20@gmail.com>
Subject: Re: BATMAN Adv design choice and comparison to Babel routing protocol
Date: Sat, 13 Feb 2021 12:20:06 +0100
Message-ID: <2779797.dbB02zZU01@sven-edge>
In-Reply-To: <CAHw+5zrk5DoMWY8KG6W=JPxkC+WhLzOKnWm-zry195Cke1GyBg@mail.gmail.com>
References: <CAHw+5zrk5DoMWY8KG6W=JPxkC+WhLzOKnWm-zry195Cke1GyBg@mail.gmail.com>

On Saturday, 13 February 2021 11:07:11 CET Tushar Malpani wrote:
> What is the difference between BATMAN Adv and babel routing protocols.

I keep this for another person since I don't want more conflicts with Juliusz. 
But if you want to know more and have a couple of minutes than you can find 
out more about babel in https://www.youtube.com/watch?v=Mflw4BuksHQ

> Why use one over the other and why does babel scales over a thousand
> nodes whereas BATMAN Adv has trouble doing that?

Can you please back up this claim? And batman-adv implements the routing 
protocols B.A.T.M.A.N. IV and B.A.T.M.A.N. V. So you have to compare these 
with babel if you want to compare routing protocols.


If you talk about the kind of traffic transported over the links then
you are talking about apples and oranges here.
Linus made an interesting Talk which discusses Layer 2 and challenges it 
causes - but focuses at the end more on the multicast aspect:
https://battlemesh.org/BattleMeshV10?action=AttachFile&do=view&target=scaling-l2-wbmv10.pdf
https://www.youtube.com/watch?v=yE8uE-0tMuM

> And more of a general question about the design choice of BATMAN Adv,
> Why go layer 2?(I read the article where present in open-mesh but
> still it isn't very clear to main. What advantages do we have going
> layer 2 ?)

For examples watch the beginning of the video. Maybe someone else has more 
resources.
But basically, the idea for layer 2(.5) was "borrowed" from AWDS [1,2,3,4] to 
achieve similar easy setups that can just use your existing infrastructure for 
layer 3 management and L2 (b|m)cast by simply bridging it.

But as Linus' pointed out correctly - if you want to get this kind of 
functionality then you have the problem that you got this kind of 
functionality and have to deal with it.
And if you don't have this functionality you have the problem that
you don't have it and find ways to deal with it ;)

Kind regards,
	Sven

[1] https://web.archive.org/web/20110724001404/http://awds.berlios.de/
[2] https://chemnitzer.linux-tage.de/2007/vortraege/detail.html?idx=587
[3] https://web.archive.org/web/20110724002106if_/http://awds.berlios.de/doc/vortrag.pdf
[4] https://web.archive.org/web/20110724001720if_/http://awds.berlios.de/doc/poster.pdf

--nextPart4891709.YNz7R0F5LP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAnteYACgkQXYcKB8Em
e0amEhAAtZ68pXJSxwxNBT4wtdn1PwSUzOjuuLuIuVep7BierI81kfD6ubvkOY9B
S2XclXbAgRUcE4lwb3evPEiA93PIIZQM7Mv3n6j5s1/o9tze/Wt+XTxQBYhSZbEV
1eYxu6yFLalmMYlt1kh0ZBst83UuDdm1rXlCO3gU1S5ahCsJfywkPAsCHZUDyuKz
bBwXT3ZuZE1DskMRmyCJ/i3PN2/LHvigJDBHhviaEzLyquRls7v+gpJeRC6Hu7e9
fpc+yhEZ503Kc35Vh29Ems1K3YDVH+oPpIF1ig52J6Sryy8Xa3y+2DlHv0giI5/O
V/6yyUfcNow/O7IkyoNZeYB5pvNdmh3GVR2ZNAplC20JMt8tqRCJEyjsDHn/UO8m
CMGmUASF0Zhd8Z5S+mBvO5wN7WT/XWV99P0DmRxSmv0wIx4a0C/zOFGNSF9ehwFe
kI8tUeqUO6uW1qujbcy4b33ow5qrWbaWDispb1/j53yHOo+bm8NOKpPZcvBvjYet
OY8O0+hy/rmGsPHIUczvqT3Z/FL+tuxoqErhvo0QtbYMlpxsUjTjJB7KUZFe+CyX
Fe0L9YzFYNb/E6I/wCDB81aCJaZa1Xd21hEnSPhY4LuCtZ6rHiOKrc83bTi3uAGr
akvsSME1F1MuQ/ZVt5MNqmYp6DkOyZKkCEcZZHXUeGLzQ59+PmI=
=mpv3
-----END PGP SIGNATURE-----

--nextPart4891709.YNz7R0F5LP--


