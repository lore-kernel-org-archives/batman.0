Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 21 May 2018 15:46:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180521134657.GL7162@otheros>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-8-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518014754.23644-8-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: ELP - add throughput
 meter test duration attribute
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

On Fri, May 18, 2018 at 09:47:54AM +0800, Marek Lindner wrote:
> When the ELP throughput meter fallback kicks in to trigger
> a throughput meter measurement the test duration can be
> configured via this attribute.
> 
> Default tp test duration: 1000ms

Would it make sense to note the adjusted default tp test duration
in the commit message, too? It is adjusted from 10ms to 1000ms
here, right?


I'm also wondering if it would make sense to make the test
interval adjustable instead of the duration:

With 1000ms on a 16MBit/s DSL line this would generate 864GB of
traffic per month and would be an issue for several existing
setups right now.

Is there some minimum test duration at which the tp meter is
supposed to not work realiably anymore, where an increased check
period would be more suitable?

Regards, Linus
