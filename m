Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 9 Nov 2016 06:33:30 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161109053330.GH3391@otheros>
References: <581C7F4A.80104@yahoo.com> <2907018.3yHk8Vyvxo@sven-edge>
 <mailman.63.1478602511.678.b.a.t.m.a.n@lists.open-mesh.org>
 <23104849.8bNq0ZtGq3@prime> <58229D06.8030207@yahoo.com>
 <mailman.87.1478663809.678.b.a.t.m.a.n@lists.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mailman.87.1478663809.678.b.a.t.m.a.n@lists.open-mesh.org>
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

On Wed, Nov 09, 2016 at 04:56:52AM +0100, johnzeng via B.A.T.M.A.N wrote:
> Date: Wed, 09 Nov 2016 11:56:36 +0800
> From: johnzeng <johnzeng2013@yahoo.com>
> To: Simon Wunderlich <sw@simonwunderlich.de>
> CC: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>,
>  Martin Hundebøll <martin@hundeboll.net>
> Subject: Re: [B.A.T.M.A.N.] i have a question ? How many relay nodes can be
>  supported at NetworkCoding ( mtu 1546 ) .
> >                              if Relay mode is based on Layer 3 ( route or
> >Nat ) , it will be very complex and Infeasible at large wifi network

No, batman-adv has nothing to do with layer 3. For clients in batman-adv it
all looks like one, big switch.

It does that not by layer3 routing or layer3 NAT'ing, but by
encapsulating frames in its own headers.
