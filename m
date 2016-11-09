Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 9 Nov 2016 06:28:15 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161109052815.GG3391@otheros>
References: <581C7F4A.80104@yahoo.com> <2907018.3yHk8Vyvxo@sven-edge>
 <mailman.63.1478602511.678.b.a.t.m.a.n@lists.open-mesh.org>
 <23104849.8bNq0ZtGq3@prime>
 <mailman.86.1478663442.678.b.a.t.m.a.n@lists.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mailman.86.1478663442.678.b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: [B.A.T.M.A.N.] i have a question ? How many relay nodes can be
 supported at NetworkCoding ( mtu 1546 ) .
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Nov 09, 2016 at 04:50:45AM +0100, johnzeng via B.A.T.M.A.N wrote:
> Date: Wed, 09 Nov 2016 11:50:30 +0800
> From: johnzeng <johnzeng2013@yahoo.com>
> To: Simon Wunderlich <sw@simonwunderlich.de>
> CC: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>,
>  Martin Hundebøll <martin@hundeboll.net>
> Subject: Re: [B.A.T.M.A.N.] i have a question ? How many relay nodes can be
>  supported at NetworkCoding ( mtu 1546 ) .
> 
>                              I can understand network coding , it will be
> same as proxy or Intermediator at Layer 2 ,

Maybe there is a complete misunderstanding what "network coding"
is?

Maybe an easier expression would be "packet mixing" or "magic packet
mangling" [1].

Any code that does something with networking is usually *not*
"network coding" (at least in this context here).

Have a look at the links Sven has provided earlier.

> 
> 
>                             Your meaning :  Batman-adv can build Similar
> mechanism ( Intermediator )  via intermediator , it wil be  relay based real
> application packet ( not relay based Broadcast packet)

Just try it :-). Compile batman-adv *without network coding* with
your A-B-C scenario and see how it magically works, too :-).

Regards, Linus


[1]: Please no expert hit me :D. I know, ultimately, network coding would
replace packet based networks, if I remember Frank's talk
in Leipzig correctly

https://www.youtube.com/watch?v=yluj7e_rfVE
