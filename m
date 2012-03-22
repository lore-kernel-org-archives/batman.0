Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 23 Mar 2012 05:50:30 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201203222250.31309.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [RFC] ELP
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


Hi,

after numerous infrastructure changes in the past weeks ELP[1] slowly
approaches the state in which it can be tested and later merged into the
master branch.

Since its initial implementation by Linus Luessing last summer a lot has
happened:
 * the internal protocol name (NDP) was renamed to ELP
 * the old code was rebased on top of the master branch
 * the ELP code was adjusted to the many changes in our code base
 * several patches were squashed together
 * brought the code in sync with the spec
 * numerous bugs were fixed (buffer overflow, writing into random memory
   sections, memory corruptions, locking issues, elp packet length checks,
   printing the neighbors of the requested mesh only and many more)

The ELP code is the first to use the recently introduced routing protocol
abstraction. It is not compiled into batman-adv by default, therefore you
need to compile with CONFIG_BATMAN_ADV_BATMAN_V=y or modify the makefile.

Once the batman-adv kernel module has been loaded you can check for the
existence of the new routing protocol:

cat /sys/kernel/debug/batman_adv/routing_algos 
Available routing algorithms:
BATMAN IV
BATMAN V

To activate B.A.T.M.A.N. V (ELP) you should run the following command *before*
adding any interface via batctl:

echo -n "BATMAN V" > /sys/module/batman_adv/parameters/routing_algo

Caveats:
 * ELP alone (without OGMv2) isn't very useful because ELP handles single hop
 neighbors only. So don't expect to convert your entire mesh network to
 B.A.T.M.A.N. V just yet.
 * The batman-adv routing protocol abstraction still lacks the translation
 table integration which is why the following patches will lead to a kernel
 crash. The ELP repository[2] contains a patch to disable the TT propagation
 partially to mitigate the problem until a proper solution has been
 implemented.

Any comments and suggestions are appreciated. 

Regards,
Marek


[1] http://www.open-mesh.org/wiki/batman-adv/ELP
[2] http://git.open-mesh.org/?p=marek/batman-adv.git;a=shortlog;h=refs/heads/elp


Linus Luessing (5):
      batman-adv: ELP - adding basic infrastructure
      batman-adv: ELP - creating neighbor structures, updating LQs
      batman-adv: ELP - exporting neighbor list via debugfs
      batman-adv: ELP - adding sysfs parameter for elp interval
      batman-adv: ELP - add configurable minimum ELP packet length (def: 300B)

 Makefile                   |    2 +
 Makefile.kbuild            |    1 +
 README.external            |    1 +
 bat_algo.h                 |    6 +
 bat_debugfs.c              |   16 ++
 bat_sysfs.c                |    8 +
 bat_v_elp.c                |  500 ++++++++++++++++++++++++++++++++++++++++++++
 gen-compat-autoconf.sh     |    1 +
 hard-interface.c           |    7 +
 main.c                     |    1 +
 packet.h                   |   20 ++-
 sysfs-class-net-batman-adv |   13 ++
 types.h                    |   15 ++
 13 files changed, 590 insertions(+), 1 deletions(-)
