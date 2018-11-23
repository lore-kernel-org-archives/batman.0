Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:14:41 +0100
Message-Id: <20181123161442.13461-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 0/1] batctl: netlink restructuring, part 3
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

As mentioned earlier, the netlink config restructuring in batctl will be
splitted in multiple steps. The first step was already merged and the
RFC changes for the netlink interface in batman-adv were just posted.

It doesn't make sense to have a full implementation in batctl when
the batman-adv part is not yet in a state which survived the RFC phase. But
it also is useless to have only the batman-adv RFC part without at least
something in userspace. I have now only added the event monitor so it is
possible to at least parse the messages from the kernel.

An implementation of the sysfs config helper with netlink support (and sysfs
fallback) will be implemented when the RFC phase of the batman-adv part
doesn't require any major changes anymore.

v2:
* drop of generic config command
* reimplementation of the event command

Kind regards,
        Sven

Sven Eckelmann (1):
  batctl: Add support for config mcast group in event monitor

 batman_adv.h | 188 +++++++++++++++++++++++++++++++++++++++--
 event.c      | 234 +++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c    |  20 +++++
 3 files changed, 437 insertions(+), 5 deletions(-)

-- 
2.19.1

