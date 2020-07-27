Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Mon, 27 Jul 2020 20:36:25 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Batman_V Originator Loop Issue
Message-ID: <20200727183625.GA2340@otheros>
References: <20200724202356.GB2357@otheros>
 <20200727162815.30286.54503@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727162815.30286.54503@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Jul 27, 2020 at 04:28:15PM -0000, lavincent15@gmail.com wrote:
> Linus
> 
> I would love to try it out and help with the development, but unfortunately I do not have the time to do that. My internship is coming to a close, and I need to use a version I know works to provide good data.

Oh, okay, good luck with the results then!

> Side note* Do you think you could provide me with a rough equation for when a node decides to use a hop instead of a direct connection? I'm particularly interested in how the nodes use the hop penalty in the equation. Does speeding up the interval increase the speediness of its decision? I'm using this in a mobile node environment and I need it to dynamically switch to the most stable connection.

The metric, including the hop-penalty for BATMAN V is described here:

https://www.open-mesh.org/projects/batman-adv/wiki/Ogmv2#322-Metric-Update

Or here in the code, in this short function:

https://elixir.bootlin.com/linux/v5.7.8/source/net/batman-adv/bat_v_ogm.c#L470

And then the algorithm will compare if the resulting throughput
metric is higher via a direct connection or over another hop even
with the (either) hop or half-duplex penalty applied.

Hope that helps.

Regards, Linus
