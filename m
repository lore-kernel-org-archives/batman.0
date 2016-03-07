Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 7 Mar 2016 05:21:48 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160307042148.GF3229@otheros>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1456867148-31883-4-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
 interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Andrew,

Thanks for looking into this!

It seems some compat code might be missing, compiling against a
3.19 kernel fails for me (4.0 to 4.4 compiles fine):

-----
rm -f compat-autoconf.h*
make -C /lib/modules/3.2.0-4-amd64/build M=/home/tux/dev/batman-adv-t_x/net/batman-adv CONFIG_BATMAN_ADV=m CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n INSTALL_MOD_DIR=updates/net/batman-adv/ clean
make[1]: Entering directory `/usr/src/linux-headers-3.2.0-4-amd64'
  CLEAN   /home/tux/dev/batman-adv-t_x/net/batman-adv/.tmp_versions
make[1]: Leaving directory `/usr/src/linux-headers-3.2.0-4-amd64'
make clean  0,26s user 0,18s system 66% cpu 0,666 total
/home/tux/dev/batman-adv-t_x/gen-compat-autoconf.sh /home/tux/dev/batman-adv-t_x/compat-autoconf.h
/usr/bin/make -C /home/tux/dev/linux/headers/usr/src/linux-headers-3.19.0+ M=/home/tux/dev/batman-adv-t_x/net/batman-adv CONFIG_BATMAN_ADV=m CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n INSTALL_MOD_DIR=updates/net/batman-adv/    modules
make[1]: Entering directory `/home/tux/dev/linux/headers/usr/src/linux-headers-3.19.0+'
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/bat_iv_ogm.o
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/bitarray.o
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/bridge_loop_avoidance.o
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/debugfs.o  
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/distributed-arp-table.o
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/fragmentation.o
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/gateway_client.o
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/gateway_common.o
  CC [M]  /home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.o
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c: In function ‘batadv_mutual_parents’:
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c:107:48: error: ‘const struct rtnl_link_ops’ has no member named ‘get_link_net’  
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c:108:40: error: ‘const struct rtnl_link_ops’ has no member named ‘get_link_net’
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c:109:48: error: ‘const struct rtnl_link_ops’ has no member named ‘get_link_net’
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c:110:40: error: ‘const struct rtnl_link_ops’ has no member named ‘get_link_net’
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c: In function ‘batadv_is_on_batman_iface’:
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c:150:54: error: ‘const struct rtnl_link_ops’ has no member named ‘get_link_net’
/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.c:151:38: error: ‘const struct rtnl_link_ops’ has no member named ‘get_link_net’
make[2]: *** [/home/tux/dev/batman-adv-t_x/net/batman-adv/hard-interface.o] Error 1
make[1]: *** [_module_/home/tux/dev/batman-adv-t_x/net/batman-adv] Error 2
make[1]: Leaving directory `/home/tux/dev/linux/headers/usr/src/linux-headers-3.19.0+'
make: *** [all] Error 2
-----

Regards, Linus
