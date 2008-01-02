From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Quagga zebra API client for BATMAN
Date: Wed, 2 Jan 2008 16:14:21 +0100
References: <200712271148.14121.holger@layer-acht.org>
	<20071227122037.GA21485@hrz.tu-chemnitz.de>
	<200712310201.49542.acinonyxs@yahoo.gr>
In-Reply-To: <200712310201.49542.acinonyxs@yahoo.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801021614.22056.lindner_marek@yahoo.de>
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

> I've added support to send BATMAN routes to zebra daemon and redistribute
> them to other Quagga protocols. The interface is through zebra UNIX socket.
> A new option -q followed by the UNIX socket path is added (see batmand
> --help) to enable route export. I've also implemented a metric for BATMAN
> routes based on TTL value which is essential when using BATMAN as IGP to
> BGP Confederations.

thanks for submitting your work. I published it on our website so that others 
can find it: https://www.open-mesh.net/batman/patches

By the way: Using the TTL as basis for a hop metric is ambiguous and may lead 
to errors. By doing so you assume that every host uses the same start TTL and 
every hop decreases it in the same way. The B.A.T.M.A.N. protocol does not 
demand or enforce this behaviour. 
On the other hand the hop count does not reflect the quality of a path. May be 
it would be a better approach to calculate the link quality into the metric 
so that hop based protocols can do a better decission.

Regards,
Marek

