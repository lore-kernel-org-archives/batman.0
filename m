Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Oct 2009 17:17:12 +0200
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
In-Reply-To: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1517294.IH6MCyhNFn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910201717.12868.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart1517294.IH6MCyhNFn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=46rancesco wrote:
> Hi all,
> i'm starting a B.A.T.M.A.N. mesh testbed, i've read some messages to find
> some answers but no luck.
> I'll try to explain what I've done and the errors i get..hope i get some
> help in here.
>=20
> >From the beginning, I am using batman-adv 3.2 compiled along with batctl.
There is nothing like batman-adv 3.2. Where did you got it from?

> Only one wireless interface (wlan0) on each linux box (5 boxes by now)
> Here are commands I fire on each node:
>=20
> $ insmod batman-adv.ko
> $ iwconfig wlan0 mode ad-hoc essid BATMAN_NET
> $ echo wlan0 > /proc/net/batman-adv/interfaces
> $ ifconfig wlan0 192.168.1.xxx up
> $ ifconfig bat0 up
You must give bat0 also an ip to use IPv4(/6) over it... in most cases only=
=20
bat0 as it is just the hardware interface the bat0 interface is using.
If you only want to test raw ethernet data over bat0 this should work.

> I get a new bat0 interface, iwconfig shows nodes properly part of the
>  ad-hoc network.
> I see correct $batctl o  output but i cannot $batctl ping $mac_address
Can you please give the originator table and send some small dumps (tcpdump=
 -
w, batctl td) of both nodes when you try to send a batctl ping?
What mac address did you use?

Best regards,
	Sven

--nextPart1517294.IH6MCyhNFn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK3dR4AAoJEF2HCgfBJntGJJ0QAL9NOwAoJUHkY+Qky+hJWTMp
l6eTB4LDkgI8+T4PsoGjcT2eqM94c2rWLK30O4HfzrZaWa21b9kbu4cE9LAfXnao
Qt4cai3FAfMg7g23joMs/SjE0Y5vFZTqctrzKeLGvd5NvYNzq5BM2+w+0VbA9n4i
nbiCCbA4SOgkWGFqD0qUsVQAPx7siapuIHO1FSOG/KbXuY2WQXBkbjKL0+1KoZgI
rNoqAcLmrezP3+HDfKCoywWMbjM5xs0USIPzpDuGBgAsTd7xEDfW8sKVb7JzUAWF
Z/0wQVbC2JmDfBkJDBJbE6J9y3XMj/TUVZiTJcMD+wVbOpjcP4Dh7Zjj/kqrLDLE
wd8Pp/oWACLMipa4erDoe8Ikwd1EmlcqwO+SlmLsRkkycRCTqlIfG3jsuneU1wX6
z8qJfTBOvF9Cw5bRFQCUCuq0jHGZ8uXyPKnc1BzHwTpGIjCu78ozrkGh1jqkKkBx
iF4MkHF0L1NapknPNdIXGi+aAgXEcjjZQlzbpFw65RwvVra62GMQGdZH9yIzZxCw
UUGRzeyuY8M0d/lyzUWKH0tACJvZ06rqSaR4X+6gYHGFOLybtOL3+/l9jezncA09
SJc2nM3xHHT2u+RzrNPzNXMlZNZ3tgk5emOj1O9SQELeLpKDBM7OCNQu6fT9G1PZ
l0kZmdfihC/j3CPjleD7
=53O9
-----END PGP SIGNATURE-----

--nextPart1517294.IH6MCyhNFn--
