From: Axel Neumann <neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs / certificates
Date: Fri, 19 Dec 2008 11:15:20 +0100
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812172114.43427.neumann@cgws.de>
	<3f7879383457743711ac3341637ff601.squirrel@wm.ddmesh.de>
In-Reply-To: <3f7879383457743711ac3341637ff601.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812191115.20610.neumann@cgws.de>
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

HI,

I like brainstorming like this.
We wanted batmand (and especially its core routing algorithm) to be decentral 
and simple. So no central point of control/failure and therefore also no HNA 
server. Of course there are many potential attack vectors in a community mesh 
and probably there will always be until you completely restrict the access. 
Therefore IMHO the preferable security to be solved should be:

- detect and protect against (usually accidental) misconfigurations like 
duplicate addresses.

- find mechanisms to limit the impact of denial of service or other attacks to  
the local environment (neighborhood).

Certificates and signatures might be a theoretical solution. I am not a 
security expert but many people have stated that frequent signature 
validation (like every OGM) will definitely exceed the cpu performance of the 
small embedded devices we use for our networks.

On Donnerstag 18 Dezember 2008, Stephan Enderlein (Freifunk Dresden) wrote:
> > Theoretically, if the node can reestablish a new connection after its
> > forced disconnection within the dad timeout (100secs by default) then it
> > should not be kicked out. But, the preliminary for this is that: the node
> > must re-appear using the same primary IP for its primary interface and
> > continuing with the foreseen sequence-number range.
>
> The router always will have the same IP. But it can take a little time to
> establish the vpn connection (over internet) to connect to other batman
> clouds. So it is possible that the 100 seconds are reached easily.
> At moment the firmware has no way to set the time of the forced
> disconnection. But If the user are using a different router or the firmware
> will later support a timed disconnection, it is possible that user leave
> the default time. Assuming this other may connect there disturbing routers
> at same time to turn off attractive nodes with many connections.
You can tweak the dulicate address timeout detection using --dad-timeout .

Because the duplicate address detection is working based on expected sequence 
numbers you can avoid being ignored by other nodes after a restart by 
correcting your initial sequence number to a number accepted by other nodes 
using --initial-seqno.


ciao,
axel

>
> All nodes must be reachable and they must ping the hna regulary (if ping is
> supported or check for certain services) and tell the local batmand to
> remove a specific hna from its internal list. But this is also
> not secure because the bad guy may redirect such requests and pretend the
> IP is reachable.
>
> I think there must be a central server that collects "HNA requests" if they
> are valid, the batman node that has requested to propagate a HNA can add
> it.
> For this batman should support such a procedure internally perhaps like the
> visualisation server, else the bad guy may simply add hna per command line.
> It should be possible to generate two versions of batmand, one that acts as
> HNA server (only few authenticated servers) and one as HNA client
> (requesting to publish HNA and build in in all nodes).
>
> To avoid running a faked batmand client to disturb a mesh, batman should
> support certificates to protect its OGM and other packets.
> Is there a way to make a batman network unique by using certificates?
> batman should always send signed OGM and other batman packets and also
> check for the correctness on receiption.
>
> For HNA authentication and signed batman traffic you may use cacert.org. If
> someone then tries to disturb a batman network by setting up its own HNA
> server, you just may look into the certificate to get the user.
>
> Cheers
>  Stephan
>
> ---------------------------------------
> Dipl.Informatiker(FH) Stephan Enderlein
> Freifunk Dresden
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


