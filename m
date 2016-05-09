Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 09 May 2016 21:10:44 +0800
Message-ID: <1643067.4fJX8kxc6U@voltaire>
In-Reply-To: <20160509104533.GI3945@prodigo.futur3.it>
References: <1462664836-21988-1-git-send-email-mareklindner@neomailbox.ch>
 <8890255.lVUf8VaFkP@voltaire> <20160509104533.GI3945@prodigo.futur3.it>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart50466287.icNkliXP4R";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
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

--nextPart50466287.icNkliXP4R
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 09, 2016 18:45:33 Antonio Quartulli wrote:
> > Without my patch:
> > root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval 
> > 500
> > root@OpenWrt:/# echo 700 > /sys/class/net/eth1/batman_adv/elp_interval
> > [51835.004638] batman_adv: eth1: elp_interval: Changing from: 500 to: 700
> > root@OpenWrt:/# ifconfig eth1 down && ifconfig eth1 up
> > root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval 
> > 500
> 
> Performed the same, but I cannot reproduce. I tested:
> - origin/maint:  9685688ae7dd85804aec2f6ce760611551fe9635
> - origin/master: 7608af0adebb29dc25bd8aa489ad8a2d0e4a6317
> 
> Are you sure you are not testing this with other patches applied ?

root@OpenWrt:/# batctl -v
batctl f29682c [batman-adv: 7608af0]
root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval 
500
root@OpenWrt:/# echo 700 > /sys/class/net/eth1/batman_adv/elp_interval
[ 62.176281] batman_adv: eth1: elp_interval: Changing from: 500 to: 700
root@OpenWrt:/# ifconfig eth1 down && ifconfig eth1 up
root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval 
500

Am I right assuming you're not testing with Openwrt ? I suspect it is netifd 
that removes the interface from batX entirely on ifconfig down. That might not 
be the same on your system. I can reword the commit message to not mention 
interface down if you like.

Cheers,
Marek

--nextPart50466287.icNkliXP4R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMIxUAAoJEFNVTo/uthzApYEIAII/DCs05yBNjIJusVSC3cpI
Fca80f+94HsTmuAD5CwWF33psW5FgrTRFcpLq6hwFI0B9WCnG1g8ERcspWhNSJv4
++iH6Z2/ext11rpDp/Q8jQtnBreykajuvOXCzr6/G7hCHBQXNW27vIoGEbPG/P7u
bUQl2zLzjGDInAKlziaZFGgctZB9A4FTYVb65iGItpFVbffXbFT0zDLn2JrC5MhU
Nrb9uSNlj+fI1gPbrtEaIJ5hIbOw61LhnSCcc1SLjZVgbRQsmwlsDINUoVn5AXL/
+UA/Vgfj+psRPZj78xOOemhJHW3X1lomYdqGaq0B5bp1rm9rUWzAkeRgCV2XYps=
=ad+9
-----END PGP SIGNATURE-----

--nextPart50466287.icNkliXP4R--

