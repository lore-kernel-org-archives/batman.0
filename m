Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 20 Aug 2010 18:13:34 +0200
References: <20100820122251.GC6823@ritirata.org>
In-Reply-To: <20100820122251.GC6823@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201008201813.35202.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Question about multiple GW scenario
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

On Friday 20 August 2010 14:22:52 Antonio Quartulli wrote:
> Now, what would it happen if a client roams from A to B and sends a new
> dhcp request (cause the lease time has expired) so changing the default
> gw from X to Y? The established connections will stop to work.
> 
> I think that this is a classical level 3 issue in the hand-off
> procedure.

This is not entirely correct. When the lease expires the client will try to 
renew its lease. If it still can reach its original gateway it should not 
switch.

However, this might not be desired. The connection towards the old gateway 
might just be good enough to let the DHCP request through but is horrible when 
used for real data. In that case it would be smarter if batman dropped the 
renewal attempt to make sure the client switches.

We have to find the right balance between breaking the established connections 
and having a usable connection.

Cheers,
Marek
