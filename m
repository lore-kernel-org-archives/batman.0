Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 17 Jun 2010 01:10:17 +0200
References: <1276727961-18719-1-git-send-email-sven.eckelmann@gmx.de>
	<201006170042.13864.sven.eckelmann@gmx.de>
	<201006170052.18499.lindner_marek@yahoo.de>
In-Reply-To: <201006170052.18499.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2986221.h33El4Kh2Y";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006170110.19294.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use rx_handler_data pointer
	to store net_bridge_port pointer
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart2986221.h33El4Kh2Y
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Thursday 17 June 2010 00:42:11 Sven Eckelmann wrote:
> > I have merged it into maint (not into trunk), but somebody has to think
> > about  a way to to get it working on older kernels. This patch has to
> > made on top of that patch to get it integrated into the next kernel
> > merge window.
>=20
> The code in question has not been enabled yet. It is just there as a
> possibility and could be enabled if it makes sense. I would say the one
> activating this code has to deal with the backward compatibility when it
> happens, ok ?  :-)

Ok, let me rewrite it:

I have merged it into maint (not in trunk) but somebody has to think about a
way to get it working on olders kernel _when he wants to enable it the
future_. This patch has to made on top of that patch to get it integrated in
_one of the next kernel merge windows_.

Better? :P


Personally I would do it with something like that:

diff --git a/batman-adv-kernelland/compat.h b/batman-adv-kernelland/compat.h
index 8302a58..c503a51 100644
=2D-- a/batman-adv-kernelland/compat.h
+++ b/batman-adv-kernelland/compat.h
@@ -232,3 +232,14 @@ static inline struct net_device_stats *dev_get_stats(s=
truct net_device *dev)
 }
=20
 #endif /* < KERNEL_VERSION(2, 6, 29) */
+
+#if !defined(IFF_BRIDGE_PORT)
+
+#ifdef netdev_isbridged
+#undef netdev_isbridged
+#endif
+
+#define netdev_isbridged(netdev) \
+	((net_dev)->br_port !=3D NULL)
+
+#endif /* defined(IFF_BRIDGE_PORT) */
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland=
/hard-interface.c
index 0773420..183d4c9 100644
=2D-- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -74,7 +74,7 @@ static int is_valid_iface(struct net_device *net_dev)
 #endif
=20
 	/* Device is being bridged */
=2D	/* if (net_dev->priv_flags & IFF_BRIDGE_PORT)
+	/* if (netdev_isbridged(net_dev))
 		return 0; */
=20
 	return 1;
diff --git a/batman-adv-kernelland/hard-interface.h b/batman-adv-kernelland=
/hard-interface.h
index 1e5fc3e..9bd1837 100644
=2D-- a/batman-adv-kernelland/hard-interface.h
+++ b/batman-adv-kernelland/hard-interface.h
@@ -38,3 +38,8 @@ int batman_skb_recv(struct sk_buff *skb,
 				struct net_device *orig_dev);
 int hardif_min_mtu(void);
 void update_min_mtu(void);
+
+#ifndef netdev_isbridged
+#define netdev_isbridged(netdev) \
+	((net_dev)->priv_flags & IFF_BRIDGE_PORT)
+#endif




Best regards,
	Sven

--nextPart2986221.h33El4Kh2Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMGVnaAAoJEF2HCgfBJntGM64P/1/TAjRRAXZFGSHpngKF3m6C
TUtjyz+oDOilkSOXh/vT0N9rQXF4QjiwjDlPRpX/yTkpORk+ooGw2mbna/Bnvg6e
oofeylODEUZGK9Ssk8MidDUdHkuyBUpFaRP30Kn97nc3IVp5dng67u+5kUCEvl/F
xS0sEAV2e4yYp5zpBtd/yiI6/DS3xLXgk344AMojGu2h2yx6wqXkM/WZkQ+O/7QE
jT4POhuxg+cdh0+fkiYFgHUnr6QBoF1TApxkJavJnBoRM9Uomo9VoGsUWZfjvK2G
L5x6y5u3+cNFzYrLIqhVG68eejOCfCgU38CJiL3/lEwrNAkkJeUs6JuS8Eg1xlSC
z1gk4DMbsfPtZcu5F9OKk8ZZaZVEwmDh9vrnTrqRqA85kF9GI3MET/kUPw8QjuYl
rHzEdr7CxePSsLEs1XRKGy1NtInKCGCFazS4Mtbp5JmH0gsbxZ8I4BvKvTkvXf7D
bmQU8jNWqYHb9R3XjMeZxFG0GcNRlS9QlYPwHuhYYq98epOe8TZGg2Z2K/5ugRd4
pORxbqqLm2LYb8ZU55A9Pwj5kQj7t7xWCG1vxIHNVmyffdxKi0I3EXbkalhTJe3r
Cp2iT/W6VenXs9y1tBK4Flg0q6fBxFGKaW0wSC58fVgklEElqkyP3/kr7ndzcPx+
LTqKijfSnS3Qb+7WxI9B
=gQ2X
-----END PGP SIGNATURE-----

--nextPart2986221.h33El4Kh2Y--
