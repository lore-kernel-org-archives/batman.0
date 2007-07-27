Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <200707271607.24544.lindner_marek@yahoo.de>
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
	<200707271607.24544.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F95CB0D2-5305-4C74-B9C4-73F8A2EB6CAD@lo-res.org>
Content-Transfer-Encoding: 7bit
From: Aaron Kaplan <aaron@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Fri, 27 Jul 2007 16:43:55 +0200
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


On Jul 27, 2007, at 4:07 PM, Marek Lindner wrote:

>  By using tunnels to the gateway
> batman is in a far better situation than OLSR


guys, please mention, that in OLSRd this is simply problematic for  
you in *Berlin* where you use private IPs.
And therefore the NAT causes problems. The tunnel trick works  
*just*as*well* for OLSRd BTW.

I just often have the feeling that you want to dissmiss olsrd becasue  
batman *has* to be better, since it is already in the name. That  
sucks a bit. Well, whatever...

I think both approaches have something to it. OLSRd is well tested  
(and has ugly code, yes) but batman really has to be still tested out  
in the wild with many nodes. A routing protocol evolves with the load  
that is applied to it.
That is the key issue in my opinion.

Anything new with the approaches to create an RFC for batman by the way?

ciao,
aaron.





