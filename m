Message-ID: <48e8355278083c6883a51b059432df08.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <5dfe3cd98da52153d44b79b834280707.squirrel@unimail.uni-dortmund.de>
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812111154.31726.neumann@cgws.de> <49411D3D.90301@ddmesh.de>
	<200812121146.26579.neumann@cgws.de>
	<5dfe3cd98da52153d44b79b834280707.squirrel@unimail.uni-dortmund.de>
Date: Wed, 17 Dec 2008 14:57:19 +0100 (CET)
Subject: Re: [B.A.T.M.A.N.] Can't build a mesh network
From: "Resul Cetin" <resul.cetin@uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: resul.cetin@uni-dortmund.de,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

Hello people...

its me again...
I fixed my problem, that I mentioned in the previous message. I choosed
the wrong interface, this was the mistake...

But I have still a problem...

After maybe 10 minutes, the connection is broken between the Laptop and
the Routers...

Has anybody experience with this issue...

Greetings,
R



> Hiii,
>
>
>
> I'm a beginner regarding mesh networks. At the moment, I have a problem by
> building a mesh network with batman between 2 Linksys and a Laptop. I get
> a ping response on the router side and from my Laptop side. There is a
> connection... ok..
>
> But I can't run batmand to establish a mesh network...
>
> I gave the command" sudo batmand eth1 wlan0:test" to build the connection
> and then this here"sudo batmand -c -d 1"
> but the second command gives this error message:
> "Error - can't connect to unix socket '/var/run/batmand.socket': No such
> file or directory ! Is batmand running on this host ?"
>
> My batman version is"
> B.A.T.M.A.N. 0.2 (compability version 3)"
>
> Can anybody help me to fix this problem ?
>
> greetings,
> R
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


