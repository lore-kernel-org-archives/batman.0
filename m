Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 7 Jul 2016 15:40:52 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160707134052.GD7076@otheros>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
 <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
 <20160707092436.GH5978@prodigo.lan> <20160707101442.GC7076@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160707101442.GC7076@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Snoop DHCPACKs for DAT
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

On Thu, Jul 07, 2016 at 12:14:42PM +0200, Linus Lüssing wrote:
> Hi Antonio,
> 
> > have you tried applying this patch on one of your servers and measure the local
> > effect? (i.e. if the number of BRD ARP req is reduced or not?)
> 
> I had queried Martin Weinelt just yesterday, they will test it on
> a 500 nodes compat-v15 setup soon :).

Unfortunately, looks like this patch has no effect regarding the
ARP Request overhead. According to batctl log, DHCPACKs are
snooped, but still 84.3% of all ARP Requests come from the three
DHCP servers / gateways.

These ARP Requests come encapsulated in a batman-adv broadcast
packet type.

Hm, anyone having another idea what might still be causing these
ARP Requests?

Cheers, Linus
