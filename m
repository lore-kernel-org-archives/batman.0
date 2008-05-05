Message-ID: <33923.85.41.146.90.1210019802.squirrel@krisma.oltrelinux.com>
In-Reply-To: <200805051954.19727.lindner_marek@yahoo.de>
References: <200805051954.19727.lindner_marek@yahoo.de>
Date: Mon, 5 May 2008 22:36:42 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] 0.3 final released
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

great work Marek, compliments!

Antonio



On Lun, 5 Maggio 2008 13:54, Marek Lindner disse:
>
> Hello everybody,
>
> after a long release cycle (almost one year) the B.A.T.M.A.N. team is
> proud to
> announce the release of:
> - batman 0.3 stable
> - vis server 0.3 stable
> - batman advanced kernelland 0.1 beta
>
> We used the Wireless Community Weekend 2008 in the c-Base to release our
> newest version. Here are the main features in brief:
>
> batman 0.3:
> - TQ based routing algorith to overcome BATMAN III limitations
> - policy routing (see: http://open-mesh.net/batman/doc/RoutingVodoo)
> - policy routing script to fully control the routing table (see:
> http://downloads.open-mesh.net/batman/useful-scripts-and-tools/policy_routing_script.sh)
> - tunneling rewritten (only UDP based, blackhole detection and kernel
> module
> batgat for performance boosting)
> - parameters can be changed at runtime (routing_class, gateway_class, hna,
> preferred gateway)
> - routing_class support 4 different settings (see:
> http://open-mesh.net/batman/doc/InternetTuning)
> - interface watchdog (interfaces can be (de)activated dynamically)
> - packet aggregation (experimental)
> - official IANA port 4035 is used
> - RFC draft published
>
> batman advanced kernelland:
> - layer 2 meshing based on BATMAN TQ algorithm in kernelland
> - operates on any ethernet like interface
> - supports IPv4, IPv6, DHCP, etc
> - is controlled via /proc/net/bvatman-adv/
> - bridging via brctl is supported
> - interface watchdog (interfaces can be (de)activated dynamically)
> - offers integrated vis server which meshes/syncs with other vis servers
> in
> range
>
> The latest version of batman layer 3 obsoletes batman 0.2 which is not
> supported anymore. The current version (batman 0.3) is the stable version
> from now on. Even though a version 0.4 might emerge we will continue
> supporting 0.3 for a long time period with security fixes and stability
> patches.
>
> Download our code and have fun ! :-)
>
> Greetings,
> Marek
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


