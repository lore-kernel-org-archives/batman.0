From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] something about 0.3
Date: Thu, 6 Sep 2007 15:54:28 +0200
References: <26352.85.41.146.90.1189024539.squirrel@krisma.oltrelinux.com>
	<200709061331.03704.axel@open-mesh.net>
	<32464.85.41.146.90.1189084222.squirrel@krisma.oltrelinux.com>
In-Reply-To: <32464.85.41.146.90.1189084222.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709061554.28994.lindner_marek@yahoo.de>
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

> thanks for your statements, especially for kernel module (which was
> puzzling me).

we found out that most of the CPU load caused by batman comes from sending 
packets. Thats why we experimented to combine our daemon with a kernel modul 
in order to reduce the load. Unfortunately, we found out that the current 
modul design is not suitable to achieve this goal. It would be neccessary to 
move all the important routing code into the modul to see measurable effects.
For this reason the modul probably wont be included in the coming release. If 
you are interested in our ideas just have a look into 
trunk/batman/linux/modules.
There you will find another modul (mod_batgat) which will be included in the 
next release. It will help to reduce the load caused by the UDP tunnels on 
the internet gateways. There is still some polishing to be done and it must 
be ported to linux 2.4 before we can offer packages for it.

Reagrds,
Marek
