Message-ID: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
Date: Sat, 25 Oct 2008 18:33:24 -0200
From: "Julio Cesar Puigpinos" <jcpuigpinos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
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

I'm having a problem with bmxd-r1138, bat0 is not created in client node.
The gateway is started with: -o 2000 -g 5000 ath2. The client is
started with: -o 2000 -r 1 ath2

Using this parameters and OpenWRT Kamikaze r13037 in the nodes:

    client                 gw                     Works?
bmxd-r1062        bmxd-r1062             YES
bmxd-r1138        bmxd-r1062             YES
bmxd-r1138        bmxd-r1138             NO
bmxd-r1062        bmxd-r1138             NO


In bmxd-r1138, the debug level 3 shows:
[     39193] select() indicated changed interface status! Going to
check interfaces!
[     76206] change route to 5.255.22.64     via 5.255.22.64       1 /
100 (prev. via 0.0.0.0           0)
[     76212] found new gateway 5.255.22.64, announced by 5.255.22.64
-> class: 49 - 4MBit/1024KBit, new supported tunnel types TWT, OWT
[    200028] using default tunnel to GW 5.255.22.64 (gw_flags: 49,
packet_count: 610, gw_product: 238144)
[    200030] add_default_route()...
[    200039] client_to_gw_tun() started...
[    200039] send ip request to gateway: 5.255.22.64, preferred IP: 0.0.0.0
[    201228] send ip request to gateway: 5.255.22.64, preferred IP: 0.0.0.0
                  .............. 57 the same message .......................
[    270269] send ip request to gateway: 5.255.22.64, preferred IP: 0.0.0.0
[    270470] Gateway client - disconnecting from unresponsive gateway
(5.255.22.64) !
[    270470] Gateway client - Maximum number of tunnel ip requests send !
[    270471] Gateway client - Ignoring this GW for 10 secs
[    270471] terminating client_to_gw_tun thread: is_aborted(): NO,
curr_gateway: 4801776, deleted: 0
[    270475] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
(table 68): No such process
[    270482] Error - can't delete tun device: Inappropriate ioctl for device


If you need more info, let me know it.


                     Saludos, Julio

-- 
www.lugro-mesh.org.ar/        Wireless Mesh Networks Group
www.lugro.org.ar                         GNU/Linux User Group Rosario, Argentina
Slackware rulez :P             www.slackware.org
NO A LA MATRICULA!!!: http://noalamatricula.wordpress.com/
