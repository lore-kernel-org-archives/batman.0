Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:34 +0100
Message-Id: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 00/10] batctl: Fixes and minor cleanup
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

From: Sven Eckelmann <sven@narfation.org>

Hi,

today I had the unpleasent experience to receive [1] to a lot of PDF files
which seem to contain some reports of the Klocwork static code analysis tool.
Most of the stuff was nonsense about memory/resource leaks (even when it
stored in some kind of structure one line before). I gathered the only
interesting portions and prepared some patches for them.

The last two patches are actually not really bug fixes but are about code
which completely killed the static analyzer. I didn't like the code in
the last patch (looked to complex for something relatively easy) and thus
I've just replaced it.

WARNING: these things were only compile tested

Kind regards,
	Sven


[1] not unpleasent due to some issue reports. But going through several
    hundred false positives wasn't my goal for today. Someone at seems to
    get paid by false-positives which this Klocworks analyzer produces
    (and there are really some braindead ones - even clang's static analyzer
    looks like a genius against some of these reports) 

Sven Eckelmann (10):
  batctl: Print dummy value when localtime failed
  batctl: Handle failure during hash_iterator allocation
  batctl: Handle allocation error for path_buff
  batctl: Handle nlmsg_alloc errors
  batctl: Handle nl_socket_alloc errors
  batctl: Handle nl_cb_alloc errors
  batctl: Free nl_sock on genl_ctrl_resolve error
  batctl: Free nl_sock when if_nametoindex failed
  batctl: tcpdump: Fix types for for TT v1
  batctl: Simplify concatenation of pathnames

 bat-hosts.c |  4 +---
 functions.c |  8 ++------
 hash.c      |  3 +++
 netlink.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 sys.c       | 15 +++++++++++++++
 tcpdump.c   |  9 +++++++--
 6 files changed, 83 insertions(+), 19 deletions(-)

-- 
2.11.0

