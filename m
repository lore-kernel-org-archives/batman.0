Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 12 Dec 2009 10:34:29 +0800
References: <102820.28764.qm@web111617.mail.gq1.yahoo.com>
	<48655D92-93E9-4E10-A84C-A9B86B69B54C@lo-res.org>
	<801558.78070.qm@web111609.mail.gq1.yahoo.com>
In-Reply-To: <801558.78070.qm@web111609.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912121034.30024.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN development vs. Freifunk usage of OLSR ?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> This is the meat of what I am asking - I am wondering what context is it
>  proper to use BATMAN, and the reason I am confused about it is that I see
>  most (all ?) of the freifunk networks using OLSR.

first of all I have to say not all Freifunk networks use OLSR but I think it is 
fair to say many of them do and here is why:

a) These networks use the "standard" freifunk firmware that you can find here: 
http://downloads.berlin.freifunk.net/ - this firmware has OLSR built-in (the 
maintainer is/was an olsrd.org developer). 

b) Many networks were using olsrd.org as protocol before batman became stable, 
hence they face upgrade issues (in a decentral environment).

c) These networks are community driven networks and somewhat slow to embrace 
change. A whole network requires a lot of maintenance - you don't want to 
fiddle with the protocol every week (although quite some experimented with 
batman - Weimar comes to mind).

d) None of us is actively trying to "lobby" batman into the Freifunk networks. 
If they have questions they can contact us (some do) but other than that ..

In general we see a strong adoption in new networks (no dependency issues 
there) and recently people are quite interested in layer 2 which gives you 
roaming/meshwide DHCP/etc.

So, I can understand you - Freifunk initiated an innovation that it does not 
use. Our biggest user groups are outside of Freifunk - funny.  :)


> And as an aside, I am curious, if any freifunk networks are using BATMAN,
>  what routing metric do they use ?

The TQ based algorithm.

Regards,
Marek

