From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 24 Mar 2009 01:13:32 +0800
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
	<200903210913.15292.lindner_marek@yahoo.de>
	<3ebdcf0a0903210607v5346dfbn7bb2e1f5bce854b4@mail.gmail.com>
In-Reply-To: <3ebdcf0a0903210607v5346dfbn7bb2e1f5bce854b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903240116.07288.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> In such a meshbox, I installed OpenWRT Kamikaze 8.09.
> In order to do that, I downloaded the OpenWRT trunk and all the
> available packages from the OpenWRT repository.
> Then, I built the image selecting all the interesting packages; among
> these packages, in the network section,
> I selected batmand (B.A.T.M.A.N. 3 routing daemon).
> By the way, I did not compile batman by myself but it was directly
> integrated in the Kamikaze image.

I downloaded the OpenWRT trunk and compiled the i386 image before loading it 
into a qemu environment. I can confirm that batman does nothing if started 
without a debug level. It seems the main thread is not doing anything. 
Interestingly, if I compile & run batman on my debian machine it runs without 
problems. I guess OpenWRT uses some different libs / compile time options / etc 
that provoke that problem.

As a short term workaround I suggest you start batman with a debug level and 
redirect the output:
batmand -d 3 wlan0 > /dev/null 2>&1

I will try to debug this during the coming days but can't promise anything as 
I'm looking for the needle in the haystack.

Regards,
Marek

