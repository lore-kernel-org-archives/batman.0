From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Wed, 7 May 2008 21:29:29 +0800
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805072041.54021.lindner_marek@yahoo.de>
	<4A79C120-E22D-4EB4-91E9-851EA0B2DBE5@cslab.ece.ntua.gr>
In-Reply-To: <4A79C120-E22D-4EB4-91E9-851EA0B2DBE5@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805072129.29427.lindner_marek@yahoo.de>
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



> I would prefer that you copy it over. I think it is better to keep
> things in one place. :)

Ok, I copied it and put a note on the website. See: 
https://www.open-mesh.net/batman/patches

I renamed the patches from "experimental" to "needs-testing" otherwise people 
might get confused with our experimental branch.


> I had a lengthy conversation about that with Acinonyx. The first patch
> I did was to enable us to pass arguments to the policy routing script.
> However, I preferred a direct patch, because I couldn't find an easy way
> with the current batmand and (more importantly) the zebra interface to
> retrieve routes on exit. I had to implement some kind of route
> management/tracking in the script and delete these
> routes on shutdown. With the direct patch, route management is done in
> the kernel. Sure, a full-featured policy-routing-script would be a more
> appropriate solution and I hope to find some time to do it in the future.

But batman should keep track of all routes and send the delete commands to 
your program. On exit batman should notify your program about all the routes 
to be deleted. If not you found a bug.  ;-)


> An even greater challenge would be to implement a bidirectional policy-
> routing-script, that could also be used to implement route redistribution
> from other protocols.
> Which would of course require a full API to talk with batmand... Need
> even more time for that... :)

You mean batman should distribute zebra routes on the fly ? That is possible - 
even _today_.  :-)
You can add and delete HNA routes via the unix socket. HNA is a way to flood 
the batman network with routes which do not belong to batman.

Greetings,
Marek
