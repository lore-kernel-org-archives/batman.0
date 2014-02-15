Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 15 Feb 2014 17:47:48 +0100
Message-Id: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv14 0/6] Basic Multicast Optimizations
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is the fourteenth revision of the basic multicast optimization patches.

Changes in v14 include:

* fixed compilation for CONFIG_BATMAN_ADV_MCAST=n (issue was introduced by v13)
* fixed potential null pointer exception (moved ethhdr assignment in
  batadv_mcast_forw_mode() to after the check methods / pskb_may_pull()s)
* removed flag-list-"helper" functions
* removed methods which were performing both counting and orig_node retrieval
  in batadv_mcast_forw_mode(), instead doing that in two logical, seperate
  sections in batadv_mcast_forw_mode()

Cheers, Linus

