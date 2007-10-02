From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Tue, 2 Oct 2007 10:59:06 +0200
References: <20070608201844.GM20739@localhost>
	<560c7c9a0710011056v2c8b64ebj109e29ce00e42862@mail.gmail.com>
	<07EFF690-E02A-4B92-946E-0C67B32066E3@lo-res.org>
In-Reply-To: <07EFF690-E02A-4B92-946E-0C67B32066E3@lo-res.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710021059.06583.axel@open-mesh.net>
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

Hello,

We have used OpenVZ (linux-2.6.18-openvz-028.035.1) for emulating batman and 
olsr. 
Further background information about the setup is given here:
http://open-mesh.net/batman/doc/evaluation/setup-details
and about the general evaluation methodology here:
http://open-mesh.net/batman/doc/evaluation


Not yet documented but:
Recently also managed to run openVZ (with many virtuaized debian systems) 
inside of qemu-kvm. Used this for proof of concept, testing and performance 
evaluation.

This has the advantage of:
- having all relevant data in a qemu image. 
- The image could be easily transferred to another machine (actually Iam 
waiting to move it to texas). 
- could be easily backupped
- Any misconfiguration inside qemu does never harm your real system !!

The following worked:
- On  2GHz core duo notebook (qemu using only one processor and 800MB Ram)
  - More than 100 virtual instances idling in parrallel 
  - About 60 virtual instances running olsr or batman in parrallel

- use brctl, ebtables, TC, and NETEM for configuring virtual networks with
  - dedicated links
  - dedicated packetloss, delay for unicast and broadcast traffic

- Having all the tools like wireshark, tcpdump, ... for network monitoring,.

- Being able to monitor all virtualized VZ processes from the qemu system.

If somebody is interested in using or even helping to document and extend that 
system, would be really appreciated.

ciao,
axel


On Montag 01 Oktober 2007, Aaron Kaplan wrote:
> Benjamin Henrion wrote:
> > What about using OpenVZ instances (each instance has its own TCP IP
> > stack I think)?
> >
> > I did not manage to have a working 32bit UML kernel+busybox rootfs for
> > testing OLSR and/or batman (ifconfig did not work out with the busybox
> > rootfs version of
> > http://uml.nagafix.co.uk/BusyBox-1.5.0/BusyBox-1.5.0-x86-root_fs.bz2
> > and kernel version vmlinux-2.6.18.1-bb2), if someone can recommend me
> > one version for each of those.
>
> Well, I have not tried openVZ. I would be interested in it.
> UML is quite tricky to get right. As soon as our texas server is up
> and running again, I can
> give you kernel .config file which worked for me.
>
>
> best,
> aaron.
>
> ---
> there's no place like 127.0.0.1
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


