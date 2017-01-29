Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 29 Jan 2017 05:39:39 +0100
Message-Id: <20170129043943.11341-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 0/4] Broadcast Avoidances,
	Neighborhood Hash
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

Here's the second broadcast avoidance patchset.

Hopefully, those two patchsets together should be an automatic
approach and replacement for the (non-upstream) no-rebroadcast flag
patch and the cases it is currently used for.

Documentation:
* https://www.open-mesh.org/projects/batman-adv/wiki/Broadcast-Avoidances

Branch:
* https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/neighhash

Regards, Linus

-----

Known limitations: Avoidance potential is not fully detected in a setup with
a mix of 100MBit/s and 1000MBit/s capable, wired nodes.

If rebroadcast avoidance is strictly needed in such mixed, wired setups, too,
then people could consider setting the throughput_override option of BATMAN V.

