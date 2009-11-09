Return-Path: <mehrana@uow.edu.au>
Message-ID: <006301ca60f7$991ca3a0$f90a8282@sharlyn>
From: "Dr. Mehran Abolhasan" <mehrana@uow.edu.au>
References: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
Date: Mon, 9 Nov 2009 15:46:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] A peer-reviewed assessment of OLSR,
	BATMAN and Babel
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
To: Juliusz Chroboczek <jch@pps.jussieu.fr>, babel-users@lists.alioth.debian.org, olsr-users@lists.olsr.org, b.a.t.m.a.n@lists.open-mesh.net
Cc: Brett Hagelstein <bretth@uow.edu.au>, justin.lipman@gmail.com, Brett Hegelstein <brett.hagelstein@gmail.com>, Chun-Ping Wang <jerryw@uow.edu.au>

Hi All,

Many Thanks for all your comments. Just a couple of point of clarification.

1. The aim of this paper was to study all the protocols in their default 
settings. We did not
switch off ETX with olsr (note we used the olsr version from olsr.org). In 
fact the link quality metric was left to 2 by default. We are well aware 
that ETX provide more stable routes than hop count.

2. In terms of looking at performance using different parameters, we will be 
doing this in our future studies.
Also, note that the conference papers were limited to 4 pages only.

3. In terms of overheads, given that this was a small scale indoor test-bed, 
we believed the amount of overhead introduced into the network is not 
signficant enough to adversely affect the network. So we did not look into 
overheads for this paper, however we would do this for larger test-beds.

4. We previously ran OLSR using various different outdoor and indoor 
test-beds and at the time we were doing the experimentations BATMAN and 
BABEL were more stable.

We would be interested to hear what other aspects of the protocols (such as 
different parameters) you would like to see studied.


Kind regards,
Mehran




----- Original Message ----- 
From: "Juliusz Chroboczek" <jch@pps.jussieu.fr>
To: <babel-users@lists.alioth.debian.org>; <olsr-users@lists.olsr.org>; 
<b.a.t.m.a.n@lists.open-mesh.net>
Cc: "Mehran Abolhasan" <mehrana@uow.edu.au>; "Brett Hagelstein" 
<bretth@uow.edu.au>; "Chun-Ping Wang" <jerryw@uow.edu.au>
Sent: Saturday, November 07, 2009 6:05 AM
Subject: A peer-reviewed assessment of OLSR, BATMAN and Babel


I've just come upon an interesting paper that experimentally compares
the performance of OLSR, BATMAN and Babel.

    Real-world Performance of Current Proactive Multi-hop Mesh
    Protocols.  M. Abolhasan, B. Hagelstein, J. C.-P. Wang.

    http://ro.uow.edu.au/cgi/viewcontent.cgi?article=1747&context=infopapers

Short summary: see Table II on the last page.


A few comments on the paper:

1. Section II (the informal description of the protocols) doesn't make
   much sense.  Ignore it.

2. They evaluated original OLSR, not OLSR-ETX as used by our friends in
   Vienna and Berlin.

3. The results in Figure 3 would appear to imply that there's a bug in
   Babel -- it loses a packet every time it switches routes.  I think
   I understand why.

4. They ran the routing daemons with the default parameters.  This means
   that BATMAN ran with an OGM interval of 1 second, while Babel used
   a Hello interval of 4 seconds.  It would have been interesting to see
   the results with similar parameters.

5. They didn't measure the amount of routing protocol traffic.

                                        Juliusz

