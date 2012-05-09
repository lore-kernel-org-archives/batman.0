Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 May 2012 19:33:23 +0800
References: <4FA54C09.6000303@universe-factory.net>
	<4FA916EB.8030609@universe-factory.net>
	<CAHD-aqKEcv0F7ZKL1xsXOj8k1ZvRM1YXvOYKadj44SUBPpff4g@mail.gmail.com>
In-Reply-To: <CAHD-aqKEcv0F7ZKL1xsXOj8k1ZvRM1YXvOYKadj44SUBPpff4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201205091933.23792.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, May 09, 2012 04:52:18 Guido Iribarren wrote:
> > I see your point, but then one could also ask why the visualization has
> > to be in the kernel at all...

That is a valid question and has been debated several times already. The vis 
server is a borderline case - the consensus is/was that it's more convenient 
to have it in the kernel together with the routing protocol, so that it could 
easily tap into the routing data and make good use of it.
Obviously, that also could be done in user space while all relevant data is be 
exported but it also creates enough burden to outweigh the "kernel bloat".


> visualization just means collecting information batman is already handling.
> neighbour information is essential to normal working, and generating a
> "vd dot" just exports that info.
> hostnames, (ip addresses, etc) on the other hand, are not of interest
> to current code

Correct.


> That said, I would also love to find a solution to this, since
> maintaining the /etc/bat-hosts in the nodes simply doesn't escalate in
> my opinion,
> and Marek' suggestion about "several ways to implement this feature in
> user space today" is not entirely clear to me:
> mDNS solutions like avahi translate between hostnames and ips, while
> batman visualization deals with MACs, and those cannot necessarily be
> obtained from IPs (in some cases, ARP will help, but won't work in
> interfaces without IPs)

I don't want to endorse a specific solution. Batman-adv creates a single 
ethernet broadcast domain. Every simple broadcasting tool will work across the 
entire mesh network. You could even write your own simple script that just 
broadcasts the hostname / ip address / $whatever. On the other end you have a 
script that listens to the broadcasts to populate your bat-hosts file / 
database / etc.

Regards,
Marek
