Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1496077749.5980.2.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Mon, 29 May 2017 19:09:09 +0200
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [batctl] compiling with gcc 7.1.0: there are some
 notes and warnings
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

Hi all,

it's nothing to worry about but since 2011 I always noticed a clean
compile run of your code. Now with gcc 7.1.0 there are some warnings
and notes that might interest you:

~ LANG=C make
    CC bat-hosts.o
    CC debugfs.o
    CC debug.o
    CC functions.o
    CC genl.o
    CC hash.o
    CC icmp_helper.o
    CC interface.o
    CC ioctl.o
    CC main.o
    CC netlink.o
    CC ping.o
    CC sys.o
In file included from sys.c:37:0:
sys.c: In function 'handle_ra_setting':
sys.h:33:25: warning: '%s' directive output may be truncated writing up to 255 bytes into a region of size 185 [-Wformat-truncation=]
 #define SYS_IFACE_PATH  "/sys/class/net"
                         ^
sys.h:38:30: note: in expansion of macro 'SYS_IFACE_PATH'
 #define SYS_ROUTING_ALGO_FMT SYS_IFACE_PATH"/%s/mesh/routing_algo"
                              ^~~~~~~~~~~~~~
sys.c:480:38: note: in expansion of macro 'SYS_ROUTING_ALGO_FMT'
   snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name);
                                      ^~~~~~~~~~~~~~~~~~~~
sys.h:38:46: note: format string is defined here
 #define SYS_ROUTING_ALGO_FMT SYS_IFACE_PATH"/%s/mesh/routing_algo"
                                              ^~
sys.c:480:3: note: 'snprintf' output between 34 and 289 bytes into a destination of size 200
   snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    CC tcpdump.o
    CC tp_meter.o
tp_meter.c: In function 'tp_meter':
tp_meter.c:502:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   printf("CANCEL received: test aborted\n");
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tp_meter.c:504:2: note: here
  case BATADV_TP_REASON_COMPLETE:
  ^~~~
    CC traceroute.o
    CC translate.o
    LD batctl

# batctl -v
batctl 2017.1-1-g3069ca8 [batman-adv: 2017.1-4-g2149d80d]

It's really nothing bad at all. gcc 7.1.0 is somehow a little bit
capricious but with more suggestions to make cleaner code.

best regards

Philipp
