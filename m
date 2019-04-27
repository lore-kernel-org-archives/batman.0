Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 27 Apr 2019 04:53:02 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190427025302.GL6201@otheros>
References: <20190426171231.18156-1-linus.luessing@c0d3.blue>
 <1906609.VMlLDzDynG@rousseau> <20190427023848.GK6201@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190427023848.GK6201@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood"
 broadcast flood prevention option
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sat, Apr 27, 2019 at 04:38:49AM +0200, Linus Lüssing wrote:
> The desired behaviour in this case would be to let multicast packets pass
> unless they would be flooded. A firewall does not know which
> mechanism batman-adv would choose. Hence this option within
> batman-adv to create this desired behaviour.

Or in other words: I want to allow people to experiment with and use
multicast in a variety of undefined applications. But I don't want
them to break things for everyone else (which could happen with no
firewall rules, too many listeners and a broadcast flooding
fallback).
