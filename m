Return-Path: <andrew@lunn.ch>
Date: Thu, 3 Oct 2013 10:53:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131003085316.GB20056@lunn.ch>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
 <20131002160106.GA1939@neomailbox.net>
 <524D0A04.4090702@hundeboll.net> <20131003081124.GA20056@lunn.ch>
 <20131003082221.GC1939@neomailbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131003082221.GC1939@neomailbox.net>
Subject: Re: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Janne Paatero <janne.paatero@ruag.com>

> > But how do we determine the algorithm version? For the moment it can
> > simply be hard coded. But for version 5? Will the over-alfred format
> > change? Will we have a "struct vis_v2" and VIS_PACKETVERSION_2 for
> > algorithm 5?
> 
> Good question. Maybe we don't really need to export the algorithm version?
> 
> In the end this information can be retrieved on the _same_ node where alfred (&
> vis) is running by reading the "routing_algo" (sysfs-)file.

No, that does not work. You can run alfred on a machine without
BATMAN. alfred --help says:

server mode options:
  -i, --interface             specify the interface to listen on
  -b                          specify the batman-adv interface configured on the system (default: bat0)
                              use 'none' to disable the batman-adv based best server selection

I'm using this "-i eth0 -b none" since my network topology has the
logger on a machine which is bridged into the mesh. 

> What about the source version? How did you get it from the module?

It is the alfred version, not the kernel module version.

   Andrew
