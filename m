From: elektra <onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Can't build a mesh network
Date: Wed, 17 Dec 2008 18:46:50 +0100
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<5dfe3cd98da52153d44b79b834280707.squirrel@unimail.uni-dortmund.de>
	<48e8355278083c6883a51b059432df08.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <48e8355278083c6883a51b059432df08.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812171846.50992.onelektra@gmx.net>
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
To: resul.cetin@uni-dortmund.de, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi -

sure, we have. Ad-Hoc mode of 802.11 is broken by design. Keywords: IBSS 
merges and time stamps in beacons. There are some hacks which work 
exclusively for the Madwifi driver with the patches of a recent Openwrt 
Kamikaze developer version. You can use the ad-hoc demo mode or 'real' IBSS 
mode with the option "nosbeacon" when creating the VAP with 

"wlanconfig ath0 create wlandev wifi0 wlanmode adhoc nosbeacon"

This is the only option for a PC at the moment. Works rock solid even in the 
Berlin Freifunk mesh with ~500 ad-hoc interfaces where MAC timestamps 
permanently jump back and forth.

Closed source binary driver for Linux 2.4 for Broadcom also works - mostly, 
there have been reports about issues in conjuction with patched Madwifi 
versions (software generated timestamps are not precise enough and can 
confuse the Broadcom driver) These issues can be avoided by using ah-demo 
mode where you fix the IBSS-ID.

Cheers,
elektra

>
> Has anybody experience with this issue...
>
> Greetings,
> R
>
> > Hiii,
> >
> >
> >
> > I'm a beginner regarding mesh networks. At the moment, I have a problem
> > by building a mesh network with batman between 2 Linksys and a Laptop. I
> > get a ping response on the router side and from my Laptop side. There is
> > a connection... ok..
> >
> > But I can't run batmand to establish a mesh network...
> >
> > I gave the command" sudo batmand eth1 wlan0:test" to build the connection
> > and then this here"sudo batmand -c -d 1"
> > but the second command gives this error message:
> > "Error - can't connect to unix socket '/var/run/batmand.socket': No such
> > file or directory ! Is batmand running on this host ?"
> >
> > My batman version is"
> > B.A.T.M.A.N. 0.2 (compability version 3)"
> >
> > Can anybody help me to fix this problem ?
> >
> > greetings,
> > R
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


