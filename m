From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 May 2009 12:30:02 +0800
References: <1242937180.14711.14.camel@turing.asconix.lan>
In-Reply-To: <1242937180.14711.14.camel@turing.asconix.lan>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905231230.16394.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] VIS server for batman-adv-kernelland
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

> For the German readers: I am documenting all the stuff on
> http://debian.asconix.com/batman-advanced-openwrt-howto but I think, the
> way I'm describing in the vis chapter is the way to get vis running in
> layer3 batman, isn't it?

its fantastic that you write such an extensive documentation. As soon as you 
feel ready I will add a link from our page to yours, so that people can find 
you.

I think there are 2 hidden misunderstandings in the howto:

* You are splitting up the VLANs and I did not quite get the reason. In the 
document you state the number of OGMs will be decreased. Whether it decreases 
or not heavily depends on the network attached to these VLANs. How does the 
topology look like ? May be I overlooked that section ?

* The vis-advanced daemon is not necessary here because the kernel module has 
the server built-in. All you need to do is activating a server (echo "server" 
> /proc/net/batman-adv/vis) which allows you to retrieve the information via 
cat /proc/net/batman-adv/vis. The vis-advanced daemon goes together with 
batman-adv-userspace which is the user space implementation of the layer 2 
approach. Its a bit confusing - we have to think about how to clean it up ..

In case you are aware of all these facts just discard my mail.  :-)

Regards,
Marek

