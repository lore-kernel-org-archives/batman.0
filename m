Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 21 May 2018 12:49:23 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180521104923.GI7162@otheros>
References: <20180515155908.23839-1-linus.luessing@c0d3.blue>
 <1566281.z125QuZFdt@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1566281.z125QuZFdt@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Snoop DHCPACKs for DAT
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

On Fri, May 18, 2018 at 11:46:56PM +0200, Sven Eckelmann wrote:
> Please correct me but it doesn't look like these things have anything to do 
> with the batman-adv packet format. And userspace should also not use the 
> bootp_pkt/batadv_dhcp_packet definition from batman-adv.

Good point. I could move those to distributed-arp-table.c to avoid
userspace from using it.

> And what about the basically duplicated bootp_pkt definition in net/ipv4/
> ipconfig.c?

Would it make sense to first add it to distributed-arp-table.c and
then later I'd make a second patch directly for netdev@ to unify those?

Alternatively, if I'd get a partial ACK for the DHCP snooping approach
in general here, I could do it the other way round, of course.

Regards, Linus
