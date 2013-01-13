Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Jan 2013 13:12:20 +0100
Message-ID: <1405827.5RSdDMUrGW@sven-desktop.home.narfation.org>
In-Reply-To: <1358070663-8226-6-git-send-email-lindner_marek@yahoo.de>
References: <201301131750.39338.lindner_marek@yahoo.de>
 <1358070663-8226-1-git-send-email-lindner_marek@yahoo.de>
 <1358070663-8226-6-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2234986.aZIXttljrr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 6/6] batman-adv: Allow to modify slaves
	of soft-interfaces through rntl_link
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2234986.aZIXttljrr
Content-Type: multipart/mixed; boundary="nextPart5133453.ZdPOq9PEyU"
Content-Transfer-Encoding: 7Bit


--nextPart5133453.ZdPOq9PEyU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 13 January 2013 17:51:03 Marek Lindner wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The sysfs configuration interface of batman-adv to add/remove slaves of an
> soft-iface is not deadlock free and doesn't follow the currently common way
> to modify slaves of an interface.
> 
> An additional configuration interface though rtnl_link is introduced which
> provides easy device adding/removing with tools like "ip":
> $ ip link set dev eth0 master bat0
> $ ip link set dev eth0 nomaster
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---


Master setting is missing. This is necessary on current kernels to use 
"nomaster" of ip. Also reference counting is br0ken. An example patch is added 
(just to explain things... it will not apply directly).

Kind regards,
	Sven
--nextPart5133453.ZdPOq9PEyU
Content-Disposition: attachment; filename="fixes.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="fixes.patch"

diff --git a/hard-interface.c b/hard-interface.c
index 5e2655d..c5c7f13 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -349,9 +349,16 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
+	ret = netdev_set_master(hard_iface->net_dev, hard_iface->soft_iface);
+	if (ret) {
+		batadv_err(hard_iface->soft_iface,
+			   "Device %s failed to set master\n", iface_name);
+		goto err_dev;
+	}
+
 	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
 	if (ret < 0)
-		goto err_dev;
+		goto err_enable;
 
 	hard_iface->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
@@ -361,7 +368,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
 		bat_priv->num_ifaces--;
 		hard_iface->if_status = BATADV_IF_NOT_IN_USE;
-		goto err_dev;
+		goto err_enable;
 	}
 
 	hard_iface->batman_adv_ptype.type = ethertype;
@@ -400,6 +407,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 out:
 	return 0;
 
+err_enable:
+	netdev_set_master(hard_iface->net_dev, NULL);
 err_dev:
 	dev_put(soft_iface);
 err:
@@ -450,6 +459,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 		batadv_softif_destroy(hard_iface->soft_iface, NULL);
 
 	hard_iface->soft_iface = NULL;
+	netdev_set_master(hard_iface->net_dev, NULL);
 	batadv_hardif_free_ref(hard_iface);
 
 out:
diff --git a/soft-interface.c b/soft-interface.c
index 3cafe50..54eb2a9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -486,12 +486,15 @@ static int batadv_add_slave(struct net_device *dev,
 			    struct net_device *slave_dev)
 {
 	struct batadv_hard_iface *hard_iface;
+	int ret;
 
 	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
 	if (!hard_iface || hard_iface->soft_iface != NULL)
 		return -EINVAL;
 
-	return batadv_hardif_enable_interface(hard_iface, dev->name);
+	ret = batadv_hardif_enable_interface(hard_iface, dev->name);
+	batadv_hardif_free_ref(hard_iface);
+	return ret;
 }
 
 /**
@@ -509,6 +512,7 @@ static int batadv_del_slave(struct net_device *dev,
 		return -EINVAL;
 
 	batadv_hardif_disable_interface(hard_iface, BATADV_IF_CLEANUP_KEEP);
+	batadv_hardif_free_ref(hard_iface);
 	return 0;
 }
 

--nextPart5133453.ZdPOq9PEyU--

--nextPart2234986.aZIXttljrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQ8qSkAAoJEF2HCgfBJntGIgUP/jk30TT0apjxfQrELip2c2um
IHrmo024WG6eiCK6B9zeTJYoIbDeo4UkGFSYbp9LQ3Pxxe433N7O14tNHCSxU5Ku
UAJepbegRylXssbJiaMmWAODn6koraseKmGNeK7iMOevjp4QU6C2p33sDMAiwAoj
yCsX1oKVFC/CjXApiaOZ2PdBqLSV/VV0hHYwS34LJheYxSFFKNC6fHK9d6tdNNyD
cvn4PXiS5t10PRnysnC3w4zc0MJWtJITCqbWsPBUg6JiSgc4MEUp0CVpcPvDuiYn
/PD0kAiubPwDGNJ/hf3359GhQcZ/PQpsLRXg7DDNYSMvJqp53ecj+mNpZd2H1rWP
/AY4droCUweYS3Ws9DHU8YqwpbuY72+KZ86xLFqbVWRQdcce9QonQP8iyxasSS/4
ZbzPtruSwR9Ag4n0mwr3Bp09ITgsGtF0t52gg5Ge143wsm4qOcrtcvQJobFgh7L5
wvwHl1/OCyxvkH1UH3/uCsseEd/ILU36B102ROufwgzjl1on9kfInjkApR8BEkl9
mUPH1eUyG5KKIZaNx2+jrgqpCkKlQ1QleXUmV30eiHJTf2MdhfJoV7SdjzJmr3h1
2DZ71kdGRDKQj+0x9KoOHadNucbn0ZYPYW3XH3ydCRnxEBk9LtLluaqsp/gonuuq
jHVL9mEa23h+UG+1Rpma
=RHv4
-----END PGP SIGNATURE-----

--nextPart2234986.aZIXttljrr--

