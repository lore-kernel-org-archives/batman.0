Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Issue with bridging LAN and mesh network
Date: Sun, 16 Feb 2020 19:39:33 +0100
Message-ID: <1873965.jgP86xNRV2@sven-edge>
In-Reply-To: <CAFF9uhp7M94yAPhWnpUkBwLzQa8rgxMGdBYU2CNQ203QtJZs9g@mail.gmail.com>
References: <CAFF9uhp7M94yAPhWnpUkBwLzQa8rgxMGdBYU2CNQ203QtJZs9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2366461.Inl0MMqdo2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Emilie Meyer <emiliemeyer1016@gmail.com>

--nextPart2366461.Inl0MMqdo2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 16 February 2020 19:20:41 CET Emilie Meyer wrote:
[...]
> root@OpenWrt:~# ip link set eth0 master mesh-bridge
> ip: either "dev" is duplicate, or "master" is garbage
[...]
> OpenWrt 18.06.4, r7808-ef686b7292
[...]

The problem here is that the networking/libiproute/iplink.c from busybox in 
OpenWrt 18.04.x has the code for the "master" interface configuration 
disabled. You have various options:

* switch to the current release OpenWrt 19.07
* switch from busybox's iplink applet to the package ip-full
* use netifd to configure the interfaces [1]
* use brctl to configure the bridge slave interfaces

     brctl addif mesh-bridge eth0

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config#Batman-adv-201300-till-20190-2
--nextPart2366461.Inl0MMqdo2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl5JjGUACgkQXYcKB8Em
e0YXkg//dvj84BXzINr83MJt4ghOSeNX92qPXyj3n4UeGDdzktp3grMsZPUp2TWP
/Pdpd0XtG5Xlvf31t665U7giViLAbHj5z80SA07uoNLKZ0JvrnjyGcudsypAgk5g
zBHfXyMg748Z5saKL3FrTGca4KnNc6Oqr/3epAOw+tf73C3bg5I1b46MXuDQp0cT
+eMeOTNK6Wr280jcOqzAjmM+ny5VLgEnJhKocloZKDN78/LgjSkh3d0ghFSfkfm5
Z+iODn9/v1M+BnEFibXFMG9NGcwyrOs1lLBuuyfCLpZXqXZT7ed/AyJkx46tfcUU
rSpfAwtkqwSDTLnQeXbZxLeGJZ/t5UCLAPmBZWnwnrtBW3wU+7tXVOaYyBsthNJK
xCY+45o1NS07S4JCsoPZYJPYcWQuAk4ymWnPEMmwL5+i09+H4JKgpOVjI7cErgJ+
BwANQtAau7yyQgFIIbP+F4MA6cBd7F9wFfYjj1HRmcpBOESD12ww9oPuDi2qjKI3
zy+YPFQ02TQicjHiHaW2amEYgGAHe8SPZFFqFsNUboNcyMm+vBAGEuyYjuWY5T8/
SEPh1fd3uVvxyn918rB4XWMiDAqVup6rqkgBvhqHixe0FeTBV7i7YOhrKk3+LTzL
+BaQdiXTeMO9qGcMXwjwKtgNFhgpHk1JBkjwTQdrUtT0rppeE4o=
=rmo+
-----END PGP SIGNATURE-----

--nextPart2366461.Inl0MMqdo2--



