Return-Path: <andrew.lunn@ascom.ch>
Date: Thu, 16 Jul 2009 09:32:03 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090716073203.GS19071@ma.tech.ascom.ch>
References: <20090714163750.GR19071@ma.tech.ascom.ch>
	<200907160200.31170.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907160200.31170.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] VIS startup race condition fix	plus
	coding style?cleanup
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

> Sorry, the code review of this patch took a bit more time as it is a quite 
> long one and mixes several topics:
> * coding style cleaning
> * race condition
> * struct changes and their respective code modifications
> * moving a variable to proc.c
> 
> It would be very helpful if you split the patch into smaller parts before I 
> submit them. Is that feasible ?

I will try. It will probably end up in three patches, cleanup, race
fix, variable move. The struct changes are part of the race fix.

> Nevertheless, I dug through and noticed you modified the struct vis_info by 
> adding "struct vis_info_entry entries[130];". This would lead to an allocation 
> of nearly 1KB (130 * 7 Bytes) for every incoming vis packet. Is that 
> intended ? 

Yes, this is intentional, although maybe i've missed something subtle
in the code. The old code allocates one instance of vis_info in
vis_init() by kmalloc()'ing 1000 bytes. In generate_vis_packet() there
are checks to ensure we don't go over this 1000 byte limit. I don't
like this 1000 magic number and decided to clean it up. 

As you said, 130 * 7, is nearly 1K, so the overall memory usage should
not of changed. 

Now, looking deeper, there is something subtle i missed. When sending,
in send_vis_packet(), it calculates the packet length based on the
number of used entries and only sends that many bytes. So in
receive_server_sync_packet() which calls add_packet() it would only
kmalloc() as much space needed for the received packet. My code
allocated the maximum packet size. So i'm wasting space here. I will
rework this code.

> I also applied your coding style patches for bitarray.[ch] and hash.[ch]. 

Thanks

        Andrew
