Return-Path: <hw@haveyouseenthiscat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Jun 2015 22:34:34 +0200
From: Hans-Werner Hilse <hw@haveyouseenthiscat.de>
In-Reply-To: <CALaFpeXinpuqi_5tZoih9jm77Ed0WsP_soZm3RbTpOmpzqWPSg@mail.gmail.com>
References: <CALaFpeXinpuqi_5tZoih9jm77Ed0WsP_soZm3RbTpOmpzqWPSg@mail.gmail.com>
Message-ID: <ba0c1c011cd6fb42c76276ec510c9acc@hilses.de>
Subject: Re: [B.A.T.M.A.N.] [BATMAN] batman-adv PING layer 3
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi,

Am 2015-06-17 21:50, schrieb Carlos Meralto:
> My configurations:
> [...]

a batman interface is being set up, but left unconfigured.

On the other hand, you set up IP adresses for the adhoc network, which 
probably isn't needed and the point where the confusion arises.

What you probably want to do is to add bat0 to the bridge's interfaces, 
and maybe get rid of the IPv4 addresses on the adhoc interface, too (not 
that they matter, though).

Of course, when you do not want to bridge the LAN interfaces, you need 
another way to setup IP addresses for bat0.

BTW, ping6 should work already with the link local IPv6 addresses of the 
bat0 interfaces, I guess.

-hwh
