From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batmand terminates silently
Date: Tue, 25 Sep 2007 12:26:31 +0200
References: <20070925091716.ummlm5rfkgs8000o@webmail.ddmesh.de>
In-Reply-To: <20070925091716.ummlm5rfkgs8000o@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709251226.31476.lindner_marek@yahoo.de>
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

> few weeks agoe I had sometimes the problem that batmand (experimental)
> exits silently. Today I found maybe one reason for this.
> When you have batman running and insert the iptable rule
>
> iptables -I OUTPUT -o eth1 -j DROP
>
>
> batmand exits. This also happen for additional interfaces controlled
> by batmand.

actually this is logged to syslog and debug level 4. A "logread -f" on OpenWRT 
systems should show something like that: 

Error - can't send udp packet: Permission denied.
Does your firewall allow outgoing packets on port 4306 ?

Regards,
Marek
