Date: Sun, 16 Nov 2008 17:41:59 +0200
From: jan@aims.ac.za
Message-ID: <20081116154159.GC26177@aims.ac.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] ipkg install batman over ssh: postinst fails
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
To: b.a.t.m.a.n@open-mesh.net

Hi

I have a mesh running freifunk =E2=92=88.6.32 nodes.
I am using the recommended batman0.2 ipkg to test it next
to OLSR. (Is there no ipkg package and source for 0.3 or=20
the latest stable?)

When I did two nodes manually, I installed and set the network
migration, and saw some batman packets.

Then I went ahead and scripted an install on all the nodes (about 40).

It goes, with dropbear authorized_keys, for each node in $NEWIP:

   # batman sources
   scp root@${NEWIP}:/etc/ipkg.conf .
   patch ipkg.conf < ipkg.conf.patch
   scp ipkg.conf root@${NEWIP}:/etc/ipkg.conf
   # update
   ssh root@${NEWIP} ipkg update
   #########################
   ## Admin > B.A.T.M.A.N ##
   #########################
   # Setup screen for migration of network (only shown once)
   /usr/sbin/nvram set ff_bat_netmig=3D172.18/172.16
   # B.A.T.M.A.N. on/off
   /usr/sbin/nvram set ff_bat_start=3D1
   # WLAN as eth1:bat on subnet/16
   /usr/sbin/nvram set ff_bat_ran_on=3D1
   /usr/sbin/nvram set ff_bat_ran_if=3Deth1:bat
   /usr/sbin/nvram set ff_bat_ran_ip=3D172.16.174.97
   /usr/sbin/nvram set ff_bat_ran_pf=3D16
   # LAN as br0 on subnet/29
   /usr/sbin/nvram set ff_bat_lan_on=3D1
   /usr/sbin/nvram set ff_bat_lan_if=3Dbr0
   /usr/sbin/nvram set ff_bat_lan_ip=3D192.168.174.97
   /usr/sbin/nvram set ff_bat_lan_pf=3D29
   # local internet-bandwidth: This is not internet gw
   /usr/sbin/nvram set ff_bat_gw_uplink=3D0
   # common used gateway: set no default route
   /usr/sbin/nvram set ff_bat_gw_choose=3D0
   # preferred gateway
   # HNA
   # Viz server
   # Hello interval (1000ms)
   # Deamon stakeout
   # Stop OLSR
   # Open firewall
   /usr/sbin/nvram set ff_bat_fw=3D1
   #
   ##########################
   ## Admin > B.A.T.M.A.N. ##
   ##########################
   ssh root@${NEWIP} ipkg install batmand freifunk-batman
   # Next line must be done with expect else nvram not found
   # For now it will be done on reboot anyway
   #ssh root@${NEWIP} /etc/init.d/S66batman restart

The nvram command is usually not in the path over an ssh like
that (not interactive, passing the command to ssh as an argument)
thus I use /usr/sbin/nvram. In two places this fail:

The freifunk-batman package:
Unpacking freifunk-batman...Done.
Configuring freifunk-batman...//usr/lib/ipkg/info/freifunk-batman.postinst:=
 10: nvram: not found
//usr/lib/ipkg/info/freifunk-batman.postinst: 10: nvram: not found
Done.

And the S66batman restart, which I did manually.

Now the batman runs, has all the nvram settings, though I didn't go through
the prompt for network migration via the web interface -- I did the script
above. But there are no batman neigbours or messages shown on the info/stat=
us
pages in the web interface. Even when I reinstalled freifunk-batman two nod=
es manually,
that is via interactive ssh, and there was no error, I am still getting no =
batman
neigbours shown.

Usually I do such cases with expect, there are several places
in my freifunk install / upgrade script where I do this).=20
The long term answer is clearly? a trx/bin image of our own.

In the meantime, do I have to reflash them, install batman manually
or with expect? Can I even do that or what happens when the web interface
is used to enter the network migration info, which is now not happening
on my nodes?

regards,
Jan


