From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Memory Leak-batmand-exp rev1003
Date: Tue, 18 Mar 2008 14:34:53 +0100
References: <20080316145709.npkacbtvi84kssc4@webmail.ddmesh.de>
	<20080318135858.lurg563jks08kgko@webmail.ddmesh.de>
In-Reply-To: <20080318135858.lurg563jks08kgko@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200803181434.53734.axel@open-mesh.net>
Content-Transfer-Encoding: quoted-printable
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

Hi,
exactly the answer to my previously mail before it was competely send out :=
-)
Thanks for that,  I'll examine it soon...=20

regards,
axel

On Dienstag 18 M=E4rz 2008, Freifunk Dresden wrote:
> Hi again,
>
> In the test setup I run the following script which lets the batmand-exp
> consume memory in 16kbyte steps:
>
> while true;do batmand -c -r1;sleep 1;done
> The memory increase takes places with different delay. If you call
> batmand -c -r1
> at a lower rate, the increase of memory is also slower.
>
> ----
> 27657 root       1600 S   /sbin/batmand -s 10.12.0.1 -a 10.12.0.16/28 -r 1
> --t 27658 root       1600 S   /sbin/batmand -s 10.12.0.1 -a 10.12.0.16/28
> -r 1 --t 27659 root       1600 S   /sbin/batmand -s 10.12.0.1 -a
> 10.12.0.16/28 -r 1 --t Tue Mar 18 14:39:45 MEST 2008
> ----
> 27657 root       1616 S   /sbin/batmand -s 10.12.0.1 -a 10.12.0.16/28 -r 1
> --t 27658 root       1616 S   /sbin/batmand -s 10.12.0.1 -a 10.12.0.16/28
> -r 1 --t 27659 root       1616 S   /sbin/batmand -s 10.12.0.1 -a
> 10.12.0.16/28 -r 1 --t 13222 root       1616 S   /sbin/batmand -s 10.12.0=
.1
> -a 10.12.0.16/28 -r 1 --t Tue Mar 18 14:39:46 MEST 2008
>
>
> Here is the batmand -d3 log which contains one or two incrementations.
>
> root@0-2:~# batmand -cb -d3
> WARNING: You are using BatMan-eXp 0.3-alpha (compatibility version 10) !
> WARNING: Your chosen debug level (3) does not support batch mode !
> [   4241826] got request: 1
> [   4241826] Unix client closed connection ...
> [   4241847] Unix socket: got connection
> [   4241848] got request: 1
> [   4242944] got request: 1
> [   4242944] Unix client closed connection ...
> [   4270216] Unix socket: got connection
> [   4270220] got request: 2
> [   4270221] Unix socket: changing to -r 1
> [   4270310] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4270337] got request: 2
> [   4270338] Unix client closed connection ...
> [   4270429] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4270433] Gateway client - client_to_gw_tun()
> [   4270434] Trying to name tunnel to bat0 ... [   4270457] success!
> [   4270458] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4270459] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4271389] Unix socket: got connection
> [   4271393] got request: 2
> [   4271393] Unix socket: changing to -r 1
> [   4271450] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4271477] got request: 2
> [   4271478] Unix client closed connection ...
> [   4271539] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4271541] Gateway client - client_to_gw_tun()
> [   4271541] Trying to name tunnel to bat0 ... [   4271565] success!
> [   4271567] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4271567] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4272524] Unix socket: got connection
> [   4272529] got request: 2
> [   4272529] Unix socket: changing to -r 1
> [   4272560] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4272583] got request: 2
> [   4272583] Unix client closed connection ...
> [   4272840] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4272842] Gateway client - client_to_gw_tun()
> [   4272843] Trying to name tunnel to bat0 ... [   4272865] success!
> [   4272867] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4272867] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4273636] Unix socket: got connection
> [   4273638] got request: 2
> [   4273638] Unix socket: changing to -r 1
> [   4273660] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4273721] got request: 2
> [   4273722] Unix client closed connection ...
> [   4273854] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4273858] Gateway client - client_to_gw_tun()
> [   4273863] Trying to name tunnel to bat0 ... [   4273883] success!
> [   4273886] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4273886] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4274761] Unix socket: got connection
> [   4274765] got request: 2
> [   4274765] Unix socket: changing to -r 1
> [   4274880] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4274976] got request: 2
> [   4274976] Unix client closed connection ...
> [   4275089] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4275093] Gateway client - client_to_gw_tun()
> [   4275098] Trying to name tunnel to bat0 ... [   4275104] success!
> [   4275109] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4275113] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4276023] Unix socket: got connection
> [   4276024] got request: 2
> [   4276025] Unix socket: changing to -r 1
> [   4276110] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4276117] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4276155] Gateway client - client_to_gw_tun()
> [   4276160] Trying to name tunnel to bat0 ... [   4276221] success!
> [   4276226] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4276230] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4276235] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4277129] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4277133] Gateway client - client_to_gw_tun()
> [   4277138] Trying to name tunnel to bat0 ... [   4277158] success!
> [   4277160] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4277171] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4277213] Unix socket: got connection
> [   4277214] got request: 2
> [   4277214] Unix socket: changing to -r 1
> [   4277438] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4277467] got request: 2
> [   4277467] Unix client closed connection ...
> [   4278183] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4278187] Gateway client - client_to_gw_tun()
> [   4278192] Trying to name tunnel to bat0 ... [   4278212] success!
> [   4278214] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4278214] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4278515] Unix socket: got connection
> [   4278516] got request: 2
> [   4278516] Unix socket: changing to -r 1
> [   4278610] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4278637] got request: 2
> [   4278637] Unix client closed connection ...
> [   4279369] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4279374] Gateway client - client_to_gw_tun()
> [   4279379] Trying to name tunnel to bat0 ... [   4279399] success!
> [   4279404] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4279407] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4279687] Unix socket: got connection
> [   4279688] got request: 2
> [   4279688] Unix socket: changing to -r 1
> [   4279871] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4279897] got request: 2
> [   4279898] Unix client closed connection ...
> [   4280569] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4280574] Gateway client - client_to_gw_tun()
> [   4280579] Trying to name tunnel to bat0 ... [   4280600] success!
> [   4280605] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4280609] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4280946] Unix socket: got connection
> [   4280946] got request: 2
> [   4280947] Unix socket: changing to -r 1
> [   4281010] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4281037] got request: 2
> [   4281038] Unix client closed connection ...
> [   4281810] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4281815] Gateway client - client_to_gw_tun()
> [   4281819] Trying to name tunnel to bat0 ... [   4281831] success!
> [   4281836] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4281840] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4282084] Unix socket: got connection
> [   4282084] got request: 2
> [   4282085] Unix socket: changing to -r 1
> [   4282261] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4282326] got request: 2
> [   4282326] Unix client closed connection ...
> [   4283032] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4283037] Gateway client - client_to_gw_tun()
> [   4283042] Trying to name tunnel to bat0 ... [   4283061] success!
> [   4283066] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4283070] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4283376] Unix socket: got connection
> [   4283378] got request: 2
> [   4283378] Unix socket: changing to -r 1
> [   4283510] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4283556] got request: 2
> [   4283556] Unix client closed connection ...
> [   4284070] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4284075] Gateway client - client_to_gw_tun()
> [   4284081] Trying to name tunnel to bat0 ... [   4284101] success!
> [   4284106] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4284110] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4284605] Unix socket: got connection
> [   4284610] got request: 2
> [   4284610] Unix socket: changing to -r 1
> [   4284713] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4284777] got request: 2
> [   4284777] Unix client closed connection ...
> [   4285262] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4285267] Gateway client - client_to_gw_tun()
> [   4285272] Trying to name tunnel to bat0 ... [   4285292] success!
> [   4285297] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4285301] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4285826] Unix socket: got connection
> [   4285827] got request: 2
> [   4285828] Unix socket: changing to -r 1
> [   4285900] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4285992] got request: 2
> [   4285992] Unix client closed connection ...
> [   4286271] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4286277] Gateway client - client_to_gw_tun()
> [   4286282] Trying to name tunnel to bat0 ... [   4286303] success!
> [   4286308] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4286312] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4287033] Unix socket: got connection
> [   4287034] got request: 2
> [   4287035] Unix socket: changing to -r 1
> [   4287178] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4287194] got request: 2
> [   4287194] Unix client closed connection ...
> [   4287390] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4287395] Gateway client - client_to_gw_tun()
> [   4287399] Trying to name tunnel to bat0 ... [   4287421] success!
> [   4287426] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4287430] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4287750] Select returned 0 without reason!! return_time 4287760,
> curr_time 4287750
> [   4288243] Unix socket: got connection
> [   4288244] got request: 2
> [   4288245] Unix socket: changing to -r 1
> [   4288251] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4288273] got request: 2
> [   4288273] Unix client closed connection ...
> [   4288487] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4288508] Gateway client - client_to_gw_tun()
> [   4288513] Trying to name tunnel to bat0 ... [   4288534] success!
> [   4288539] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4288543] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4289325] Unix socket: got connection
> [   4289327] got request: 2
> [   4289327] Unix socket: changing to -r 1
> [   4289340] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4289367] got request: 2
> [   4289367] Unix client closed connection ...
> [   4289659] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4289661] Gateway client - client_to_gw_tun()
> [   4289666] Trying to name tunnel to bat0 ... [   4289681] success!
> [   4289683] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4289683] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4290415] Unix socket: got connection
> [   4290417] got request: 2
> [   4290418] Unix socket: changing to -r 1
> [   4290480] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4290508] got request: 2
> [   4290508] Unix client closed connection ...
> [   4290700] Select returned 0 without reason!! return_time 4290710,
> curr_time 4290700
> [   4290711] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4290713] Gateway client - client_to_gw_tun()
> [   4290714] Trying to name tunnel to bat0 ... [   4290738] success!
> [   4290740] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4290741] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4291553] Unix socket: got connection
> [   4291554] got request: 2
> [   4291555] Unix socket: changing to -r 1
> [   4291750] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4291777] got request: 2
> [   4291778] Unix client closed connection ...
> [   4291860] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4291862] Gateway client - client_to_gw_tun()
> [   4291863] Trying to name tunnel to bat0 ... [   4291885] success!
> [   4291887] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4291887] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4292823] Unix socket: got connection
> [   4292827] got request: 2
> [   4292827] Unix socket: changing to -r 1
> [   4292880] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4292883] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4292888] Gateway client - client_to_gw_tun()
> [   4292893] Trying to name tunnel to bat0 ... [   4292914] got request: 2
> [   4292914] Unix client closed connection ...
> [   4292954] success!
> [   4292959] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4292963] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4292965] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4293963] Unix socket: got connection
> [   4293964] got request: 2
> [   4293965] Unix socket: changing to -r 1
> [   4293966] got request: 2
> [   4293966] Unix client closed connection ...
> [   4294101] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4294107] Gateway client - client_to_gw_tun()
> [   4294112] Trying to name tunnel to bat0 ... [   4294132] success!
> [   4294134] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4294135] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4295015] Unix socket: got connection
> [   4295022] got request: 2
> [   4295023] Unix socket: changing to -r 1
> [   4295130] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4295146] got request: 2
> [   4295146] Unix client closed connection ...
> [   4295210] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4295211] Gateway client - client_to_gw_tun()
> [   4295212] Trying to name tunnel to bat0 ... [   4295235] success!
> [   4295236] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4295237] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4296193] Unix socket: got connection
> [   4296197] got request: 2
> [   4296197] Unix socket: changing to -r 1
> [   4296230] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4296258] got request: 2
> [   4296258] Unix client closed connection ...
> [   4296300] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4296301] Gateway client - client_to_gw_tun()
> [   4296302] Trying to name tunnel to bat0 ... [   4296313] success!
> [   4296315] searching min. MTU, so fare: 1500, current dev eth1, mtu: 15=
00
> [   4296315] searching min. MTU, so fare: 1500, current dev tbb, mtu: 1500
> [   4297306] Unix socket: got connection
> [   4297310] got request: 2
> [   4297311] Unix socket: changing to -r 1
> [   4297399] Adding default route to 10.12.0.1 (gw_flags: 17,
> packet_count: 1000, gw_product: 40000)
> [   4297421] Error - can't bind tunnel socket: Address already in use
> [   4297513] terminating client_to_gw_tun thread: is_aborted(): NO,
> curr_gateway: 0, deleted: 0
> [   4297545] got request: 2
> [   4297545] Unix client closed connection ...
>
>
> Hope you can find the reason very soon. I need to update the nodes because
> they are dead after some days because of no memory.
>
> Regards
> /Stephan
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n



