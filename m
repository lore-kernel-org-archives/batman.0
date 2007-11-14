From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] parametrization for bmxd on ethernet?
Date: Wed, 14 Nov 2007 19:34:51 +0100
References: <20071114170618.GA4282@apoderado.ometepe.net>
In-Reply-To: <20071114170618.GA4282@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711141934.51710.axel@open-mesh.net>
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

On Mittwoch 14 November 2007, Jan Hetges wrote:
> Hi
> I did'nt find doku on that.
> As i'm getting a 2nd GW :-)...
>
> setup:
>                       ---"DMZ"
>                      /
>  vsat --- gateway ------ wifi-gw --- "wifi-world" --- 2nd-wifi-gw
>                             \
> 			     ---"wifi-world-2"
>
>
> I'm running bmxd-rv785 on all the wireless stuff, where wifi-gw runs
> bmxd -g -blabla,  but i liked to move the bmxd-gw to the cabled gw,
> so if the sat-link fails, "wifi-world-2" and "DMZ" can still reach
> the internet through the 2nd-wifi-gw.
> So howto parametrize bmxd for devices without wireless-intrerface

usually the same parameters as for a node with a wireless interface should be 
fine, like:
bmxd -g 1000 eth0:bmx eth1:bmx

You can slightly optimize the cpu consumtion and protocol-traffic-overhead by 
appending the /c 100 option to the first interface parameter like:

batmand -g 1000 eth0:bat /c 100 eth1:bat

This overwrites the default configuration (/c 200) of the first interface 
parameter which is assumed to be the only wlan interface. /c 200 achieves 
some optimization for the path detection via wireless links.

However, on a cabled lan the protocol-traffic-overhead does not really hurt  
and on a i386 architecture you will barely recognize any increased cpu 
consumption.

> Can i use --gateway-change-hysteresis together with -p ?
No, --gateway-change-hysteresis can only be used with -r 3 (fast-switch 
internet connection). 

with -p 10.1.2.3 the gw-client will stick to its selected gw as long as its 
somehow available (until it times out, as you described below).


> Suggestion: in bmxd -cbd1 i saw nodes with lvld >400 before they
> get deleted, i think 180 should be more than enough, 3 minutes is plenty
> of time for normal reboot, and if a node dosn't send OGMs for more
> than that... it has a serious problem ;)

Well, these long timeout defaults are kind of traditional remains from 
batmand-0.2. But, not constantly receiving OGMs from a distant node does not 
mean that the distant node has not send some or is down. And it also does not 
necessarily mean that the old route to this distant node does not work 
anymore. With 0.2 we sometimes observed paths to distant nodes via which only 
one OGMs was received within the current window-size (which was 128 seconds) 
and still the path was somehow usable. 
On the other hand we thought that it has no much benifits to delete a stale 
route (even when its definitely death). Not unless a better path is known. 

Ok. 0.2 had some problems with path detection and -p is another argument to  
reconsider this purge timeout.

ciao,
/axel

>
> cheers
>
>   --Jan


