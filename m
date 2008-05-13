From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Tue, 13 May 2008 16:34:19 +0800
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805081812.33117.lindner_marek@yahoo.de>
	<CB4F1B6A-15D9-4CFD-BA29-4B6AC6F72596@cslab.ece.ntua.gr>
In-Reply-To: <CB4F1B6A-15D9-4CFD-BA29-4B6AC6F72596@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805131634.20052.lindner_marek@yahoo.de>
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

> I went the other way round and started out on an external program that
> will act as an interface between batman and quagga. You can find it
> here:
>
> http://www.cslab.ece.ntua.gr/~chazapis/batman/batquagga-0.1.c

cooool !


> Do you keep or plan to keep network HNA information in batmand?
> I mean, is there any way that flush_routes_rules (in linux/route.c)
> could
> be implemented in batmand, without the need of the external routing
> table management?

Batman keeps track of the HNA and all other routes which were placed by batman 
and deletes them individually. The mentionned function flush_routes_rules() 
is only called during the startup to clean the tables and in case of a 
segmentation fault because the internal data structures can't be trusted 
anymore. The normal case is that batman deletes its own routes one by one.

I did some testing with a script which just prints the commands and I noticed 
that the script can't execute those commands because it dies too quickly via 
SIGINT or SIGTERM. Therefore the latest revision (1065) ignores these 
signals. Apart from that we have a little sync problem. Batman kills its 
child after sending all the commands via the pipe. At that moment the child 
may still be busy with processing these commands. We have to find an elegant 
way to communicate that the child finished its last job. The latest revision 
waits another 3 seconds which is far from being perfect ...

Greetings,
Marek

PS: Your addtional script arguments patch is an interesting idea. We are 
checking on that because it might have some side effects.
