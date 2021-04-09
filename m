Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Fri, 9 Apr 2021 13:16:34 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Problems with Multiple Interfaces
Message-ID: <20210409111634.GI2742@otheros>
References: <20210408055629.1234.95039@diktynna.open-mesh.org>
 <3542676.qYy7ulQ77K@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3542676.qYy7ulQ77K@prime>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: joe@careyhome.org

On Fri, Apr 09, 2021 at 12:17:36PM +0200, Simon Wunderlich wrote:
> On Thursday, April 8, 2021 7:56:29 AM CEST joe@careyhome.org wrote:
> > Hi Everybody,
> > 
> > I'm running BATMAN v 2019.2 with ath10k on OpenWRT.  The particular router
> > I'm using has two interfaces, 2.4 GHz and 5GHz.  With each router using
> > single interface (e.g. 2.4 GHz), it works fine.  When I add a second
> > interface (e.g. 5GHz), it sometimes hangs.

One more note: ath10k firmware refuses to provide an expected
throughput for the wifi link.

The fallback to an estimate which uses the raw tx bitrate was
added not that long ago in batman-adv v2020.0:

https://www.open-mesh.org/news/95

I'm wondering if you might have very low throughput values in
batman-adv and if that might lead to issues with interface
alternating.

Also, would be interesting to know if you have the same issues
when using BATMAN IV, which mainly uses a packetloss based metric.

Regards, Linus
