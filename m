Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 19 Jan 2014 22:22:44 +0100
Message-Id: <1390166566-8315-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v6 0/2] eth_hdr/skb_reset_mac_header changes
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

In v6, a few more vlan_/eth_hdr()s were added to [PATCH 1/2] which are
also along the interface_tx path:

-----
bridge_loop_avoidance.c:
@@ -872,7 +872,7 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
gateway_client.c:
@@ -680,7 +680,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
@@ -689,7 +689,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
@@ -728,7 +728,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
send.c:
@@ -254,7 +254,7 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
soft-interface.c
@@ -180,7 +180,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
----

Cheers, Linus


