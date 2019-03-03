Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 15:52:03 +0100
Message-Id: <20190303145207.19864-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/4] alfred/batman-adv/batctl: Drop license
 boilerplate
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

All files got a SPDX-License-Identifier since a while. All the
required information about the license conditions can be found in
LICENSES/.

Drop the duplicated information now. I would also like to drop the 
copyright line with the contributers because it is most of the time just
wrong. But there is no precedence in the kernel (I could find) and the
FSFE REUSE specification proposes a a statement which basically no one
is using:

    This file is part of project X. It’s copyrighted by the contributors
    recorded in the version control history of the file, available from
    its original location http://git.example.com/X/filename.c

And this would also make it harder for other projects to write a bill
of material.

Sven Eckelmann (2):
  alfred: Switch packet.h license to MIT
  alfred: Drop license boilerplate
  batctl: Drop license boilerplate
  batman-adv: Drop license boilerplate


 alfred/Makefile                                   | 14 --------------
 alfred/alfred.h                                   | 14 --------------
 alfred/batadv_query.c                             | 14 --------------
 alfred/batadv_query.h                             | 14 --------------
 alfred/batadv_querynl.c                           | 14 --------------
 alfred/batadv_querynl.h                           | 14 --------------
 alfred/batman_adv.h                               | 18 ------------------
 alfred/bitops.h                                   | 18 +-----------------
 alfred/client.c                                   | 14 --------------
 alfred/debugfs.c                                  | 14 --------------
 alfred/debugfs.h                                  | 14 --------------
 alfred/gpsd/Makefile                              | 14 --------------
 alfred/gpsd/alfred-gpsd.c                         | 14 --------------
 alfred/gpsd/alfred-gpsd.h                         | 14 --------------
 alfred/hash.c                                     | 14 --------------
 alfred/hash.h                                     | 14 --------------
 alfred/list.h                                     | 14 --------------
 alfred/main.c                                     | 14 --------------
 alfred/netlink.c                                  | 14 --------------
 alfred/netlink.h                                  | 14 --------------
 alfred/netsock.c                                  | 14 --------------
 alfred/packet.h                                   | 16 ++--------------
 alfred/recv.c                                     | 14 --------------
 alfred/send.c                                     | 14 --------------
 alfred/server.c                                   | 14 --------------
 alfred/unix_sock.c                                | 14 --------------
 alfred/util.c                                     | 14 --------------
 alfred/vis/Makefile                               | 14 --------------
 alfred/vis/vis.c                                  | 14 --------------
 alfred/vis/vis.h                                  | 14 --------------
 batctl/Makefile                                   | 14 --------------
 batctl/aggregation.c                              | 14 --------------
 batctl/allocate.h                                 | 14 --------------
 batctl/ap_isolation.c                             | 14 --------------
 batctl/backbonetable.c                            | 14 --------------
 batctl/bat-hosts.c                                | 14 --------------
 batctl/bat-hosts.h                                | 14 --------------
 batctl/batadv_packet.h                            | 12 ------------
 batctl/batman_adv.h                               | 18 ------------------
 batctl/bisect_iv.c                                | 14 --------------
 batctl/bisect_iv.h                                | 14 --------------
 batctl/bonding.c                                  | 14 --------------
 batctl/bridge_loop_avoidance.c                    | 14 --------------
 batctl/claimtable.c                               | 14 --------------
 batctl/dat_cache.c                                | 14 --------------
 batctl/debug.c                                    | 14 --------------
 batctl/debug.h                                    | 14 --------------
 batctl/debugfs.c                                  | 14 --------------
 batctl/debugfs.h                                  | 14 --------------
 batctl/distributed_arp_table.c                    | 14 --------------
 batctl/event.c                                    | 14 --------------
 batctl/fragmentation.c                            | 14 --------------
 batctl/functions.c                                | 14 --------------
 batctl/functions.h                                | 14 --------------
 batctl/gateways.c                                 | 14 --------------
 batctl/genl.c                                     | 12 ------------
 batctl/genl.h                                     | 14 --------------
 batctl/gw_mode.c                                  | 14 --------------
 batctl/hash.c                                     | 14 --------------
 batctl/hash.h                                     | 14 --------------
 batctl/hop_penalty.c                              | 14 --------------
 batctl/icmp_helper.c                              | 14 --------------
 batctl/icmp_helper.h                              | 14 --------------
 batctl/interface.c                                | 14 --------------
 batctl/isolation_mark.c                           | 14 --------------
 batctl/list.h                                     | 18 +-----------------
 batctl/log.c                                      | 14 --------------
 batctl/loglevel.c                                 | 14 --------------
 batctl/main.c                                     | 14 --------------
 batctl/main.h                                     | 14 --------------
 batctl/mcast_flags.c                              | 14 --------------
 batctl/multicast_forceflood.c                     | 14 --------------
 batctl/multicast_mode.c                           | 14 --------------
 batctl/nc_nodes.c                                 | 14 --------------
 batctl/neighbors.c                                | 14 --------------
 batctl/netlink.c                                  | 14 --------------
 batctl/netlink.h                                  | 14 --------------
 batctl/network_coding.c                           | 14 --------------
 batctl/orig_interval.c                            | 14 --------------
 batctl/originators.c                              | 14 --------------
 batctl/ping.c                                     | 14 --------------
 batctl/routing_algo.c                             | 14 --------------
 batctl/statistics.c                               | 14 --------------
 batctl/sys.c                                      | 14 --------------
 batctl/sys.h                                      | 14 --------------
 batctl/tcpdump.c                                  | 14 --------------
 batctl/tcpdump.h                                  | 14 --------------
 batctl/throughputmeter.c                          | 14 --------------
 batctl/traceroute.c                               | 14 --------------
 batctl/transglobal.c                              | 14 --------------
 batctl/translate.c                                | 14 --------------
 batctl/translocal.c                               | 14 --------------
 batman-adv/Makefile                               | 13 -------------
 batman-adv/compat-include/linux/average.h         | 12 ------------
 batman-adv/compat-include/linux/build_bug.h       | 12 ------------
 batman-adv/compat-include/linux/cache.h           | 12 ------------
 batman-adv/compat-include/linux/compiler.h        | 12 ------------
 batman-adv/compat-include/linux/ethtool.h         | 12 ------------
 batman-adv/compat-include/linux/eventpoll.h       | 12 ------------
 batman-adv/compat-include/linux/fs.h              | 12 ------------
 batman-adv/compat-include/linux/if_bridge.h       | 12 ------------
 batman-adv/compat-include/linux/igmp.h            | 12 ------------
 batman-adv/compat-include/linux/list.h            | 12 ------------
 batman-adv/compat-include/linux/netdevice.h       | 12 ------------
 batman-adv/compat-include/linux/netlink.h         | 12 ------------
 batman-adv/compat-include/linux/nl80211.h         | 12 ------------
 batman-adv/compat-include/linux/seq_file.h        | 12 ------------
 batman-adv/compat-include/linux/skbuff.h          | 12 ------------
 batman-adv/compat-include/linux/timer.h           | 12 ------------
 batman-adv/compat-include/linux/types.h           | 12 ------------
 batman-adv/compat-include/linux/uaccess.h         | 12 ------------
 batman-adv/compat-include/net/addrconf.h          | 12 ------------
 batman-adv/compat-include/net/cfg80211.h          | 12 ------------
 batman-adv/compat-include/net/genetlink.h         | 12 ------------
 batman-adv/compat-include/net/ip6_checksum.h      | 12 ------------
 batman-adv/compat-include/net/netlink.h           | 12 ------------
 batman-adv/compat-include/uapi/linux/eventpoll.h  | 12 ------------
 batman-adv/compat-include/uapi/linux/nl80211.h    | 12 ------------
 batman-adv/compat-sources/Makefile                | 12 ------------
 batman-adv/compat-sources/net/core/skbuff.c       |  5 -----
 batman-adv/compat-sources/net/ipv4/igmp.c         |  5 -----
 batman-adv/compat-sources/net/ipv6/mcast_snoop.c  | 13 -------------
 batman-adv/compat.h                               | 15 ---------------
 batman-adv/gen-compat-autoconf.sh                 | 12 ------------
 batman-adv/include/uapi/linux/batadv_packet.h     | 12 ------------
 batman-adv/include/uapi/linux/batman_adv.h        | 18 ------------------
 batman-adv/net/batman-adv/Kconfig                 | 12 ------------
 batman-adv/net/batman-adv/Makefile                | 13 -------------
 batman-adv/net/batman-adv/bat_algo.c              | 12 ------------
 batman-adv/net/batman-adv/bat_algo.h              | 12 ------------
 batman-adv/net/batman-adv/bat_iv_ogm.c            | 12 ------------
 batman-adv/net/batman-adv/bat_iv_ogm.h            | 12 ------------
 batman-adv/net/batman-adv/bat_v.c                 | 12 ------------
 batman-adv/net/batman-adv/bat_v.h                 | 12 ------------
 batman-adv/net/batman-adv/bat_v_elp.c             | 12 ------------
 batman-adv/net/batman-adv/bat_v_elp.h             | 12 ------------
 batman-adv/net/batman-adv/bat_v_ogm.c             | 12 ------------
 batman-adv/net/batman-adv/bat_v_ogm.h             | 12 ------------
 batman-adv/net/batman-adv/bitarray.c              | 12 ------------
 batman-adv/net/batman-adv/bitarray.h              | 12 ------------
 batman-adv/net/batman-adv/bridge_loop_avoidance.c | 12 ------------
 batman-adv/net/batman-adv/bridge_loop_avoidance.h | 12 ------------
 batman-adv/net/batman-adv/debugfs.c               | 12 ------------
 batman-adv/net/batman-adv/debugfs.h               | 12 ------------
 batman-adv/net/batman-adv/distributed-arp-table.c | 12 ------------
 batman-adv/net/batman-adv/distributed-arp-table.h | 12 ------------
 batman-adv/net/batman-adv/fragmentation.c         | 12 ------------
 batman-adv/net/batman-adv/fragmentation.h         | 12 ------------
 batman-adv/net/batman-adv/gateway_client.c        | 12 ------------
 batman-adv/net/batman-adv/gateway_client.h        | 12 ------------
 batman-adv/net/batman-adv/gateway_common.c        | 12 ------------
 batman-adv/net/batman-adv/gateway_common.h        | 12 ------------
 batman-adv/net/batman-adv/hard-interface.c        | 12 ------------
 batman-adv/net/batman-adv/hard-interface.h        | 12 ------------
 batman-adv/net/batman-adv/hash.c                  | 12 ------------
 batman-adv/net/batman-adv/hash.h                  | 12 ------------
 batman-adv/net/batman-adv/icmp_socket.c           | 12 ------------
 batman-adv/net/batman-adv/icmp_socket.h           | 12 ------------
 batman-adv/net/batman-adv/log.c                   | 12 ------------
 batman-adv/net/batman-adv/log.h                   | 12 ------------
 batman-adv/net/batman-adv/main.c                  | 12 ------------
 batman-adv/net/batman-adv/main.h                  | 12 ------------
 batman-adv/net/batman-adv/multicast.c             | 12 ------------
 batman-adv/net/batman-adv/multicast.h             | 12 ------------
 batman-adv/net/batman-adv/netlink.c               | 12 ------------
 batman-adv/net/batman-adv/netlink.h               | 12 ------------
 batman-adv/net/batman-adv/network-coding.c        | 12 ------------
 batman-adv/net/batman-adv/network-coding.h        | 12 ------------
 batman-adv/net/batman-adv/originator.c            | 12 ------------
 batman-adv/net/batman-adv/originator.h            | 12 ------------
 batman-adv/net/batman-adv/routing.c               | 12 ------------
 batman-adv/net/batman-adv/routing.h               | 12 ------------
 batman-adv/net/batman-adv/send.c                  | 12 ------------
 batman-adv/net/batman-adv/send.h                  | 12 ------------
 batman-adv/net/batman-adv/soft-interface.c        | 12 ------------
 batman-adv/net/batman-adv/soft-interface.h        | 12 ------------
 batman-adv/net/batman-adv/sysfs.c                 | 12 ------------
 batman-adv/net/batman-adv/sysfs.h                 | 12 ------------
 batman-adv/net/batman-adv/tp_meter.c              | 12 ------------
 batman-adv/net/batman-adv/tp_meter.h              | 12 ------------
 batman-adv/net/batman-adv/trace.c                 | 12 ------------
 batman-adv/net/batman-adv/trace.h                 | 12 ------------
 batman-adv/net/batman-adv/translation-table.c     | 12 ------------
 batman-adv/net/batman-adv/translation-table.h     | 12 ------------
 batman-adv/net/batman-adv/tvlv.c                  | 12 ------------
 batman-adv/net/batman-adv/tvlv.h                  | 12 ------------
 batman-adv/net/batman-adv/types.h                 | 12 ------------
 187 files changed, 4 insertion(+), 2436 deletions(-)

-- 
2.20.1

