Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Aug 2018 23:36:14 +0200
Message-Id: <20180810213616.23794-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] batman-adv: Continue with deprecation of
 debugfs
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

Hi,

these two changes should help batman-adv during the ongoing process of
replacing the debugfs code. We already have:

* replaced most debugfs "tables" with netlink dumpit commands
* replaced the socket file code in batctl with direct captures/injects for
  traceroute/ping
* made the debugfs code optional

These first two things were required to get it working in network namespaces.
The last point allows in theory to disable the debugfs code but distributions
will still continue to build the debugfs support for a while. The first patch
in this series will therefore log access requests to this deprecated
functionality in the kernel message buffer. This will hopefully cause more
developers to switch their tools to netlink in the near future:

    $ cat /sys/kernel/debug/batman_adv/bat0/neighbors > /dev/null 
    batman_adv: [Deprecated]: cat (pid 12053) Use of debugfs file "neighbors".
    Use genl command BATADV_CMD_GET_NEIGHBORS instead

But we also have some other functionality in batman-adv's debugfs which could
be integrated better in the rest of the kernel infrastructure: the logging.
The log ringbuffer from batman-adv is completely isolated from the rest of
the kernel even when the kernel itself already provides its own tracing
infrastructure. The tooling for the kernel infrastructure is also a lot
better and should replace the batman_adv/*/log file in batman-adv/batctl
completely - but let us postpone the removal for now.

Some examples for the usage of batadv_dbg via tracepoints can be found in the
commit message of this change. A lot more complex things are possible with
TRACE_EVENT and co but let us start now with the conversion of the already
existing messages. There is also a good introduction on LWN [1,2,3]

Kind regards,
	Sven

[1] https://lwn.net/Articles/379903/
[2] https://lwn.net/Articles/381064/
[3] https://lwn.net/Articles/383362/

Sven Eckelmann (2):
  batman-adv: Mark debugfs functionality as deprecated
  batman-adv: Provide debug messages as trace events

 Makefile                     |  3 ++
 README.external.rst          |  1 +
 compat-include/linux/fs.h    | 37 +++++++++++++++++
 gen-compat-autoconf.sh       |  1 +
 net/batman-adv/Kconfig       | 11 +++++
 net/batman-adv/Makefile      |  3 ++
 net/batman-adv/debugfs.c     | 37 +++++++++++++++++
 net/batman-adv/debugfs.h     |  6 +++
 net/batman-adv/icmp_socket.c |  3 ++
 net/batman-adv/log.c         | 19 +++++++--
 net/batman-adv/trace.c       | 22 ++++++++++
 net/batman-adv/trace.h       | 78 ++++++++++++++++++++++++++++++++++++
 12 files changed, 217 insertions(+), 4 deletions(-)
 create mode 100644 compat-include/linux/fs.h
 create mode 100644 net/batman-adv/trace.c
 create mode 100644 net/batman-adv/trace.h

-- 
2.18.0

