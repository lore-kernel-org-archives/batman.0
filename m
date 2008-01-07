From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Memory leak
Date: Mon, 7 Jan 2008 10:45:10 +0100
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801061503.09053.axel@open-mesh.net>
	<20080106165233.7aswfv27s4ow4w04@webmail.ddmesh.de>
In-Reply-To: <20080106165233.7aswfv27s4ow4w04@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801071045.10747.axel@open-mesh.net>
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

hi,

On Sonntag 06 Januar 2008, Freifunk Dresden wrote:
> Hi Axel,
>
> > Does it really increase endlessly with each new thread ?
> > If its the GW-client thread then you can enforce the termination and
> > recreation on-the-fly with batmand -c -r0 (to destroy the tunnel) and
> > -c -r3 (to create the tunnel)
>
> When I call batmand with those parameters I can reproduce this much
> faster until
> no memory is available anymore. This happens on each call with these
> parameters.

ok, I'll check that again. Just to be sure, you observed this on WRT54GL with 
openWrt Whiterussioin Freifunk firmware? Did you compile the sources yourself 
or have you used precompiled binaries (which ones)? Because, last time I 
tried, I applied a lot of -cr0 and -cr3 and the memory usage did not increase 
endlessly.

>
> > there is a blackhole detection in the default two-way-tunnel. This can
> > cause the client to disconnect from the unresponsive (-blackhole-) GW and
> > put the GW on a blacklist for some time. It should all be reported on
> > debug-level 3. If no other GW is available, the GW-client node will
> > reconnect to the GW after
> > a while (might be 100 sec).
> > If you have a dummy GW, either use --no-unresp-gw-check or
> > use --one-way-tunnel 3 at the client and the GW side
>
> I like to have the blackhole detection enabled, it is a good way to
> detect an inactive GW beside of the ping-check-algorithm in the
> firmware.
> I assume that default is the two-way-tunnel where data goes from one
> node directly to the gw and back. Whatfor is the one-way-tunnel and
one-way-tunnel are completely stateless. No assigned virtual IPs, no need for 
SNAT,... Data is only tunnelled from the GW-Client to the GW-Node. THere it 
is de-tunnelled and forwarded. We used this setup at the 24c3 to let batman 
client nodes be accessible via global unique IPs. 

> what are the
> condtion for the one-way-tunnel being active.

if you type -cbd2 at a client node you may see:
WARNING: You are using BatMan-eXp 0.3-alpha rv898 (compatibility version 10) !
  Originator         bestNextHop   #
=> 103.131.41.5       103.131.83.5 100, gw_class 49 - 4MBit/1024KBit, 
reliability: 0, supported tunnel types 2WT, 1WT

2WT indicates the GW capabilities for two-way-tunnel, 1WT indicates ...

--dangerous shows:
...
 Gateway and tunneling options:

       --one-way-tunnel <value> : set preference for one-way-tunnel mode.
         For GW-nodes:  0 disables this tunnel mode, a larger value enables  
this tunnel mode.
         For GW-cliets: 0 disables this tunnel mode, a larger value sets the 
preference for this mode.
          default: 1, allowed values: 0 <= value <= 4

       --two-way-tunnel <value> : set preference for two-way-tunnel mode.
         For GW-nodes:  0 disables this tunnel mode, a larger value enables 
this tunnel mode.
         For GW-cliets: 0 disables this tunnel mode, a larger value sets the 
preference for this mode.
          default: 2, allowed values: 0 <= value <= 4

So essentially, to force a client node to only use one-way tunnel you must 
start the client with two-way-tunnel disabled (--two-way-tunnel 0 ) .
To configure the client node to prefer one-way-tunnel over two-way-tunnel 
start it with a higher preference for the one-way tunnel 
(e.g. --one-way-tunnel 3)


bye

/axel

>
> Why is the gw-thread deleted? If the problem lays in the pthread
> implementation
> it would be a workaround to keep the gw thread always active.
>
> I also think that the memory consumtion is more than 16kbyte, because
> the virtual memory is incremented and also the percentage used.
>
> Bye
> Stephan
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


