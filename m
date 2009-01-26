MIME-Version: 1.0
In-Reply-To: <200901240942.07893.lindner_marek@yahoo.de>
References: <238a15490901231630s7d460687x6a95238f7308998a@mail.gmail.com>
	<200901240942.07893.lindner_marek@yahoo.de>
Date: Mon, 26 Jan 2009 11:34:16 -0600
Message-ID: <238a15490901260934i1f4dcd30u7404cd79fff7a29c@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Sat, Jan 24, 2009 at 2:42 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
>
> Hi,
>
> > OPENMESH 2 - configuration
> > ==========================
> >
> > 1. I stop the routing daemons. It has ath0, ath1, ath2 interfaces.
> >    I again bridge these interfaces (br0 - ath0, ath1, ath2
> >
> >    I try getting an IP for this node usign the same method of running
> > udhcpc but i am unable to
> >    So I dont have an IP - but i dont worry about it now.
>
> You wont get an IP address on distant hosts (more than 1 hop) unless you have
> batman running. The adhoc network will not relay your message.
>
> B.A.T.M.A.N. advanced is a kind of bridging tool on its own. You should load
> the module and add the batman interfaces (in your case ath0). After configuring
> batman you will have a new interface called "bat0" which you can add to your
> bridge setup (br0 - ath1, ath2, bat0). Run udhcp on top of br0 now.
>

Thanks for your reply.

I do have the batman module running on openmesh2 as well and I have
included in the br0 (ath1, ath2, bat0).
I also have set ath0 in /proc/net/batman-advanced/interfaces.

I also run udhcpc specifying -i br0.  However I am unable to get an IP
for openmesh2.

So i was basically wondering if batman kernel module is running on
both openmesh routers and one of routers is
connected to eth0 (openmesh1) while the other is wirelessly connected
to openmesh1 (i.e. my openmesh2) - should
it receive an IP from my wired backbone?


> > Associate a client
> > ==================
> >
> > I now try to associate a client to open mesh 2.  Its IP request gets
> > forwarded to the wired network and it receives an IP
> > (192.168.50.6)
> >
> > However i can't batping to it from either openmesh 2 or openmesh 1
> > Is something missing in my configuration?
>
> You can't run the battools (e.g. batping) from a client that does not run
> batman advanced. The battools connect to the running batman to inject their
> ping requests. Batman will recognize these special packets and treat them
> accordingly.

Ok.  That makes sense that batping cannot ping clients (as they dont run batman)
Again my client when associated to openmesh1 (which is wired) gets an IP however
when connected to openmesh2 (wirelessly connected to openmesh1) does
not get an IP

I hope other than setting the interface "ath0" in
/proc/net/batman-advanced/interfaces - i dont
need any other configuration changes.

Since I can batping between the two routers i guess the layer 2
connectivity is established between
these guys - am just wondering if they should be able to forward
requests like dhcp over multiple hop
(1 hop and above)....



> Regards,
> Marek
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
