Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Aug 2011 19:22:28 +0200
References: <4E42C546.7010003@inti.gob.ar>
	<20110812160217.GB22361@ritirata.org.org>
In-Reply-To: <20110812160217.GB22361@ritirata.org.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201108121922.28786.lindner_marek@yahoo.de>
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

On Friday, August 12, 2011 18:02:20 Antonio Quartulli wrote:
> In your topology you have three nodes: A, B and C. A and C are GWs. A is
> the current best GW for B and B got an IP from the DHCP server running on
> A. Then the link A <--> B becomes worse than B <--> C. At this point
> Batman-adv will drop a DHCP unicast renewal request directed to A
> 
> if and only if TQ(C) - TQ(A) > 50

Be aware that only happens if you use the git repository. The "DHCP request 
drop" feature was not released yet.

What version are you using ?

Cheers,
Marek
