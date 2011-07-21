Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jul 2011 10:23:43 +0200
Message-ID: <8523816.3y33SjpCxy@sven-laptop.home.narfation.org>
In-Reply-To: <CA+qXHzN2x3CL7aH7T-OJKEE0tfs7kgOVoqtUpNZJyecrywRJWg@mail.gmail.com>
References: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
	<2942004.kRGEbDgGH5@sven-laptop.home.narfation.org>
	<CA+qXHzN2x3CL7aH7T-OJKEE0tfs7kgOVoqtUpNZJyecrywRJWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1396844.HEvj4gxq3P";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Filtering BATMAN-ADV packet
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
To: "Nik M. Anas Kamarudin" <nikanas@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1396844.HEvj4gxq3P
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 21 July 2011 15:28:18 Nik M. Anas Kamarudin wrote:
> I think this is misunderstanding.  This method work fine on wire
> interface because it use ebtables to filter the batman-adv packet, and
> ebtables need to be use with bridge interface.
>
> And why this method don't work on wireless, is simply because you
> can't create bridge interface with wireless interface.  That why ask,
> if anyone here got another idea on how to filter the batman-adv
> packet. I provide the example above to show what i done, if others can
> do same thing but different way.

As explained in my counterexample, this statement is simply wrong. I am 100% 
sure that I use bridges together with wireless interfaces (ath9k+AP) and I 
can't take enough drugs to forget that. Either you have a specific situation 
where this is not possible (there are some of course) and have to say that or 
you are simply lying. But giving no information or lying will not help you at 
all.

> About the br0, you can make the br0 work with or without IP.

And now we bury the routing...

I don't see that you use specific routes which are set to the correct device. 
So let's assume that your routing table now has two entries for 192.168.5.0 
with different outgoing devices and that it chooses (for unknown reasons) to 
use the route over br0. The target you want to reach is not only one hop away 
and thus the actual nic can't reach it directly, but batman-adv would be able 
to forward the packet correctly. And now think about how useful it was to give 
br0 a conflicting ip (due to the same subnets).

Kind regards,
	Sven
--nextPart1396844.HEvj4gxq3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOJ+IPAAoJEF2HCgfBJntGyMEP/1zIxQZnVoI2tc79cIoMIq0Q
yoo86CU7352ZM0kUWhQSm+lJO+2cW7aIrdqPl5PS+63mjUgjiADoi4d4c5/aJPk+
r3xJOxGjED58d+cFpRmqM2X5Fg8mpNQMKBz5cyStRYo/d9aivx8a+GPT+ki/Dres
WGCR0gd5p9ELYVlqWgZhu107iGfe2WD6VTmo8Ugmku/NLByOXYDH0RlqvdKi3MIn
KbE/RvuWr/SsMUUa+a97n2wBI7MU6Hipo/2j4X5zQnFahshGN4hOcaWe+FFDVqjU
CZ9qfc+HzdnXWx52ncCTVde5Lh/muvWVCv/QEbA7QIRySNs/PMXYlEL3ssxxHcxD
tHEgIHFxHYzRRjf1AV14mm70xPEAN0ouK/bl9zImO+JkW+/JiyVt1TC0s8uVh3mo
tYwp3uQ9Sw8w4V29ojpifOtlfgO0KanPbhYHxYNhfNUrGSnY54XdMefLJC7QlaIP
CkLW+ejho9YWLcIxOosEYq0ShvhqS/rPseDoMxgOBMHRIsmvMfJxBFW8anB9QU9y
ByA9o1pdsvWLeOAKsjOv2HCC6oVBXvuN1W/QNLpg7DspEfnLk8kEopJO9NjvHUQW
NX3k8FA0fM9719w5rIKAS2hzFRrLqStbw/ZDqr0x5oh7aS74fH1AhQAek34BDTD0
q9njESTvSanu5PlQNOXs
=n4ql
-----END PGP SIGNATURE-----

--nextPart1396844.HEvj4gxq3P--

