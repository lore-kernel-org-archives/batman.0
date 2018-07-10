Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 10 Jul 2018 22:23:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180710202344.GB1525@otheros>
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
 <2744691.dbA1SKQ1ei@lafayette> <20180625172919.GA2433@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625172919.GA2433@otheros>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped
 DAT entry purge timeout in DHT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Jun 25, 2018 at 07:29:19PM +0200, Linus Lüssing wrote:
> Currently, we only update the DHT on outgoing (= into the mesh)
> ARP Replies. I'm worried that an ARP Request would never reach
> this node (B) during the whole extended timeout, therefore not
> triggering the necessary ARP Reply, therefore leaving this
> node unreachable over this whole time frame. Which would probably
> result in a lot of confusion, I guess.

Another option I was wondering about is whether we could go for
the original, simpler idea and add snooping of outgoing hw-src/IP-src
pairs from ARP Requests. And whether that could be frequent and
reliable enough to avoid confusion for the previously mentioned
scenario.

I'm also wondering why we do not snoop outgoing ARP Requests yet,
why we only snoop ARP Replies. Currently, in
batadv_dat_snoop_outgoing_arp_request() there is only a:

  batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);

to fill the local DAT cache. But something like a
"batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT);"
to update the DHT seems absent.

Am I missing something?
