Return-Path: <andrew@lunn.ch>
Date: Wed, 12 Feb 2014 08:44:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140212074422.GB30814@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-8-git-send-email-antonio@meshcoding.com>
 <20140211171207.GE24633@lunn.ch> <52FA6347.2050901@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FA6347.2050901@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 07/23] batman-adv: OGMv2 - add basic
 infrastructure
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

> >> +	bat_priv->bat_v.ogm_buff_len = BATADV_OGM2_HLEN;
> >> +	ogm_buff = kmalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);
> > 
> > Maybe use kzalloc to ensure it is zero?
> 
> Not really needed because each field is explicitly assigned later. But
> to be sure we sit on the safe side we can do that: in the end we are not
> in the fastpath here.

I know some of your structures have explicit align bytes. It would be
good to ensure they are zero so that they could be used in the future
without having a protocol version bump. So i think it is a good
patterns to follow in general when not on the fast path.

	Andrew
