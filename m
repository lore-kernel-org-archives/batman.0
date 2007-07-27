From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] error code
Date: Fri, 27 Jul 2007 14:33:03 +0200
References: <200707261000.l6QA03nQ024113@open-mesh.net>
	<46A9BC17.5040009@fokus.fraunhofer.de>
In-Reply-To: <46A9BC17.5040009@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707271433.03801.lindner_marek@yahoo.de>
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

> i've experienced some trouble with batman. when batman is started with
> an invalid interface, due a typo eht1, batman exits/crushes but gives no
> message and the exit value is 0 too. i would propose that batman, gives
> a message or at least changes the exit value, when it crushes.

this is not entirely correct. We have to distinguish between two cases:


1. batman forks into the background (batmand eth1):

- You get an exit code of 0 because the daemon forks into the background. The 
foreground process exits normally. After forking all the interfaces are 
checked.
- Batman logs its error message to syslog (similar to all other daemons). 
Depending on your syslog configuration you will find the error message 
in /var/log/<logfile>.


2. batman does not fork (use a debug level of 3 or 4 -> batmand -d 3 eth1)

- You get an error exit code because batman does not fork before checking the 
interfaces.
- The error message is printed in the current shell.

Regards,
Marek
