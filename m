Message-ID: <20080106165233.7aswfv27s4ow4w04@webmail.ddmesh.de>
Date: Sun, 06 Jan 2008 16:52:33 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Memory leak
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801042124.18425.axel@open-mesh.net>
	<20080105214740.n00x2uza0coowssk@webmail.ddmesh.de>
	<200801061503.09053.axel@open-mesh.net>
In-Reply-To: <200801061503.09053.axel@open-mesh.net>
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

Hi Axel,

>
> Does it really increase endlessly with each new thread ?
> If its the GW-client thread then you can enforce the termination and
> recreation on-the-fly with batmand -c -r0 (to destroy the tunnel) and
> -c -r3 (to create the tunnel)
>
When I call batmand with those parameters I can reproduce this much  
faster until
no memory is available anymore. This happens on each call with these  
parameters.

> there is a blackhole detection in the default two-way-tunnel. This can cause
> the client to disconnect from the unresponsive (-blackhole-) GW and put the
> GW on a blacklist for some time. It should all be reported on debug-level 3.
> If no other GW is available, the GW-client node will reconnect to   
> the GW after
> a while (might be 100 sec).
> If you have a dummy GW, either use --no-unresp-gw-check or
> use --one-way-tunnel 3 at the client and the GW side
I like to have the blackhole detection enabled, it is a good way to  
detect an inactive GW beside of the ping-check-algorithm in the  
firmware.
I assume that default is the two-way-tunnel where data goes from one  
node directly to the gw and back. Whatfor is the one-way-tunnel and  
what are the
condtion for the one-way-tunnel being active.

Why is the gw-thread deleted? If the problem lays in the pthread  
implementation
it would be a workaround to keep the gw thread always active.

I also think that the memory consumtion is more than 16kbyte, because  
the virtual memory is incremented and also the percentage used.

Bye
Stephan



