Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jun 2012 08:59 +0200
Message-ID: <1794568.t7tZJ9NAC6@bentobox>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPNuGB5hMDtNhUs29egcVLUBAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<1773376.eftnT4ifSy@sven-desktop.home.narfation.org>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPNuGB5hMDtNhUs29egcVLUBAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2867242.4eRTA2f5x7";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] bridging problem
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
To: Walter Robert Ditzler <ditwal001@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2867242.4eRTA2f5x7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 06 June 2012 00:16:07 Walter Robert Ditzler wrote:
> hi sven,
> 
> thank you very much for your reply, in fact my email hasn't arrived as
> wished!
> 
> attached i send you a pdf to have a look, if you dont mind, would be very
> cool!
> 
> so what works:
> 1) lan to lan bridge (10.41.200.11 <> 10.41.200.12)
> 
> what i am too stupid to do:
> 1) attached wireless ad-hoc devices to give a dhcp lease

You need another vap/vif [1] adhoc device to serve such devices. This one 
would have to run in 4addr mode to be able to get bridged. Usually you don't 
do this because the client also needs to understand the 4addr mode. Therefore, 
just create a master mode vap/vif and attach it to the bridge (you get it into 
master mode using hostapd... please keep in mind that squeeze's hostapd is 
buggy and maybe has problems with that setup).

> 2) that ex. a attached laptop has a address 10.41.200.71 > bridged analogue
> tot he base lan
> 
> so my question is:
> 1) do i need 2 wireless network card for each batman host?

Not really. It could be a good idea to run the mesh on another frequency and 
use another wlan device for this.

But the basic setup is really to create two interfaces (VAPs) for phy0 using 
iw. One is added to bat0 (the adhoc one) and the other one (managed) is 
transformed using hostapd in an master mode/AP interface and added to the same 
bridge.

> 2) can i connect tot he batman mesh essid to get access the base lan?

Using non mesh aware clients? No.

batman-adv is a layer on top of the adhoc layer and clients that don't 
understand batman-adv cannot decode this extra layer information.

Kind regards,
	Sven

[1] http://linuxwireless.org/en/users/Documentation/iw/vif/

--nextPart2867242.4eRTA2f5x7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPzv+0AAoJEF2HCgfBJntGGvQP/1rsNeTCHilcCTjKSiJGKHpQ
NGWsJ7BK8/qrM8HvsneR5RPp3VFsHD7T36ZrZaUd26unCVqBSnqxry1XcozJ2Tou
S7Do3G5hQwES0yMJMgbJgovs1WoVG3wKcHOaSh83gFw7hiuCgOIqtEAa+/y9pisy
MRIkst1rD2JWKP7iR4Jif8W9O3V9cRcpGna0+6CurWGI0KCaPQq521Xnpv8hPkR9
eAjeSO8kS0Y54F0mhKUrFVrz+5GYPGGL70J3lD9obfg5I8+w/LF/hy+mvQzrEEa+
d5HGUsVLQBpvKD4JYcrHBEfJNHAURK8dA8mxshA+mhf6ys+WCVrOm6XD3gKoalE3
s0WIThhEJ0xktilDUby+VD38nDaez4kTH8MvBAwos7blP+HuWxKC3wDP+FDzDFCk
+/ysNexJKEblFze//yVhrQJ7H5L+JMxQLnIKZPMrR4oKv8V0gfTKa9WbT2eqLy/q
90C4NaIZp56usRGO0O6kigpUke5aLnGRw596MZxxNWThjoVoeTVsuw8zvpqc3dmi
wqPVIyZ94fJ5RUCooSHpnf14dlocQcVnX3xvtPr6vKwpk0nqdKlE4LVSir3Oq/ms
+MTQDdB1uVZELHoyI97x80HZEVLkYkq8U7OAdEzQdbXar2tOdZkDJ43XczlTSCcD
dRUH51p8bmiQwMNLZkk7
=UPI5
-----END PGP SIGNATURE-----

--nextPart2867242.4eRTA2f5x7--

