Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2015 11:07:04 +0200
Message-ID: <1999902.gZ2UANlGb6@bentobox>
In-Reply-To: <56161A83.9060904@gmail.com>
References: <56161A83.9060904@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1520972.JAR80To2IQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Questions arised while iplementing NetJSON
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: antonio@meshcoding.com

--nextPart1520972.JAR80To2IQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thursday 08 October 2015 09:25:55 Germano Massullo wrote:
> I have some questions about JSONDoc created by command <<batadv-vis
> --format=3Djsondoc>>
> In jsondoc_commented file there are a few addresses that are not show=
n
> in ip_addr file. I commented them using
>=20
>     # non existing in file ip_addr
>=20
> What are exactly the addresses in "clients"? What do they represent?
> The procedure I followed to create the interfaces is available at [1]=


These are "clients" from the local translation table. It is like a swit=
ch
lookup table but in this case for "client" which are "above" the bat0
device.


=2D--------------------------------------
|   bridge (mac 00:11:22:33:44:55)    |          =20
|                                     |
| bat0                        eth0    |
|   |                          |      |
=2D---|--------------------------|-------
    |                          |
=2D---|------                    |
| adhoc0  |                    |
=2D---|------                   /|\
    |                        / | \
 ~~~~~~~~~~                 /  |  \
(mesh cloud)               /   |   \
 ~~~~~~~~~~           -----    |    -----------
                     /         |               \
 --------------------    --------------------   --------------------
 | device 1         |    | device 2         |   | device 3         |
 | mac:             |    | mac:             |   | mac:             |
 | 02:ba:de:af:fe:01|    | 02:ba:de:af:fe:02|   | 02:ba:de:af:fe:03|
 --------------------    --------------------   --------------------

So the device below bat0 is adhoc0. The devices "above" bat0 (from whic=
h it
gets non-batman-adv traffic) are the bridge and device1, device2, devic=
e3.

So the clients should contain:

 * 00:11:22:33:44:55
 * 02:ba:de:af:fe:01
 * 02:ba:de:af:fe:02
 * 02:ba:de:af:fe:03

You can check this also with the command: batctl tl

There is also a global translation table which you can get via: batctl =
tg.

But now you may say: "hey, I don't use a bridge on top of bat0 - there =
are no=20
other devices above bat0". That may be correct but batman-adv can only =
find=20
these devices by looking at packets coming from "above" and just has to=
 accept=20
everything which is coming from there (even forged stuff). But don't fo=
rget=20
the other source of addresses in there is the multicast table (otherwis=
e the=20
multicast optimization from Linus doesn't work). So I would guess that =
this is=20
the result of the other entries.

I think Antonio and Linus can help you to understand it better when you=
 give=20
them the output of `batctl tl` + `batctl tg` + `ip maddr show dev bat0`=
. But=20
here is my interpretation:

33:33:00:00:00:01 - (mcast) IPv6 neighbor discovery protocol
33:33:ff:xx:xx:xx - (mcast) some other IPv6 multicast
01:00:5e:00:00:01 - (mcast) IP multicast

Kind regards,
=09Sven
--nextPart1520972.JAR80To2IQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWFjI4AAoJEF2HCgfBJntGdCgP/Rtea/Lrz8IgmEkqIh0kiVMk
7w6K/MugwKfsK84xSrHk7GNGUcTygMMhGM8QEiQtncg9Q+ttmZKRudDoZs3qnPMh
D5BjnHk5pUqQynrN6g1pPojrmFtFF1Fznwk2uoYUMWmFl7gLPDxb7r5F0aqqCd2G
KtN8cLH75JR69Sd7RcUkW0kAPItEdrowzm63Vpy9SKLwWVgMWDH0JTBo+Fe9e69D
91kPINFoLAUiOpKQbKkFQhW14TJtxc4YmZ5Ha/JHPRBfejGu5rtw1nNa88SS+8mS
rL8cSss8LLz76cxmrsMXOHvlDlAUVh4Tt6D5c6mJmvo0pzacFQicnf3NCS6shhkS
xy8YHNBA6NRBQ0db69dfknzwiJP2SzGfXC8s/wVWLQOjr/DcztHKLCmQnFOMklN6
qF89H7jdK8WmnXuHG3OSz7amNj1dWqW1TqQ2wLr58S+oMbe/rVdE5a4QvKvP4szZ
xdlkrKJ5vQjT1SHfdg9QKvD/SWwhEHfgfF0cYKPAco3mE2/LcxRfBJMMTLMMhlnY
DsXOzY56jwWHWQ4wisYuUJI1zuINsZ8f58ucKjeh9f0idwXYkBcE9qfrPW7i8UEx
PlgyxVN2Cq5KoZGLEup7SDXhYUoQMhbfv17p5uLS//tvWw24nq8lzFd0JuZbbmP6
BtSmLDdDXXeZ4xWCMor2
=YAdb
-----END PGP SIGNATURE-----

--nextPart1520972.JAR80To2IQ--

