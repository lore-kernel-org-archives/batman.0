Date: Wed, 4 Jun 2008 01:30:17 +0200
From: Benjamin Henrion <bh@udev.org>
Subject: Re: [B.A.T.M.A.N.] Multiple radios to improve throughput
Message-ID: <20080603233017.GU2265@localhost>
References: <48448358.4070505@changind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48448358.4070505@changind.com>
Sender: Benjamin Henrion <zoobab@ffii.org>
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

Shane Chao <schao@changind.com> [080603]:
> Elektra,
> 
> Thank you for pointing out in May 08 that most embedded boards do not 
> have enough CPU power to saturate the capacity of single radio link.  I 
> was experimenting Batman in a straight line, three node configuration 
> with the middle node having two radios so it doesn't have to switch 
> between node 1 and node 3.  My configuration is as follows:
> 
> node 1          node 2          node 3
> ------          ------          ------
>  ath0 <--ch 1--> ath0
>                  ath1 <--ch 11-> ath0
> 
> When I ran iperf between node 1 and 3, I did not see any throughput 
> improvements with either one or two radios in node 2. I even stopped 
> Batman and manually setup the routes and the performance remains the 
> same.  However, when I upgrade node 2 from a 200MHz CPU board to a 
> 500MHz CPU board, the bandwidth went up 50%.  So thanks again for 
> pointing out my bottleneck:)
> 
> Lastly, can someone suggest some embedded boards fast enough to push 
> wifi radios to its limits?

Make a test with 2 atheros minipci cards on a Alix 3C3 (500mhz) and try
to find out if the CPU is saturated.

--
Benjamin Henrion <bhenrion@ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
