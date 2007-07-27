From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Fri, 27 Jul 2007 17:23:00 +0200
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
	<200707271607.24544.lindner_marek@yahoo.de>
	<F95CB0D2-5305-4C74-B9C4-73F8A2EB6CAD@lo-res.org>
In-Reply-To: <F95CB0D2-5305-4C74-B9C4-73F8A2EB6CAD@lo-res.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707271723.00575.lindner_marek@yahoo.de>
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


Hi,


> guys, please mention, that in OLSRd this is simply problematic for
> you in *Berlin* where you use private IPs.

the majority of all wireless mesh networks out there don't have a good 
relationship to an ISP which routes all the traffic and sponsors public 
IPs ...
I really think you have a nice solution in Vienna which unfortunately is not 
reproducible everywhere.


> And therefore the NAT causes problems. The tunnel trick works
> *just*as*well* for OLSRd BTW.

So far OLSRd has no builtin tunnel functionality and that's why you can't do 
the same trick.
By the way, you should know that the dyngw plugin is real pain. Too often it 
enables or disables the Internet connection where this is totally 
unneccessary. And it does not solve the problem. It just tries to hide a flaw 
because I rely on the information the gateway sends me.


> I just often have the feeling that you want to dissmiss olsrd becasue
> batman *has* to be better, since it is already in the name. That
> sucks a bit. Well, whatever...

Aaron, please don't feel personally attacked by this. You know that we started 
batman because we were not happy with many things in OLSR. 
The only reason for me to mention OLSR was that many people here expect us to 
redo all the things OLSR does. And I just want to remind them that batman is 
a different project.


> I think both approaches have something to it. OLSRd is well tested
> (and has ugly code, yes) but batman really has to be still tested out
> in the wild with many nodes. A routing protocol evolves with the load
> that is applied to it.
> That is the key issue in my opinion.

I absolutely agree.


> Anything new with the approaches to create an RFC for batman by the way?

We are working on it.

Regards,
Marek

