Subject: RE: [B.A.T.M.A.N.] Multiple radios to improve throughput
From: Mark Kelly <mark.kelly@cadre5.com>
In-Reply-To: <000601c8c553$3630bba0$a29232e0$@com>
References: <48448358.4070505@changind.com>
	<000601c8c553$3630bba0$a29232e0$@com>
Content-Type: multipart/alternative; boundary="=-/GIxvUQAH8gnuXtv7lOL"
Date: Thu, 05 Jun 2008 08:39:07 -0400
Message-Id: <1212669547.6960.7.camel@mkellyDell>
Mime-Version: 1.0
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


--=-/GIxvUQAH8gnuXtv7lOL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I too would like to see this benchmark setup.  I have a private mesh
that I've been using batman and olsr on that consists of about 8 nodes
that end up spread out of about a 2000m x 2000m area and right now I'm
only using one radio for the mesh.  I'm pushing video from about 4 of
these nodes and if I try to do more than 2 hops with the video I see
drastic drops in the video performance.

I use Avila Gateworks boards that have 533 MHz Intel Xscale processors
and I've never seen the cpu even close to taxed by batman, olsr, or the
radios, as a point of reference for the original poster.  They also have
a newer board with a 633 Mhz cpu.  

On Tue, 2008-06-03 at 10:24 +0200, Predrag Balorda wrote:

> Now, is this CPU bottleneck because of batman and routing or something else?
> (cannot forward packets fast enough?)
> 11mbits isn't really that much and I still have to see my setup hit that figure
> between only two nodes, let alone multi-hop.
> 
> Now that we've played around a bit can someone please provide some benchmarks of
> a 5-node network (with some multi-hop paths) with batman and with just the whole
> network bridged and on the same subnet.
> 
> What sort of performance should you expect in either scenario?
> 
> As I said before, I used to get 1MB/s with non-routed bridged network of two
> atheros devices but ever since I started using batman, 300KB/s is the most I was
> ever able to achieve between the same two nodes. 2 hops and it goes down to
> 40KB/s.
> 
> > -----Original Message-----
> > From: b.a.t.m.a.n-bounces@open-mesh.net [mailto:b.a.t.m.a.n-bounces@open-
> > mesh.net] On Behalf Of Shane Chao
> > Sent: Tuesday, June 03, 2008 1:34 AM
> > To: b.a.t.m.a.n@open-mesh.net
> > Subject: [B.A.T.M.A.N.] Multiple radios to improve throughput
> > 
> > Elektra,
> > 
> > Thank you for pointing out in May 08 that most embedded boards do not
> > have enough CPU power to saturate the capacity of single radio link.  I
> > was experimenting Batman in a straight line, three node configuration
> > with the middle node having two radios so it doesn't have to switch
> > between node 1 and node 3.  My configuration is as follows:
> > 
> > node 1          node 2          node 3
> > ------          ------          ------
> >   ath0 <--ch 1--> ath0
> >                   ath1 <--ch 11-> ath0
> > 
> > When I ran iperf between node 1 and 3, I did not see any throughput
> > improvements with either one or two radios in node 2. I even stopped
> > Batman and manually setup the routes and the performance remains the
> > same.  However, when I upgrade node 2 from a 200MHz CPU board to a
> > 500MHz CPU board, the bandwidth went up 50%.  So thanks again for
> > pointing out my bottleneck:)
> > 
> > Lastly, can someone suggest some embedded boards fast enough to push
> > wifi radios to its limits?
> > 
> > Thanks,
> > Shane
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> 
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> 

--=-/GIxvUQAH8gnuXtv7lOL
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.18.2">
</HEAD>
<BODY>
I too would like to see this benchmark setup.&nbsp; I have a private mesh that I've been using batman and olsr on that consists of about 8 nodes that end up spread out of about a 2000m x 2000m area and right now I'm only using one radio for the mesh.&nbsp; I'm pushing video from about 4 of these nodes and if I try to do more than 2 hops with the video I see drastic drops in the video performance.<BR>
<BR>
I use Avila Gateworks boards that have 533 MHz Intel Xscale processors and I've never seen the cpu even close to taxed by batman, olsr, or the radios, as a point of reference for the original poster.&nbsp; They also have a newer board with a 633 Mhz cpu.&nbsp; <BR>
<BR>
On Tue, 2008-06-03 at 10:24 +0200, Predrag Balorda wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Now, is this CPU bottleneck because of batman and routing or something else?
(cannot forward packets fast enough?)
11mbits isn't really that much and I still have to see my setup hit that figure
between only two nodes, let alone multi-hop.

Now that we've played around a bit can someone please provide some benchmarks of
a 5-node network (with some multi-hop paths) with batman and with just the whole
network bridged and on the same subnet.

What sort of performance should you expect in either scenario?

As I said before, I used to get 1MB/s with non-routed bridged network of two
atheros devices but ever since I started using batman, 300KB/s is the most I was
ever able to achieve between the same two nodes. 2 hops and it goes down to
40KB/s.

&gt; -----Original Message-----
&gt; From: <A HREF="mailto:b.a.t.m.a.n-bounces@open-mesh.net">b.a.t.m.a.n-bounces@open-mesh.net</A> [<A HREF="mailto:b.a.t.m.a.n-bounces@open">mailto:b.a.t.m.a.n-bounces@open</A>-
&gt; mesh.net] On Behalf Of Shane Chao
&gt; Sent: Tuesday, June 03, 2008 1:34 AM
&gt; To: <A HREF="mailto:b.a.t.m.a.n@open-mesh.net">b.a.t.m.a.n@open-mesh.net</A>
&gt; Subject: [B.A.T.M.A.N.] Multiple radios to improve throughput
&gt; 
&gt; Elektra,
&gt; 
&gt; Thank you for pointing out in May 08 that most embedded boards do not
&gt; have enough CPU power to saturate the capacity of single radio link.  I
&gt; was experimenting Batman in a straight line, three node configuration
&gt; with the middle node having two radios so it doesn't have to switch
&gt; between node 1 and node 3.  My configuration is as follows:
&gt; 
&gt; node 1          node 2          node 3
&gt; ------          ------          ------
&gt;   ath0 &lt;--ch 1--&gt; ath0
&gt;                   ath1 &lt;--ch 11-&gt; ath0
&gt; 
&gt; When I ran iperf between node 1 and 3, I did not see any throughput
&gt; improvements with either one or two radios in node 2. I even stopped
&gt; Batman and manually setup the routes and the performance remains the
&gt; same.  However, when I upgrade node 2 from a 200MHz CPU board to a
&gt; 500MHz CPU board, the bandwidth went up 50%.  So thanks again for
&gt; pointing out my bottleneck:)
&gt; 
&gt; Lastly, can someone suggest some embedded boards fast enough to push
&gt; wifi radios to its limits?
&gt; 
&gt; Thanks,
&gt; Shane
&gt; _______________________________________________
&gt; B.A.T.M.A.N mailing list
&gt; <A HREF="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</A>
&gt; <A HREF="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</A>

_______________________________________________
B.A.T.M.A.N mailing list
<A HREF="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</A>
<A HREF="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</A>

</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-/GIxvUQAH8gnuXtv7lOL--
