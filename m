Return-Path: <andrew@lunn.ch>
Date: Tue, 3 May 2016 14:45:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160503124551.GA16952@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
 <3771281.MWFGszot8n@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3771281.MWFGszot8n@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
 debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc

> It looks like the header line is missing here. The debugfs table show
> something like:
> 
>     "  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...\n");
> 
> or
> 
>     "  Originator      last-seen ( throughput)           Nexthop [outgoingIF]:   Potential nexthops ...\n");

Ah, yes. I wanted to come back and look at this. It needs an extra
call to ask what algorithm is being used, so you know which header to
print.

> the nexthops are also done differently now (not sure if this is better
> but at least something which should be discussed):

I've deliberately not made the output the same as the kernel debugfs.
There is no real reason to do that. You should not be 'screen
scraping' batctl, you should use the netlink socket...

Anything where the kernel consolidates information does not happen. We
get the raw information from the kernel, and it is printed as is, with
the exception that bathosts is used to translate MAC addresses to
names. There are also likely to be white space changes.

The callback structure used by netlink does not help here. You get to
see one originator record at once. So in order to print consolidated
information, you would have to build a database in the callback
function, and once all the information is available, do the
consolidate and then printing. Doable, but i took the easier option of
printing a line per originator record.

> originator
> ==========
> 
> netlink
> -------
> 
>     [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:fe:01 (bat0/f2:f2:2d:c3:71:8c BATMAN_IV)]
>      * 02:ba:de:af:fe:02    0.004s   (251) 02:ba:de:af:fe:02 [      eth0]
> 
> debugfs
> -------
> 
>     [B.A.T.M.A.N. adv 2016.1-62-g55e9890, MainIF/MAC: eth0/02:ba:de:af:fe:01 (bat0 BATMAN_IV)]
>       Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...
>     02:ba:de:af:fe:02    0.024s   (251) 02:ba:de:af:fe:02 [      eth0]: 02:ba:de:af:fe:02 (251)
> 
> The output "No batman nodes in range ...\n" also isn't there anymore
> (not that I would miss it).

Again, the callback structure makes that messy. A global variable
which needs setting in the callback, and after parsing all the
records, if that global variable is not set, print the "No batman
nodes in range ...\n"

      Andrew
