References: <709285.93018.qm@web26901.mail.ukl.yahoo.com>
	<200711061057.26215.axel@open-mesh.net>
In-Reply-To: <200711061057.26215.axel@open-mesh.net>
Subject: RE: AW: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780
Date: Wed, 7 Nov 2007 02:05:52 +0100
Message-ID: <000301c820da$5c489880$14d9c980$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Reply-To: pele@balorda.com,
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

My sincere apologies!

I have gone through the whole setup once again today and now gate0 stays up
and running on all client nodes, it was my iptables setup on middle client
node that was forwarding nat-ted traffic onto ath1 instead of gate0. Sorry
again. Now everything seems stable and nice. I am getting between
600-800KB/s TCP from gateway with 3 nodes which, I presume, is a nice
figure, unless -exp offers something more?

I have gone by the advice and put all radios onto the same subnet. Now
traceroute from one node onto another takes ages to do (with single-radio
setup it was nice and showed me exactly what I was expecting) - I guess it
has something to do with two interfaces with the same mask etc etc? Also
doesn't this set-up hurt performance if the linux kernel sends packets with
the same broadcast address down the first interface it finds, even though
that interface might be the radio with worse connectivity than the second
one? How should we handle this?

Pele

P.S. who do I complain to about vis not showing ALL my interfaces
(dual-radio units) as distinct IP addresses and their connections to others
but instead just takes the first interface on the subnet so instead of
having 6 nodes on my diagram I only have 3 and each one has a host-hna
attached to it (I'd rather not burden this list with mime attachments)?

-----Original Message-----
From: b.a.t.m.a.n-bounces@open-mesh.net
[mailto:b.a.t.m.a.n-bounces@open-mesh.net] On Behalf Of Axel Neumann
Sent: Tuesday, November 06, 2007 10:57 AM
To: The list for a Better Approach To Mobile Ad-hoc Networking
Subject: Re: AW: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780

On Dienstag 06 November 2007, Marek Lindner wrote:
> > The non-usual setup: you have different parts of your mesh operating in
> >
> > different subnets you need an additional ip rule to make the nodes in
>
>  the
>
> > non-homed subnet reachable from a node which has no interface in that
>
>  subnet.


