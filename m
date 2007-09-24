From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] a strange case
Date: Mon, 24 Sep 2007 20:32:57 +0200
References: <53923.85.41.146.90.1190656836.squirrel@krisma.oltrelinux.com>
In-Reply-To: <53923.85.41.146.90.1190656836.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709242032.57498.lindner_marek@yahoo.de>
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

> But what is puzzling me is that running batman 0.2 on nodes... laptop
> associated with AP_n (client' AP) can browse!
> (I've only changed the daemon, no others change into environment -
> procedures dinamically change batmand command string)

I don't know exactely about the experimental branch but the alpha branch has 
changed ports. Now we are using port 4305 for OGMs and 4306 for the internet 
tunnel. May be you have to adjust your firewall settings. In any case the 
debug level 3 output should give us more information regarding your problems.


> I noticed the parameter "--no-unreachable-rule" then tryed adding this
> parameter at the batman 0.3 command string but unfortunately with no
> results!

I would suggest that you don't touch the policy routing switches unless you 
know what you are doing. If you don't have any special use cases the defaults 
should work perfectly for you.

Regards,
Marek
