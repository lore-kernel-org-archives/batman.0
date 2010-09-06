Return-Path: <sven.eckelmann@gmx.de>
Date: Mon, 6 Sep 2010 09:30:46 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20100906073046.GA6973@sven-atom.lazhur.ath.cx>
References: <1283729393-13842-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1283729393-13842-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Always synchronize rcu's on
 module shutdown
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 06, 2010 at 01:29:53AM +0200, Linus L=C3=BCssing wrote:
> During the module shutdown procedure in batman_exit(), a rcu callback is
> being scheduled (batman_exit -> hardif_remove_interfaces ->
> hardif_remove_interfae -> call_rcu). However, when the kernel unloads
> the module, the rcu callback might not have been executed yet, resulting
> in a "unable to handle kernel paging request" in __rcu_process_callback
> afterwards, causing the kernel to freeze.
> Therefore, we should always flush all rcu callback functions scheduled
> during the shutdown procedure.

I am really irritated by your patch. I would have expected that you add a
synchronyze_rcu in batman_exit and that was it. Instead I see a synchronize=
_net
added and a synchronize_net/-_rcu removed from mesh_free. This doesn't seem=
 to
match at all. Could you please explain further why it is implemented that w=
ay?

thanks,
	Sven

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJMhJilAAoJEF2HCgfBJntGXI8P/AhhRu4qzN4z9jK/A1Z2kTf7
RRHTHWRARDtfwNb/YSPiHp11PoBx3OcebJRyWN7MJil31+hq7kCTVi50URJHtqRp
90izafI2ASBGEgtpuh/nCoiT40mD25BKrEhYupnH0a61OQaa3PWYW7T5Bmlql5me
85jsTgpgAks5fprTSUXMBnuM7QX15jNLizNj1PAt661I/WFzF8qANfnnfG3c+q13
G6bPTwUaECun2uTdjO9EUAFEpU5LZ8+XiMCasIyTCK+XK2/yiTLHxMNOSgRnrPII
02eGb5d/+/SU6OFoMGu5ZZDrDGFuTee5gc74ek2hFQ3lVWal+EPxdui2B2M4mD+V
SdkFKuaHR9m7mByJMbMTG8KN5zZQRcsD4xT9oafiy+AMByWAO6ecn6ap0adLOU1R
+oY1BiTKevVNXkAQ9drKAotoO0N6tv+u17hhTOhm6A1yjY3bHOybzOoSljF1LVjh
pqWyZWR0DD/Yuz2HWGMi2hoBsjA9BtNIbMP34ubuoAxcnTMzAJyFh4/DhvbGqfXV
sL0yxlfw4AM3NqdsZbT3B5VWfe2f0brK1Te8XwOigQ9P9esT4hGpL4DkhO6V1sce
HmesI8heD83ZOlGEGDKeKs5JO5ozhemug/+NPeSs4S4YVfi8mJ2Tgsaw+KMWSXeq
2M4REm75wltkcQYPR57/
=ll7f
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
