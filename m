Message-ID: <46742217.4080504@poelzi.org>
Date: Sat, 16 Jun 2007 19:47:03 +0200
From: Daniel Poelzleithner <poelzi@poelzi.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] dynamic network annoucments
References: <4672C430.1020208@poelzi.org>
	<200706161105.23131.axel@open-mesh.net>
In-Reply-To: <200706161105.23131.axel@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Axel Neumann wrote:

>> why ?
>> we are working on the posibility to give a computer in the mesh a unique
>> ip, besides the network the node is serving. if you assign a unique ip
>> to a computer, and get a dhcp lease of another node, the node would then
>> add your ip as a hostroute announcement to batman, which would overwrite
>> the default place: your home network. this would mean real mobile ip
>> without the overhead of sending the traffic to your home router and then
>> forward to your actual position.
> Thats interesting but seems too complex for me, can you explain the approach 
> in more detail.

we here in leipzig freifunk will soon assign a network to people as
house networks. we will later make it possible to assign ips to mac
addresses. with the new dnsmasq you can run scripts, which would check
the mac list. if he finds a mac, he will assign this ip, add a hostroute
and would notify batman that this host is here via the interface i
proposed. some checking must be done to remove those networks later, but
thats a minor problem.

because hostroutes have higher priority then network routes, the
notebook will be available as it should be.

the only problem i see so far is the growth of the routing table, but i
think if this problem acutally makes impact, this could be fixed with
using different routing tables. i never looked at the routing table
implementation, if it would perform better if a ip rule + secound table
or one big table is faster. i guess the first one.

>>From my understanding, Mobile ip means that a node is reachable by a unique 
> and not-changing IP address and independent from the current point of 
> attachment to an access network. I do not understand how your mobile node can 
> maintain TCP scessions with corresponding nodes in the GBI while switching 
> the MESH-GBI GW. 

i don't know if mobile ip means roaming without breaking tcp
connections, i think this is much harder. i think the posibilty that a
computer is reachable through one ip in the complete network without
useless routing is at least better then all the mobile ip stuff i have
seen so far.

>> besides this, it would allow better integration into bgp by simply
>> spawning a script to add/remove routes via zebra.

i looked at quagga but didn't found the posibility to add routes that
way, so a small cron job/daemon will have to do this job...


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: GnuPT 2.7.2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGdCIIy/mkIQp7AD0RAi+xAJ9dVquTKsK6DLzjijhNiTCeQtbsrgCgvWhk
RqmImPCk9pYYM2cOBmxIW1Y=
=XtfH
-----END PGP SIGNATURE-----
