From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] parametrization for bmxd on ethernet?
Date: Thu, 15 Nov 2007 20:29:49 +0100
References: <20071114170618.GA4282@apoderado.ometepe.net>
	<200711141934.51710.axel@open-mesh.net>
	<20071114232050.GA5080@apoderado.ometepe.net>
In-Reply-To: <20071114232050.GA5080@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711152029.49188.axel@open-mesh.net>
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


> > > So howto parametrize bmxd for devices without wireless-intrerface
> >
> > usually the same parameters as for a node with a wireless interface
> > should be fine, like:
> > bmxd -g 1000 eth0:bmx eth1:bmx
> >
> > You can slightly optimize the cpu consumtion and
> > protocol-traffic-overhead by appending the /c 100 option to the first
> > interface parameter like:
> >
> > batmand -g 1000 eth0:bat /c 100 eth1:bat
> >
> > This overwrites the default configuration (/c 200) of the first interface
> > parameter which is assumed to be the only wlan interface. /c 200 achieves
> > some optimization for the path detection via wireless links.
> >
> > However, on a cabled lan the protocol-traffic-overhead does not really
> > hurt and on a i386 architecture you will barely recognize any increased
> > cpu consumption.
update: I added two more simple interface specific option with rv801 . The 
daemon now tells you about this during startup:
The batman-exp default parametrization assumes the first given interface 
argument to be the one and only wireless interface, followed by zero or more 
lan interfaces! To change this assumption mark the interfaces explicitly 
using /w to specify the wlan interface(s) and /l to specify the lan 
interface(s). Example: batmand eth0 /l wlan0 /w ath1 /w


> >
> > > Can i use --gateway-change-hysteresis together with -p ?
> >
> > No, --gateway-change-hysteresis can only be used with -r 3 (fast-switch
> > internet connection).
> >
> > with -p 10.1.2.3 the gw-client will stick to its selected gw as long as
> > its somehow available (until it times out, as you described below).
>
> sorry, actually my question has to be:
> can i use -p together with -r3 ?

You can. Then -r3 is the fallback strategy for the GW selection in case the 
preferred one is not available. But still the client-node will not think 
about choosing a faster GW until the preferred GW has been purged. Once the 
preferred GW is not available anymore it uses the -r3 policy to switch 
between the remaining available GWs :-(

>
> > > Suggestion: in bmxd -cbd1 i saw nodes with lvld >400 before they
> > > get deleted, i think 180 should be more than enough, 3 minutes is
> > > plenty of time for normal reboot, and if a node dosn't send OGMs for
> > > more than that... it has a serious problem ;)
> >
> > Well, these long timeout defaults are kind of traditional remains from
> > batmand-0.2. But, not constantly receiving OGMs from a distant node does
> > not mean that the distant node has not send some or is down. And it also
> > does not necessarily mean that the old route to this distant node does
> > not work anymore. With 0.2 we sometimes observed paths to distant nodes
> > via which only one OGMs was received within the current window-size
> > (which was 128 seconds) and still the path was somehow usable.
>
another update:
You can slightly modify the purge interval by configuring the value used for 
the rudimentary DuplicateAddressDetection (--dad-timeout). Default is 100 
which means that the DAD timeout is 100% of the (originator-interval * 
window-size). So 150 seconds by default. The daeomon also tells you about 
these values during startup: --dad-timeout 50 (which is the minimum allowed) 
will print:
Using duplicate-address-detection timeout 75s, purge timeout 160s, originator 
interval 1500ms, window size 100
 

ciao,
axel

> yes, and sometimes (actually pretty often in some cases) there was not
> even one OGM received and the path would hav been pretty usable ;-)
>
> > On the other hand we thought that it has no much benifits to delete a
> > stale route (even when its definitely death). Not unless a better path is
> > known.
>
> primarily i'm thinking about path(s) to gw-nodes, in my case here,
> i loose the vsat regularly due to power-outages and missing backup
> batteries because of the energy hunger of that beast.
> But i have to do "some kind of load balancing", and thought for now, it
> would be the easiest to do that with -p.
>
> > Ok. 0.2 had some problems with path detection
>
> which bmxd doesn't have :-)
>
> cheers
>
>   --Jan


