Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 6 Mar 2018 16:21:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180306132145.GA10764@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [bug report] batman-adv: Ignore invalid batadv_v_gw
 during netlink send
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven.eckelmann@openmesh.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Sven Eckelmann,

The patch 011c935fceae: "batman-adv: Ignore invalid batadv_v_gw
during netlink send" from Feb 19, 2018, leads to the following static
checker warning:

	net/batman-adv/bat_iv_ogm.c:2745 batadv_iv_gw_dump_entry()
	warn: missing error code here? 'batadv_neigh_ifinfo_get()' failed. 'ret' = '0'

net/batman-adv/bat_iv_ogm.c
  2719  /**
  2720   * batadv_iv_gw_dump_entry() - Dump a gateway into a message
  2721   * @msg: Netlink message to dump into
  2722   * @portid: Port making netlink request
  2723   * @seq: Sequence number of netlink message
  2724   * @bat_priv: The bat priv with all the soft interface information
  2725   * @gw_node: Gateway to be dumped
  2726   *
  2727   * Return: Error code, or 0 on success
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is sort of out of date.

  2728   */
  2729  static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  2730                                     struct batadv_priv *bat_priv,
  2731                                     struct batadv_gw_node *gw_node)
  2732  {
  2733          struct batadv_neigh_ifinfo *router_ifinfo = NULL;
  2734          struct batadv_neigh_node *router;
  2735          struct batadv_gw_node *curr_gw;
  2736          int ret = 0;
  2737          void *hdr;
  2738  
  2739          router = batadv_orig_router_get(gw_node->orig_node, BATADV_IF_DEFAULT);
  2740          if (!router)
  2741                  goto out;
                        ^^^^^^^^
  2742  
  2743          router_ifinfo = batadv_neigh_ifinfo_get(router, BATADV_IF_DEFAULT);
  2744          if (!router_ifinfo)
  2745                  goto out;
                        ^^^^^^^^

These two were obviously changed from -EINVAL to 0 intentionally, but it
causes a static checker warning.  What really helps me when I'm
reviewing error codes is if they're explicit:

		if (!router_ifinfo) {
			ret = 0;
			goto out;
		}

  2746  
  2747          curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
  2748  
  2749          hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
  2750                            NLM_F_MULTI, BATADV_CMD_GET_GATEWAYS);
  2751          if (!hdr) {
  2752                  ret = -ENOBUFS;
                        ^^^^^^^^^^^^^^
The commit message sort of implies that only -EMSGSIZE and 0 are valid
returns but -ENOBUFS is also valid.

  2753                  goto out;
  2754          }
  2755  
  2756          ret = -EMSGSIZE;
                ^^^^^^^^^^^^^^^
  2757  
  2758          if (curr_gw == gw_node)
  2759                  if (nla_put_flag(msg, BATADV_ATTR_FLAG_BEST)) {
  2760                          genlmsg_cancel(msg, hdr);
  2761                          goto out;
  2762                  }
  2763  

Anyway, the code seems fine and I've marked it as a false positive so
it doesn't really require any action from you.  I just wanted you to
know my thinking here.

regards,
dan carpenter
