From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
Date: Sat, 29 Nov 2008 08:35:25 +0800
References: <492DDC20.7090900@web.de> <20081128205145.GB25072@pandem0nium>
	<4930713D.40809@web.de>
In-Reply-To: <4930713D.40809@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811290835.26929.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Saturday 29 November 2008 06:31:25 Chris W. wrote:
> > I don't know of precompiled packages, maybe someone else does? :)
>
> well, I'll find a place ;-)

Offering kernel module packages is rather cumbersome as the kernel modules has 
to match the given kernel _exactly_. I'm not sure how far this goes (some 
tests would be needed) but I'm sure you would need the same sources (including 
all patches, same compiler, may be even binary compability?).


> Checked it with -r 2 -p 10.4.5.30 which is down at this time, reachable
> via  Atheros nodes.
> => 10.4.5.30       ( 86)       10.4.2.72 [    ath0:1], gw_class  40 -
> 2048KBit/256KBit, gateway failures: 0
>     10.4.2.2        (140)       10.4.2.72 [    ath0:1], gw_class  40 -
> 2048KBit/256KBit, gateway failures: 0
>     10.4.2.71       (150)       10.4.2.72 [    ath0:1], gw_class  40 -
> 2048KBit/256KBit, gateway failures: 0

Batman has an internal blackhole detection. The olsr dyn_gw is a hack (its 
just pinging the outside world which works in many cases) - batman has this 
functionality inside. As every traffic flows through the batman tunnel (forth and 
back) batman can "observe" the traffic and detect blackholes (nodes announcing 
internet without a connection) much better. As soon as you generate traffic 
batman will switch the gateway.

Regards,
Marek


