Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 27 Jan 2012 23:54:25 +0800
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<20120127151914.GB19664@lunn.ch>
In-Reply-To: <20120127151914.GB19664@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201272354.26055.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
	shorter routes by changing the default hop penalty
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi Andrew,

> Do you have any performance analysis to show this is really helpful
> and not harmful?
> 
> I've seen indoor results where i had to reduce the hop penalty,
> otherwise BATMAN was taking a short path which worked badly. By
> reducing the hop penalty, so encouraging it to take more hops, i got
> usable routes.
> 
> I see the danger here this could break working networks, so maybe it
> needs justification?

as a matter of fact I do believe it is helpful. In various networks (more than 
a dozen) I have seen that batman would largely favor multi-hop routes, thus 
reducing the overall throughput. By setting it to a higher value I regained 
some of its performance. The networks are still up & running - I can show them 
to you if you are interested.

So, you had to reduce the default value of 10 to something even smaller ? A 
hop penalty of 10 results in a penatly of 4% per hop. A rough equivalent of 2 
lost packets (62/64). Does not sound very much to me. Can you explain your 
test setup a little more ?

Nevertheless, this patch was intended to get a discussion going. The main 
problem I have been seeing in the last weeks is that OGM broadcasts have a 
hard time estimating the link quality / throughput on 11n devices. I'll also 
try to hack a proof of concept for an rssi influence on the routing and see if 
that has a better effect.

Regards,
Marek
