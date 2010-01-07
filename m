Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 8 Jan 2010 05:38:07 +0800
References: <5522db2e1001070635m2f53c430sabf642e701ff24f4@mail.gmail.com>
	<201001080152.21832.lindner_marek@yahoo.de>
	<5522db2e1001071312s3261ac6akd959b86c09875c81@mail.gmail.com>
In-Reply-To: <5522db2e1001071312s3261ac6akd959b86c09875c81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201001080538.07946.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] link local mcast
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

On Friday 08 January 2010 05:12:33 ecfu wrote:
> I guess I am confused then...  I am trying to see my avahi services on the
> other side of a hop.  the middle node sees the services of both ends, but
> the ends do not see the services of each other.  After talking to the Avahi
> users group, they seemed to think this had something to do with batman
> advanced implementation of its mcast routing.  If you say they are flooded
> through the network, is there another reason why I wouldn't see the mDNS
> broadcasts over the hop?

So, you have 3 nodes (let's call them A/B/C) in a row. A sends mDNS data, B 
receives it but C does not ?
The best starting point is "batctl td" or wireshark which allow you to inspect 
the packets. You could verify what happens with your broadcasts. Feel free to 
post your logs here.

Regards,
Marek
