Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 14 Nov 2013 07:26:03 +0100
Message-Id: <1384410369-7437-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Basic Multicast Optimizations
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

This is the eleventh revision of the basic multicast optimization patches.

Changes:

* two non-critical compat code fixes (fixes sparse/smatch warnings):
  * typo: 'struct dev_addr_list' vs. 'struct batadv_dev_addr_list'
  * (unreachable code with netdev_master_upper_dev_get_rcu() compat code,
     patch provided by Simon)
* included multicast.h in multicast.c (fixes an sparse warning)
* substituted BATADV_UNINIT_FLAGS with a orig->capa_initialized and
  bat_priv->mcast.enabled as suggested by Marek
  (this adds patch 2/6)
* removed batadv_mcast_counter_update() to increase readability as
  suggested and provided by Marek
* rebased on top of the latest gateway code modifications:
  "batman-adv: send every DHCP packet as bat-unicast"
  (2d5b555644b22e171f3e0486abc0c2e627452d14)
  
