From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 24 Jan 2009 09:42:07 +0100
References: <238a15490901231630s7d460687x6a95238f7308998a@mail.gmail.com>
In-Reply-To: <238a15490901231630s7d460687x6a95238f7308998a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901240942.07893.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Help in batman advanced configuration
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
To: b.a.t.m.a.n@open-mesh.net


Hi,

> OPENMESH 2 - configuration
> ==========================
>
> 1. I stop the routing daemons. It has ath0, ath1, ath2 interfaces.
>    I again bridge these interfaces (br0 - ath0, ath1, ath2
>
>    I try getting an IP for this node usign the same method of running
> udhcpc but i am unable to
>    So I dont have an IP - but i dont worry about it now.

You wont get an IP address on distant hosts (more than 1 hop) unless you have 
batman running. The adhoc network will not relay your message.

B.A.T.M.A.N. advanced is a kind of bridging tool on its own. You should load 
the module and add the batman interfaces (in your case ath0). After configuring 
batman you will have a new interface called "bat0" which you can add to your 
bridge setup (br0 - ath1, ath2, bat0). Run udhcp on top of br0 now.


> Associate a client
> ==================
>
> I now try to associate a client to open mesh 2.  Its IP request gets
> forwarded to the wired network and it receives an IP
> (192.168.50.6)
>
> However i can't batping to it from either openmesh 2 or openmesh 1
> Is something missing in my configuration?

You can't run the battools (e.g. batping) from a client that does not run 
batman advanced. The battools connect to the running batman to inject their 
ping requests. Batman will recognize these special packets and treat them 
accordingly.

Regards,
Marek


