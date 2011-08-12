Return-Path: <ordex@autistici.org>
Date: Fri, 12 Aug 2011 18:02:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110812160217.GB22361@ritirata.org.org>
References: <4E42C546.7010003@inti.gob.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4E42C546.7010003@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] Multiple DHCP Gateways
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

Hello and thank you for sharing your gw experience with us,

On Wed, Aug 10, 2011 at 02:52:06PM -0300, gtolon@inti.gob.ar wrote:
> Hi
[CUT]
> However, when the original gateway becomes 
> worse than the alternative, and the client chooses the new one as 
> preferred (observed with batctl gwl) i noticed that the subsequent 
> request DHCP messages are sent to the original server, even if it 
> doesn´t have the best link.
> 
> I guess that´s because these subsequent DHCP requests are made as 
> Unicast to the original server and so Batman doesn´t redirect them, 

Unicast renewal requests are "dropped" only if the TQ towards the destination is
smaller than the "current_GW_TQ - GW_THRESHOLD" (GW_THRESHOLD = 50).
To clarify:


In your topology you have three nodes: A, B and C. A and C are GWs. A is the
current best GW for B and B got an IP from the DHCP server running on A. Then
the link A <--> B becomes worse than B <--> C. At this point Batman-adv will
drop a DHCP unicast renewal request directed to A 

if and only if TQ(C) - TQ(A) > 50

Is this condition verified in your topology when your are observing the renewal
DHCP packets?

I hope I've been clear. :-)

> but 
> i wonder how this behavior affects the network balance, because the 
> computers would get tied always to the original DHCP and IP default 
> gateway even if they moved, right?

As above. Clients will keep the same GW as long as the link is still "usable"
(difference on TQs greater than 50)

> 
> Thank you very much

Thank you too,
Antonio
