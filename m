From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] rv791 <---> rv824 incompatible?
Date: Sat, 1 Dec 2007 19:26:12 +0100
References: <4750C29B.6030708@leipzig.freifunk.net>
	<200712011837.46218.lindner_marek@yahoo.de>
	<4751A22D.3060207@leipzig.freifunk.net>
In-Reply-To: <4751A22D.3060207@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712011926.12718.lindner_marek@yahoo.de>
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


> The rv791 routes fine, but gateway make some Problems. So we included
> this testet version and only request the users that _want_ to use
> batman-gateway-tunnel tu update their batmand. (updatecheck is
> includet)  -> now our Plans are broken... :-(

Sorry about that.
We don't do it to explicitly annoy our users but to minimize future problems. 
But to do that change now than after the final release.


> Why you dont enlarge the compat# from 4 to 5, or so?
> Thats confusing, sorry...

That would not change the problem - here is why:
Before rev812 the version (compat) field was the 10th byte in the header. Now 
it is the first byte. Even if the newer versions increment their version 
field the older version will look for it at the wrong place.

If we don't have the version field at the first byte all future header changes 
may "move" the version field around (same as now). That is why we have to do 
it once and hopefully never again.

Regards,
Marek
