Return-Path: <andrew@lunn.ch>
Date: Thu, 13 Feb 2014 10:57:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140213095736.GD7193@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-13-git-send-email-antonio@meshcoding.com>
 <20140212084022.GE30814@lunn.ch> <52FB6701.5000406@meshcoding.com>
 <20140213093650.GA7193@lunn.ch> <52FC9605.5050205@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FC9605.5050205@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 12/23] batman-adv: add base throughput
 attribute
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> I just checked what we do in the "improved GW bandwidth advertisement"
> introduced not so much time ago:
> 
> - we store the bandwidth value in Mbps/10
> - we print it in the form XX.YMbps
> + but we allow the user to specify the unit when entering the value in
> the sysfs interface: "xxxMbps" or "yyyKbps".
> 
> This way the user can pick the favourite unit, but of course the value
> is truncated (in the case of Kbps) to fit the internal representation.
> 
> What do you think about this approach?

I think that is good.

Thanks
	Andrew
