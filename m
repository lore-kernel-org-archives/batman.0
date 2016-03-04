Return-Path: <andrew@lunn.ch>
Date: Fri, 4 Mar 2016 16:21:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160304152132.GV15541@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Use of ref_get_unless_zero() ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi

I'm sometimes getting a crash after removing a hard interface when the
batadv_send_outstanding_bat_org_packet() is called in a work queue.
It calls

static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
                                        int packet_len, unsigned long send_time,
                                        bool direct_link,
                                        struct batadv_hard_iface *if_incoming,
                                        struct batadv_hard_iface *if_outgoing,
                                        int own_packet)
{
        struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
        struct batadv_forw_packet *forw_packet_aggr;
        unsigned char *skb_buff;
        unsigned int skb_size;

        if (!kref_get_unless_zero(&if_incoming->refcount))
                return;

        if (!kref_get_unless_zero(&if_outgoing->refcount))
                goto out_free_incoming;


Given that we have:

static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
{
        kref_put(&hard_iface->refcount, batadv_hardif_release);
}

does using kref_get_unless_zero() make sense? If it is zero, hasn't it
been freed by the kref_put that set it to zero?

Thanks
	Andrew


