Return-Path: <andrew@lunn.ch>
Date: Mon, 25 Jan 2010 07:46:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100125064651.GR24649@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100123181048.GO24649@lunn.ch>
	<20100124204212.GA4350@Sellars> <20100124210010.GB17803@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100124210010.GB17803@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
 maint)
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Jan 24, 2010 at 10:00:10PM +0100, Andrew Lunn wrote:
> On Sun, Jan 24, 2010 at 09:42:12PM +0100, Linus L??ssing wrote:
> > Hi Andrew,
> > 
> > Here is the output with the symbols inserted. I can reproduce this
> > memory leak very reliable now, by just activating the vis server
> > (didn't do that with the logs I've posted before) in a couple of
> > minutes. free is showing a nice countdown then :).
> 
> So it is vis server functionality which is leaking? If vis server is
> not enabled, there is no leak?
> 
> If so, we don't need kmemcheck. I expect just looking at the vis code
> is probably enough to find the missing free.

It looks pretty obvious:

Working our way via the call stack:

In batman_skb_recv() we have:

        case BAT_VIS:
                ret = recv_vis_packet(skb);
                break;
        default:
                ret = NET_RX_DROP;
        }
        if (ret == NET_RX_DROP)
                kfree_skb(skb);

i.e. the packet is only freed if recv_vis_packet() returns NET_RX_DROP


In recv_vis_packet() we have:
       switch (vis_packet->vis_type) {
        case VIS_TYPE_SERVER_SYNC:
                /* TODO: handle fragmented skbs properly */
                receive_server_sync_packet(vis_packet, skb_headlen(skb));
                ret = NET_RX_SUCCESS;
                break;

        case VIS_TYPE_CLIENT_UPDATE:
                /* TODO: handle fragmented skbs properly */
                receive_client_update_packet(vis_packet, skb_headlen(skb));
                ret = NET_RX_SUCCESS;
                break;

        default:        /* ignore unknown packet */
                ret = NET_RX_DROP;
                break;
        }
        return ret;

i.e. receive_client_update_packet() and receive_server_sync_packet()
need to sometime result in the packet being freed. batman_skb_recv()
will not free the packet.

void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
{
        struct vis_info *info;
        int is_new;
        unsigned long flags;
        int vis_server = atomic_read(&vis_mode);

        spin_lock_irqsave(&vis_hash_lock, flags);
        info = add_packet(vis_packet, vis_info_len, &is_new);
        if (info == NULL)
                goto end;

        /* only if we are server ourselves and packet is newer than the one in
         * hash.*/
        if (vis_server == VIS_TYPE_SERVER_SYNC && is_new) {
                memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
                if (list_empty(&info->send_list))
                        list_add_tail(&info->send_list, &send_list);
        }
end:
        spin_unlock_irqrestore(&vis_hash_lock, flags);
}

No free here. vis_packet is a pointer into the skbuf, but we never add
vis_packet to any queue here, just info is queued.

add_packet():

        info = kmalloc(sizeof(struct vis_info) + vis_info_len, GFP_ATOMIC);
        if (info == NULL)
                return NULL;

        INIT_LIST_HEAD(&info->send_list);
        INIT_LIST_HEAD(&info->recv_list);
        info->first_seen = jiffies;
        memcpy(&info->packet, vis_packet,
               sizeof(struct vis_packet) + vis_info_len);

We allocate memory can copy the contents of the packet into the
allocated memory. So again, the skbuf is not queued.

As far as i can see, the skbuf is never put on a queue. We just copy
the needed data out of it. This means the skbuf does need freeing.

I had a very quick look at receive_client_update_packet(). It seems to
have the same structure.

I will submit a fix for this soon. Is there any other similar code
which might have the same bug?

      Andrew
