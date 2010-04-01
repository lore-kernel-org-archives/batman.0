Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Fri, 2 Apr 2010 00:54:02 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2154895.EMyYLzcQ1Q";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004020054.08840.clemens-john@gmx.de>
Subject: [B.A.T.M.A.N.] Problems connecting VPN and WLAN with Batman-adv
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

--nextPart2154895.EMyYLzcQ1Q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I use batman advanced ("# batctl o" says "B.A.T.M.A.N. adv 0.2.1-beta r1578=
")=20
on OpenWrt trunk and I have the following problem:

I have a wlan meshnetwork in ahdemo mode which uses batman. The meshnetwork=
 is=20
used by clients without batman and therefore I have another network on the=
=20
same wifi device in ad mode which is bridged with bat0.
The bridge is in the network 10.18.1.0/24.

I think its like described in http://www.open-mesh.org/wiki/batman-adv-quic=
k-
start-guide

The problem is, that I have a vpn network on tap0 (10.18.0.0/24) and I dont=
=20
know how I can link this two networks/interfaces to each other with batman.
I tried to assign tap0 to batman, but this doesnt work.

I want to be able to ping hosts that uses batman in the vpn and in the wlan=
=20
network. How can I do this?

My configs look like this:

=2D--------------
/etc/conf/network
=2D--------------
config 'interface' 'loopback'
        option 'ifname' 'lo'
        option 'proto' 'static'
        option 'ipaddr' '127.0.0.1'
        option 'netmask' '255.0.0.0'

config 'interface' 'lan'
        option 'proto' 'dhcp'
        option 'ifname' 'eth0'

config 'interface' 'mesh'
        option 'type' 'bridge'
        option 'ifname' 'ath0 bat0'
        option 'proto' 'static'
        option 'ipaddr' '10.18.1.101'
        option 'netmask' '255.255.255.0'

config 'interface' 'vpn'
        option 'proto' 'none'
        option 'ifname' 'tap0'

=2D--------------
/etc/conf/wireless
=2D--------------
config wifi-device  wifi0
        option type     atheros
        option channel  6

config wifi-iface
        option device   wifi0
        option mode     ahdemo
        option bssid    02:CA:FF:EE:BA:BE

config wifi-iface
        option device   wifi0
        option mode     ap
        option ssid     oldenburg.freifunk.net

=2D--------------
/etc/conf/batman-adv-kernelland
=2D--------------
config batman-adv-kernelland general
        option interface                'ath1 tap0'
        option originator_interval
        option log_level

thanks
=46loh1111

--nextPart2154895.EMyYLzcQ1Q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAku1JAsACgkQZgdHbA22lqNd2gCgnns+ovgTlQ8g78OioFhnQw/p
wyEAniAJ96/4Yr5Qej84yhw2RVpeuqC8
=fozv
-----END PGP SIGNATURE-----

--nextPart2154895.EMyYLzcQ1Q--
