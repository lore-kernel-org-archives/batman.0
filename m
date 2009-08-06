Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 6 Aug 2009 23:55:46 +0800
References: <200908051533.26117.lindner_marek@yahoo.de>
	<200908062226.21948.lindner_marek@yahoo.de>
	<SNT107-W15FB756F128D90901F56F5A60A0@phx.gbl>
In-Reply-To: <SNT107-W15FB756F128D90901F56F5A60A0@phx.gbl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908062355.46465.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Some handholding for batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Thursday 06 August 2009 23:47:26 nick farrow wrote:
> It looks like its back to the earlier version of that did work (batman
> 0.2-rv478-1) just that it did not forward same subnet arps. I realise that
> performance is not going to be great with this but it will work

There still is some confusion - we had three branches:
- batman daemon layer 3
- batman daemon layer 2
- batman kernel module layer 2

The batman daemon layer 2 had performance issues because a mesh on layer 2 
requires that the daemon transports all the data itself. On layer 3 the daemon 
will manipulate the kernel routing table and let the kernel handle the 
transport of the data. If you go back to revision 478 you refer to the daemon 
on layer 3 which does not have performance issues but operates on layer 3 (as 
you correctly noticed).

The batman daemon on layer 2 was removed due the performance issues I 
mentioned earlier and the confusion it created.  :-)


> To do this do I basically setup one subnet for the batman nodes to run in,
> then further subnets for the hosts at each wrt batman mesh node, then just
> configure each batmand node to announce the host subnet?
>
> So for a 3 node mesh, break the default bridge, assign a static network
> address to the eth0, assign a different subnet address to wl0

Yes, that is one feasible option.


> eth0 172.16.1.1/24
> wl0 192.168.1.1
> run with batmand -a 172.16.1.0 wl0

batmand -a 172.16.1.0/24 wl0


> eth0 172.16.2.1/24
> wl0 192.168.1.2
> run with batmand -a 172.16.2.0 wl0
batmand -a 172.16.2.0/24 wl0


> Does this look correct to allow say 172.16.1.2 on the ethernet of mesh1 to
> ping 172.16.2.2 on the ethernet of mesh2?

Yes, if the clients connected to the ethernet have a default route towards 
their respective WRT.

Regards,
Marek

