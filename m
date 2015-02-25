Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Feb 2015 16:51:01 +0800
Message-ID: <3979194.JzCU5LmuJg@voltaire>
In-Reply-To: <54ED37CC.1040802@rund.freifunk.net>
References: <54ED37CC.1040802@rund.freifunk.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13854802.o9065xyD3T";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] use_count = 1 / device stuck on reboot or netifd
	restart
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart13854802.o9065xyD3T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 25, 2015 03:47:40 Ufo wrote:
> in leipzig since months we have problems with batman-adv and these
> start/stop scripts or netifd-stuff.
> 
> we thought that this might be our own special problem, because we are
> using more than one batman-adv instance (separated by vlan).
> 
> but its still there, also on openwrt-cc-trunk, now also on our
> batman-adv super-gluon-node-servers (using fastd) on virtualized
> x86-openwrt.
> so f.i. i can crash that system in a way by: etc/init.d/fastd stop
> 
> please help us and have a look at our local ticket number 23
> https://github.com/freifunk/firmware-leipzig/issues/23

I looked into the ticket but there isn't much info on how to replicate the 
issue. What is the simplest openwrt setup with which you can see 'count' 
problem? 

Please note, that I have zero experience with fastd and/or your firmware which 
is why I'd prefer to replicate the matter on plain OpenWrt.

Cheers,
Marek

--nextPart13854802.o9065xyD3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU7Yz4AAoJEFNVTo/uthzAS+IH/iDvxOMWVM8kmc3neWUYBZP5
yOYU1AclqrkWcVRpw4y2h68no69ozEQkt6COt0wMrtxlGfNoNv09zBupl/B90gWB
4Wa8f1gLVt+Var2EhNEKie1CyiU4YNcHQ2GYcEFSEk7U+ibD6n4zoA/3kd2aR6rR
HZJx+NgZLA5gbWrELC2Aa4hDM/VZrmWG521iPC5lw8h/1KaTzImm4j7N0CR1ra9G
c1+Anwr9uy+CA/euwPK3hQmGrQoVTOgtBSaS8Hec+gE26SirDbNjwj2aS0bXhp4j
6WsFqYUWMlI8Ku7TJwhXYdgdvwLfqRQyztJJNqKRSDFisKXoKBDoJJJSL2R73Ac=
=4omU
-----END PGP SIGNATURE-----

--nextPart13854802.o9065xyD3T--

