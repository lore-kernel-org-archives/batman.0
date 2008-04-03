References: <003a01c894a2$8f7ebe00$ae7c3a00$@com>
	<20080403133445.GA29070@hrz.tu-chemnitz.de>
In-Reply-To: <20080403133445.GA29070@hrz.tu-chemnitz.de>
Subject: RE: [B.A.T.M.A.N.] Node with two wireless interfaces - to bridge them
	or not?
Date: Thu, 3 Apr 2008 16:58:09 +0200
Message-ID: <001001c8959b$2596d2d0$70c47870$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'Simon Wunderlich' <simon.wunderlich@s2003.tu-chemnitz.de>, 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Thanks, so I'll keep it as it is then as far as interfaces are concerned.

I would love to try out batman-adv with layer2 (as I truly believe that is the
only way forward in meshes) but as it stands all my routers are on rooftops and
if I mess something up I'm stuck! This way, I just keep updating batmand and it
works (but not as fast as I'd like it to be).

I've tried to play with FRAGmentation but setting it to anything other than off
(2346) the transfer (I use wget ftp://host/file) stops.
I played with RTS and I really don't know what to say. It is SO FRUSTRATING!
Yesterday I've had the mesh set up and it ran OK (1.7Mbps between two nodes - is
there ANYONE that gets 11Mbps, EVER?) but today nothing works. And it just keeps
driving me crazy. Every day I have to reset and re-test and fiddle with it. I
just need settings that work.  I just can't believe that with my rssi of 17-20,
which looks decent enough, I cannot get consistent performance. I believe
madwifi drivers also have a big role to play in my frustration. Also this
mixture of Broadcom and atheros is driving me crazy. 4 atheros and 1 broadcom,
and Broadcom just keeps quitting. After a day or two it disassociates and
disappears, then I have to go over and unplug it. MAD!

I wish there was someone out there who knows wireless inside-out and who would
be able to spare a day in helping me with getting this thing going. As it
stands, it just makes me want to give it all up and become a farmer or
something.

Pele

> -----Original Message-----
> From: Simon Wunderlich [mailto:simon.wunderlich@s2003.tu-chemnitz.de]
> Sent: Thursday, April 03, 2008 3:35 PM
> To: pele@balorda.com; The list for a Better Approach To Mobile Ad-hoc
> Networking
> Subject: Re: [B.A.T.M.A.N.] Node with two wireless interfaces - to bridge
> them or not?
> 
> Hello Pele,
> 
> bridging multiple interfaces is probably not a good idea, because as soon
> as you have a cycle there will be bridging loops. The frames will cycle
> until they are droppend and there is no TTL to stop them! :) In Ethernet, a
> solution for this is STP [1], which will cut off (one of) the links in the
> loop, but probably the good ones, so that is not what you want. That is
> what the mesh is supposed to do. But bridging would not bring you any
> performance increase anyway, so i'd suggest to stick with your current
> setup.
> (if you want to have only IP per interface for some reason, you can also
> have a look at batman-advanced).
> To increase multi-hop bandwidth you should better try the standard wifi
> ways to reduce interferences/packet loss. E.g. try to switch off rts,
> switch on fragmentation, limit baserate etc.
> 
> Best regards
> 	Simon
> 
> [1] http://de.wikipedia.org/wiki/Spanning_Tree_Protocol
> 
> On Wed, Apr 02, 2008 at 11:18:38AM +0200, Predrag Balorda wrote:
> > I have one node that has two wireless interfaces. I was thinking to
> > increase somewhat the multi-hop bandwidth loss and what is the best way
> of doing that.
> > Currently I have ath0 with two nodes on there and ath1 with another
> > two nodes but I'm not bridging those two interfaces. The thing is,
> > they are on the same subnet so is there any point in keeping them
> > "separate", any performance advantage, or should I just make a bridge
> > and add the two ath's to it and just have a single IP and run batman
> > on that one bridge or leave it as it is, with two IPs from the same
> subnet and run batman ath0 /w ath1 /w as I do currently?
> >
> > Pele
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

