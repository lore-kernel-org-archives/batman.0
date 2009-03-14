From: elektra <onelektra@gmx.net>
Date: Sat, 14 Mar 2009 10:14:21 +0100
References: <49B825BE.4040605@java-system.com>
	<200903112214.44339.onelektra@gmx.net>
	<49BB7058.2070100@java-system.com>
In-Reply-To: <49BB7058.2070100@java-system.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903141014.21989.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Unable to connect to internet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi!

> > On mesh router connected to ADSL:
> >
> > batmand -g 1000 ath0
> >
> > On other mesh router:
> >
> > batmand -r 1 ath0
> >
> > You have to NAT towards the internet on the gateway.

There is a bug in batmand in current 0.3.2 code, which occurs when you use HNA 
(-a). We are currently working on it. You don't need to use -a to connect to 
the internet in your case, however. But you have to set up simple NAT towards 
the interface of the batman-gateway connected to the ADSL modem.

If that interface is eth0 the command would be:

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

Cheers,
elektra
