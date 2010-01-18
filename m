Return-Path: <andrew@lunn.ch>
Date: Mon, 18 Jan 2010 16:15:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100118151552.GE7844@lunn.ch>
References: <20100104182710.GA24091@pandem0nium>
	<20100117201558.GA8696@pandem0nium>
	<201001181931.22344.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001181931.22344.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add bonding functionality
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

On Mon, Jan 18, 2010 at 07:31:22PM +0800, Marek Lindner wrote:
> 
> Hi,
> 
> > i've just committed this patch in revision 1551, as no further comments and
> >  critiques came in. I would consider this patch rather simple, and as
> >  experimental feature it is switched off by default anyways ... :)
> > 
> > I've changed only a small thing in the committed patch: When neighbors are
> >  purged, the bonding candidate list gets updated instead of bonding
> >  switched off.
> 
> did not have the time to go through your patch in much detail. I just scrolled 
> over it and stumbled over routing.c line 1018. I guess you wanted to write:
> spin_*un*lock_irqsave(&orig_hash_lock, flags);

sparce finds this and a couple of other minor things:

make -C /lib/modules/2.6.32.2/build REVISION=1551 M=/home/lunn/batman/trunk/batman-adv-kernelland PWD=/home/lunn/batman/trunk/batman-adv-kernelland -j 1 modules
make[1]: Entering directory `/overflow/src/linux-2.6.32.2'
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/main.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/proc.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/send.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/routing.c
/home/lunn/batman/trunk/batman-adv-kernelland/routing.c:966:5: warning: context imbalance in 'recv_unicast_packet' - different lock contexts for basic block
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/soft-interface.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/device.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/translation-table.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/bitarray.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/hash.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/ring_buffer.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/vis.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/hard-interface.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/aggregation.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/originator.c
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/gateway_common.c
/home/lunn/batman/trunk/batman-adv-kernelland/gateway_common.c:28:6: warning: symbol 'kbit_to_gw_srv_class' was not declared. Should it be static?
  CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c
/home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:27:1: warning: symbol 'gw_list' was not declared. Should it be static?
/home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:28:1: warning: symbol 'curr_gw_lock' was not declared. Should it be static?
/home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:29:1: warning: symbol 'gw_list_lock' was not declared. Should it be static?
/home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:227:6: warning: context imbalance in 'gw_node_update' - wrong count at exit

    Andrew
