Return-Path: <a@unstable.cc>
Date: Sun, 8 May 2016 23:41:59 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160508154159.GB14515@prodigo>
References: <1462664836-21988-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <1462664836-21988-1-git-send-email-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: init ELP tweaking options
 only once
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 08, 2016 at 07:47:16AM +0800, Marek Lindner wrote:
> The ELP interval and throughput override interface settings are initializ=
ed
> with default settings on every iface_enable() call. Thus, the user space
> configuration is overridden as soon as an interface is going down and
> coming up again.

iface_enable() is only invoked when an interface is added to the mesh. Up a=
nd
Down should trigger a iface_activate/deactivate() only.

Have you seen the userspace settings being reverted ?

Cheers,

--=20
Antonio Quartulli

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXL15HAAoJEJ4aZjxxc6bKD18QAMUcvnVbFZjURTakP6p1GRyf
hLu47pcNET73GtM0ED7DQLhVdRlcYw8/pV58tUCrZD71hGxcKPNwW3C06E9NFwF+
6jJ5gyPqdpXnuh2D9Rg5op0ptNhxQ6DiAszbdWipS31TdvMasXF9kWxjgy7R/bb3
7ee8XR/zS+RCPO3yrJkSILKJiVfRjxUm/WAKghvAI8xumVYTCK95lS1DSizmlcrg
gRS32I0MIg/2K1Fb6CWTne4YmGHAirMEs1te9eXCFJIr1mjLo1ggdmgdwp7HFS9J
SBm65hvVec21JPBwbbMQGhk12B+YPvxQSUqJw+65Lbobd9PR8Zz0JPwVrD0jHWyR
dfigOjcJe0sJFUJWzYnmPGLw+YvIgO8/F1ObaMjlIpFViEiGMtAvOUYTVQWZNFhz
WBSSp28CfpI9vr7VFCnwzoWdRABy7vgwuJkiNhr5nRZeDNUkgtHW4T7xV7kr0i70
IoV1L8YnVLQro+0dYm3abF8fL6BeKpeo0ebbgmLeeyKmgNhDNXOSTqq9+SwCHfgi
vNQBav/pOt31VIYKfALWrIGRGmpnHctY5TI7dBmEdRpYZCPCjRxoESkhr8xkPFS4
uzTH5eog71AhqME12QVuHKUGgXNxVhC5eEBgbsgTPrzR+5AFFfsQsGGolrRAU1vL
wRgHWSFeYISlgZbSAYtu
=HJIz
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
