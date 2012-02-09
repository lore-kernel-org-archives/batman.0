Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 10 Feb 2012 00:41:33 +0100
Message-Id: <1328830902-11574-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 0/9] DAT: Distributed ARP Table
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

Hello people,

****
This is the **fifth** version of this patchset. The whole code has been reviewed
after some discussions on irc and here in the ml in the previous threads.
Several bugs have been spotted and fixed. Thanks Marek, Sven, Simon, Andrew and
all the others for the comments/feedbacks.

This patchset assumes that patch
[PATCH] batman-adv: add biggest_unsigned_int(x) macro
has already been applied
****

For details about the DAT mechanism, please refer to the preliminary
documentation that has already been put on the wiki[1]. A more exhaustive and
detailed documentation is going to come soon.



PatchsetV5 Additions:
------------------------

- Sanity check for ARP messages (messages containing multicast/loopback
  addresses are ignored)
- A new unicast packet type has been introduced (UNICAST_4ADDR), which contains
  the originator address and the payload type.
- Thanks to this new packet type, more and more debugging messages have been
  added. In this way it is easier to track the behaviour of DAT and it is possible to
  understand who and why added a given entry in the soft_iface ARP table.


