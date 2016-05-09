Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:03:34 +0200
Message-Id: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] Fragments and QoS
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

BATMAN currently does not allow QoS policies to be used with
fragmented packets. The first patch copies the skb priority from the
unfragmented packet into the fragments as they are built, so the lower
layers can then prioritise as appropriated.

The second patch places the priority into the fragment header, and
upon reception of a fragment, copies it into the skb priority, so that
when the fragment is retransmitted, it is correctly prioritised.

Andrew Lunn (2):
  batman-adv: Set skb priority in fragments
  batman-adv: Include frame priority in fragment header

 net/batman-adv/fragmentation.c | 4 +++-
 net/batman-adv/packet.h        | 7 +++++--
 net/batman-adv/routing.c       | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.8.0.rc3

