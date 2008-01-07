Message-ID: <20080107135602.eigmai3tpko40c40@webmail.ddmesh.de>
Date: Mon, 07 Jan 2008 13:56:02 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Memory leak
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801061503.09053.axel@open-mesh.net>
	<20080106165233.7aswfv27s4ow4w04@webmail.ddmesh.de>
	<200801071045.10747.axel@open-mesh.net>
In-Reply-To: <200801071045.10747.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
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
To: b.a.t.m.a.n@open-mesh.net

Hi,

The batmand is running on WRT54GL and WRT54GS. The firmware is  
whiterussian_rc6
and the batmand was self-compiled from within whiterussian devel env.
I have removed the "-static" LDFLAG and also removed the  
DEBUG/MEMORY... CFLAGS.
As optimation I have used -Os to keep the batmand small which also produces
a lot of warnings.
I'm not at home to give you the correct CFLAGS.

> one-way-tunnel are completely stateless. No assigned virtual IPs, no need for
> SNAT,... Data is only tunnelled from the GW-Client to the GW-Node. THere it
> is de-tunnelled and forwarded. We used this setup at the 24c3 to let batman
> client nodes be accessible via global unique IPs.
>
I'm still confused about the data traveling over the one/two way  
tunnels and what
the differences are for data travel (request/answer).
What IP does the tunnel interface have for the one-way tunnel? Same as  
the main
interface? If a client creates a tcp connection then ACKs and answers  
should come back through this one-way-tunnel, doesn't it?
What dis/advantages does a two-way-tunnel have against the one-way-tunnel?
For the one-way-tunnel how many tunnel interfaces are created? For  
each connecting client one interface or only one interface for all?  
How does the GW
route packets to a specific client if the GW has a route over the wlan  
interface and a route to the tunnel interface?
Please let me know if there is already a documentation for this.

Currently I'm using the two-way-tunnel and this works find. the only  
"bad" thing is that the proxy running on the GW does display the 169er  
IP addresses and not
the node main ip. But this is ok.

Perhaps the one-way-tunnel would be better because the memory  
consumption on the GW. If you have some hints on that, please let me  
know.

/Stephan




