Return-Path: <andrew@lunn.ch>
Date: Mon, 18 Jan 2010 16:24:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100118152426.GG7844@lunn.ch>
References: <20100104182710.GA24091@pandem0nium>
	<20100117201558.GA8696@pandem0nium>
	<201001181931.22344.lindner_marek@yahoo.de>
	<20100118151552.GE7844@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100118151552.GE7844@lunn.ch>
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

>   CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/gateway_common.c
> /home/lunn/batman/trunk/batman-adv-kernelland/gateway_common.c:28:6: warning: symbol 'kbit_to_gw_srv_class' was not declared. Should it be static?
>   CHECK   /home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c
> /home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:27:1: warning: symbol 'gw_list' was not declared. Should it be static?
> /home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:28:1: warning: symbol 'curr_gw_lock' was not declared. Should it be static?
> /home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:29:1: warning: symbol 'gw_list_lock' was not declared. Should it be static?
> /home/lunn/batman/trunk/batman-adv-kernelland/gateway_client.c:227:6: warning: context imbalance in 'gw_node_update' - wrong count at exit
 
Ah, just took a closer look. These are probably from Marek, not
Simon. 

gw_node_update() is missing a rcu_read_unlock(); before the return
inside the list_for_each_entry_rcu() loop. The others are less
serious, but should be corrected as well.

       Andrew
