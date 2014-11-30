Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417354504.8367.14.camel@katze>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 30 Nov 2014 14:35:04 +0100
In-Reply-To: <547B0D0D.200@hundeboll.net>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net> <1417343787.5442.20.camel@katze>
 <1417346458.6337.9.camel@katze> <547B0D0D.200@hundeboll.net>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check size information when
 reassembling fragments
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
To: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Thanks Martin, hi all

There has been a crash with fragmentation disabled (I save us the
trace-back) so I did like you told me plus more:

# git clone git://git.open-mesh.org/batman-adv.git
# cd batman-adv/
# patch < ../2-frag_debug_size.patch 
patching file fragmentation.c
Hunk #1 succeeded at 217 (offset -3 lines).
Hunk #2 succeeded at 243 (offset -3 lines).
Hunk #3 succeeded at 260 with fuzz 2 (offset -3 lines).
Hunk #4 succeeded at 288 (offset -3 lines).
patch unexpectedly ends in middle of line
Hunk #5 succeeded at 301 with fuzz 1 (offset -3 lines).
# make
[ … ]
make: *** [all] Error 2
# LANG=C make
/usr/src/batman-adv/gen-compat-autoconf.sh /usr/src/batman-adv/compat-autoconf.h
make -C /lib/modules/3.17.4-gentoo/build M=/usr/src/batman-adv PWD=/usr/src/batman-adv modules
make[1]: Entering directory '/usr/src/linux-3.17.4-gentoo'
  CC [M]  /usr/src/batman-adv/fragmentation.o
/usr/src/batman-adv/fragmentation.c: In function 'batadv_frag_merge_packets':
/usr/src/batman-adv/fragmentation.c:309:20: error: 'struct batadv_frag_table_entry' has no member named 'total_size'
scripts/Makefile.build:257: recipe for target '/usr/src/batman-adv/fragmentation.o' failed
make[2]: *** [/usr/src/batman-adv/fragmentation.o] Error 1
Makefile:1373: recipe for target '_module_/usr/src/batman-adv' failed
make[1]: *** [_module_/usr/src/batman-adv] Error 2
make[1]: Leaving directory '/usr/src/linux-3.17.4-gentoo'
Makefile:53: recipe for target 'all' failed
make: *** [all] Error 2

I learned something here so I also applied this:
diff --git a/types.h b/types.h
index 462a70c..c4d7d24 100644
--- a/types.h
+++ b/types.h
@@ -132,6 +132,7 @@ struct batadv_orig_ifinfo {
  * @timestamp: time (jiffie) of last received fragment
  * @seqno: sequence number of the fragments in the list
  * @size: accumulated size of packets in list
+ * @total_size: expected size of the assembled packet
  */
 struct batadv_frag_table_entry {
 	struct hlist_head head;
@@ -139,6 +140,7 @@ struct batadv_frag_table_entry {
 	unsigned long timestamp;
 	uint16_t seqno;
 	uint16_t size;
+	uint16_t total_size;
 };
 
 /**
--
# LANG=C make
# make install
# rmmod batman_adv
# modprobe batman_adv
# batctl -v
batctl 2014.3.0 [batman-adv: 2014.3.0-44-g650251a-dirty]

# batctl if
fastd0: active
# batctl it
5000
# batctl ap
disabled
# batctl bl
enabled
# batctl dat
enabled
# batctl ag
enabled
# batctl b
disabled
# batctl f
enabled
# batctl nc
Error - can't open file '/sys/class/net/bat0/mesh/network_coding': No such file or directory
The option you called seems not to be compiled into your batman-adv kernel module.
Consult the README if you wish to learn more about compiling options into batman-adv.
# batctl mark
0x00000000/0x00000000
# batctl mm
enabled
# batctl ll
Error - can't open file '/sys/class/net/bat0/mesh/log_level': No such file or directory
The option you called seems not to be compiled into your batman-adv kernel module.
Consult the README if you wish to learn more about compiling options into batman-adv.
# batctl l
Error - can't open file '/sys/kernel/debug//batman_adv/bat0/log': No such file or directory
The option you called seems not to be compiled into your batman-adv kernel module.
Consult the README if you wish to learn more about compiling options into batman-adv.
# batctl gw
server (announced bw: 90.0/90.0 MBit)

please tell me if it’s OK that nc and l are not compiled into the
module. I’ll report, if I see something.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –

