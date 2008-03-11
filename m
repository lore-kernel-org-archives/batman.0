Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze +  
	X-wrt]
From: Donald Davis <dondavis@reglue.org>
In-Reply-To: <47D63219.3020603@gmx.net>
References: <52469.70.253.200.118.1205190931.squirrel@webmail.reglue.org>
	<47D63219.3020603@gmx.net>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 07:00:03 -0500
Message-Id: <1205236803.4804.18.camel@krupskaya.is-a-geek.net.is-a-geek.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: dondavis@reglue.org,
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


On Tue, 2008-03-11 at 08:17 +0100, elektra wrote:
> I wrote: Use individual IPs for each interface! If you want to use 
> batman on all interfaces, assign IPs out of the mesh IP subnet range for 
> each interface.
> 
> I don't see that here:
> 
> ifconfig eth0.0 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig eth0.1 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig eth0 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig wl0 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255
> 

OHHHH! Each interface!  I was still thinking each router.  My apologies.

so instead I'll try
ifconfig eth0 103.0.0.30 netmask 255.0.0.0 broadcast 103.255.255.255 # I
might leave out eth0.  I looked at netstat -rn and I believe setting the
ifconfig for eth0 might have hosed my Internet connection.  

ifconfig eth0.0 103.0.0.300 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.1 103.0.0.31 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255

> And: Ports 4305-4307 are for the new versions of batman - which one are 
> you using?

batman 0.2 compatibility version 3

which visualization server program do you recommend?

Thank you.  

