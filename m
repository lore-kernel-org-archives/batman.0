From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batmand dies
Date: Fri, 12 Sep 2008 17:13:04 +0200
References: <8c906fa50809120528g269e7831s979246af74b29427@mail.gmail.com>
In-Reply-To: <8c906fa50809120528g269e7831s979246af74b29427@mail.gmail.com>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IcoyIu5RYgbBNR3"
Message-Id: <200809121713.12525.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--Boundary-00=_IcoyIu5RYgbBNR3
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 12 September 2008 14:28:34 Gustavo Lindberg wrote:
> I just tried the last openwrt-kamikaze trunk with the svn v1109 of batman
> on ubnt NS2. Batmand die as follows:
>
>  root@OpenWrt:~# batmand -d 4 -g 5000 ath2
> WARNING: You are using the unstable batman branch. If you are interested in
> *using* batman get the latest stable release !
> Interface activated: ath2
> Using interface ath2 with address 5.0.0.1 and broadcast address
> 5.255.255.255
> B.A.T.M.A.N. 0.3-beta (compatibility version 5)
> [        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
> address
> [        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
> address
> [...]
>
> No iptables rules at all. All policy ACCEPT.
>
> BATGAT dont crash anymore,
Because it never reaches the code section were the crash happened before. 
Please use the patch "Don't validate hardware address of batgat gate0 device" 
to reenable batgat on post 2.6.23 kernels. If you want to help to find the 
problem of the "original" crash, please apply the patch inside this mail.

Best regards,
	Sven Eckelmann

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjKhwgACgkQqQGwKVlMoDupNgCdE/WdiJk8MNUTTY1DiG880ZyM
48cAoKe+Eh6F9GPwJ4SEimVVOP8LQvOd
=2xgS
-----END PGP SIGNATURE-----

--Boundary-00=_IcoyIu5RYgbBNR3
Content-Type: text/x-patch; charset="iso-8859-15";
	name="0001-Add-debug-code-to-find-nanostation2-batgat-crashes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Add-debug-code-to-find-nanostation2-batgat-crashes.patch"

=46rom ee7bcbab9c9f20df8cbb6939804309bfe447f16f Mon Sep 17 00:00:00 2001
=46rom: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 12 Sep 2008 17:11:20 +0200
Subject: [PATCH] Add debug code to find nanostation2 batgat crashes.

=2D--
 batman/linux/modules/gateway.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 11693e2..423e06b 100644
=2D-- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -395,7 +395,11 @@ static int packet_recv_thread(void *data)
 						tmp_entry =3D kmalloc(sizeof(struct free_client_data), GFP_KERNEL);
 						if(tmp_entry !=3D NULL) {
 							tmp_entry->gw_client =3D client_data;
+							printk("list_add_b; tmp_entry pointers (%p, %p, %p)\n", &tmp_entry-=
>list, tmp_entry->list.prev, tmp_entry->list.next);
+							printk("list_add_b; free_client_list pointers (%p, %p, %p)\n", &fre=
e_client_list, free_client_list.prev, free_client_list.next);
 							list_add(&tmp_entry->list,&free_client_list);
+							printk("list_add_a; tmp_entry pointers (%p, %p, %p)\n", &tmp_entry-=
>list, tmp_entry->list.prev, tmp_entry->list.next);
+							printk("list_add_a; free_client_list pointers (%p, %p, %p)\n", &fre=
e_client_list, free_client_list.prev, free_client_list.next);
 						} else
 							DBG("can't add free gw_client to free list");
=20
@@ -657,7 +661,11 @@ static struct gw_client *get_ip_addr(struct sockaddr_i=
n *client_addr)
 	list_for_each_entry_safe(entry, next, &free_client_list, list) {
 		DBG("use free client from list");
 		gw_client =3D entry->gw_client;
+		printk("free client_b; entry pointers (%p, %p, %p)\n", &entry->list, ent=
ry->list.prev, entry->list.next);
+		printk("free client_b; free_client_list pointers (%p, %p, %p)\n", &free_=
client_list, free_client_list.prev, free_client_list.next);
 		list_del(&entry->list);
+		printk("free client_a; entry pointers (%p, %p, %p)\n", &entry->list, ent=
ry->list.prev, entry->list.next);
+		printk("free client_a; free_client_list pointers (%p, %p, %p)\n", &free_=
client_list, free_client_list.prev, free_client_list.next);
 		kfree(entry);
 		break;
 	}
=2D-=20
1.6.0.1


--Boundary-00=_IcoyIu5RYgbBNR3--
