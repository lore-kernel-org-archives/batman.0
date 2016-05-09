Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 09 May 2016 15:32:19 +0800
Message-ID: <8890255.lVUf8VaFkP@voltaire>
In-Reply-To: <20160508154159.GB14515@prodigo>
References: <1462664836-21988-1-git-send-email-mareklindner@neomailbox.ch>
 <20160508154159.GB14515@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1528297.TkFBeBJyH4";
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1528297.TkFBeBJyH4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 08, 2016 23:41:59 Antonio Quartulli wrote:
> On Sun, May 08, 2016 at 07:47:16AM +0800, Marek Lindner wrote:
> > The ELP interval and throughput override interface settings are
> > initialized
> > with default settings on every iface_enable() call. Thus, the user space
> > configuration is overridden as soon as an interface is going down and
> > coming up again.
> 
> iface_enable() is only invoked when an interface is added to the mesh. Up
> and Down should trigger a iface_activate/deactivate() only.
>
> Have you seen the userspace settings being reverted ?

Without my patch:
root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval 
500
root@OpenWrt:/# echo 700 > /sys/class/net/eth1/batman_adv/elp_interval
[51835.004638] batman_adv: eth1: elp_interval: Changing from: 500 to: 700
root@OpenWrt:/# ifconfig eth1 down && ifconfig eth1 up
root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval 
500

With my patch:
root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval 
500
root@OpenWrt:/# echo 700 > /sys/class/net/eth1/batman_adv/elp_interval
[   33.972946] batman_adv: eth1: elp_interval: Changing from: 500 to: 700
root@OpenWrt:/# ifconfig eth1 down && ifconfig eth1 up
root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval
700

Cheers,
Marek

--nextPart1528297.TkFBeBJyH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMD0DAAoJEFNVTo/uthzApfMH/3EnC2oWWNRoMDauKhq8dM5Q
UoKofmAqiPxB0WpvnnWzzKym6XZ1vgF4QNYg4m1uzBRiPaT4BrH1YXPOJnL5MWKw
a9X+TdoAowvzfTS0Nj8if/m8n1QwZVTHHjpm41jb9A71Khw2aXpYAkyCsyd1Wz6O
00lHyrZkTYi1XhsO8mvrWxvpSNy0vgH66qPcExwRZoejrdla9jT0geHLpb3YpM4P
R0PXCg28A4pfPLkmOrsMCkZTktbaW1u8Ryi/pHs7mu52L6+rt4TG+ajiVRl2n+ne
FsLdyXe1TXxB+34Z5sDn8RzmC3xhslxtXP8FUK8yBF7i+F8lRWZTamePJsWB3TY=
=ONSe
-----END PGP SIGNATURE-----

--nextPart1528297.TkFBeBJyH4--

