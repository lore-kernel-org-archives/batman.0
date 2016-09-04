Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 4 Sep 2016 17:07:04 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160904150704.GE8395@otheros>
References: <CAA_JP8UttdRRoNtKGm6K4TdzZd5kyicd93szDV6S-m0_cstN9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA_JP8UttdRRoNtKGm6K4TdzZd5kyicd93szDV6S-m0_cstN9A@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] 802.1x on top of batman-adv
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Dan,

On Mon, Aug 08, 2016 at 11:30:54PM -0600, dan wrote:
> any consideration to making a batman-adv 802.1x interface?  or anyone
> tested successfully using hostapd for wireless and wired clients and
> 802.1x?
> 
> Combining batman-adv's layer2 mesh and some NAC would be very handy.

I'd be very very interested in something like this, too. Did you
have any success with hostapd yet?

What I'm interested in in particular: Moving the authenticator
from the wireless AP to some device somewhere else in the mesh.
The wireless AP should then choose to forward to an authenticator
based on the username provided (some authentication protocols
use non-anonymous usernames).

Regards, Linus
