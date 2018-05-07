Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon,  7 May 2018 03:38:21 +0200
Message-Id: <20180507013823.739-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 0/2] batman-adv: DHCP snooping for DAT
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

Finally, after some more discussions, observations and better
overall understanding of the issue we were able to find a
successful strategy for ARP reduction.

The result is an additional patch which introduces a generic
"noflood mark" which for ARP Requests means a prevention of
the DAT broadcast fallback.

At Freifunk Darmstadt, an 800 nodes setup, these two patches
were tested for a month with no issues so far but a significant
amount of ARP Request reduction.

More details can be found here:

https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping

Regards, Linus


