From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] gateway-tunnel crashes with multiple net-dev
Date: Mon, 19 Nov 2007 10:57:07 +0100
References: <473F0B87.9050002@leipzig.freifunk.net>
In-Reply-To: <473F0B87.9050002@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711191057.07530.lindner_marek@yahoo.de>
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

it seems not to be a crash. The batman client destroys the gate0 interface 
after too many tries or is the daemon really dead ?
The problem Antonio mentions has been fixed with rev799.

> I dont know how this gateway-tunnels really works, but i think this
> pseudo-NAT on gate0 not really works or send wrong source-IP or what
> else...

I saw this problem from time to time but it comes and goes. Can you reproduce 
that everytime ? If so could you provide a step by step explanation to 
reproduce it ? So far I saw this kind of behaviour with alias interfaces 
only.

Regards,
Marek

