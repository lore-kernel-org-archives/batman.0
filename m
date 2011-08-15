Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Aug 2011 17:33:48 +0200
References: <CAJA-1LiiLCJ4D2s9ubXFRmyu_TvgiK51PAzaOHNMwP3M-KeeEg@mail.gmail.com>
	<201108111637.31233.lindner_marek@yahoo.de>
	<CAJA-1LhpLpJBsekY92GjXspnfJO-j_g2VEjsc9gxSaR3yW+mZQ@mail.gmail.com>
In-Reply-To: <CAJA-1LhpLpJBsekY92GjXspnfJO-j_g2VEjsc9gxSaR3yW+mZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108151733.48675.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman CPU usage
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

On Monday, August 15, 2011 12:02:34 Max Ip wrote:
> The CPU usage is the resources consumed to run the netperf test.
> netperf gives the amount of CPU it consumes while sending the stream
> TCP_STREAM from client to the server. So, the CPU usage is calculated
> on the network first without batman-adv and secondly with batman-adv
> enabled on each nodes. Thus the difference would measure the cpu load
> created by batman-adv. So, I don't use top / uptime / etc.

When netperf tells you how much CPU cycles it consumed how can you deduce the 
batman-adv load from it ? netperf runs in user space and has no knowledge 
about what is going on in the kernel. In fact, netperf probably asks the 
kernel how many CPU cycles were consumed by its own process.
In other words: netperf has no way of knowing the load created by the kernel 
as it simply is beyond its scope. I suggest looking at tools that are able to 
analyze kernel load, for example ftrace.

 
> The whole point of using batman-adv in this experiment is to create
> adhoc connection between the end nodes (A and C) which are out of
> contact. So, the intermediate node (B) acts as the relaying node. So,
> I would like to create a virtual 2-hop condition (using ebtables to
> disable connection between end nodes A and C). Now that the 2-hop case
> is formed, what would be its effect in terms of CPU usage in node B. I
> don't think I can use any better setup than this one.

What you want to achieve is understandable but you were running different test 
setups and compared the results. Without batman-adv you had no relay and with 
batman-adv you had a relay. Trying to fix the difference with a simple 
calculation should only be done if one understands all the implications.

Regards,
Marek
