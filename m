Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  9 Feb 2014 04:48:52 +0100
Message-Id: <1391917738-4483-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv13 0/6] Basic Multicast Optimizations
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

This is the thirteenth revision of the basic multicast optimization patches.

Changes in v13 include, thanks to the additional feedback of Simon and Marek:

* Using counting for unsnoopable addresses, too, instead of unconditionally
  disabling optimizations
* Using an orig_node pointer instead of passing a want_all_list around in
  batadv_interface_tx()
  -> removed batadv_send_skb_via_mcast()
* fixed the bug which was present in batadv_mcast_want_all_ipv{4,6}_node_get()
  (now: batadv_mcast_want_ipv{4,6}_count)

Also:
* Updated copyright year to 2014 in multicast.{c,h}

Cheers, Linus

