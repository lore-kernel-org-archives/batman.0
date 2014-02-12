Return-Path: <andrew@lunn.ch>
Date: Wed, 12 Feb 2014 09:42:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140212084213.GF30814@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-12-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-12-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 11/23] batman-adv: add throughput attribute
 to hard_ifaces
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

On Tue, Feb 11, 2014 at 01:48:11PM +0100, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> This attribute is exported to the user which can manually
> select its value. It is the throughput value to be used
> by default when batman-adv is trying to compute the link
> throughput towards a neighbour using this interface.
> 
> If the value is set to 0 then batman-adv will try to detect
> the throughput by itself.

sysfs documentation is missing, but i guess you know what.

      Andrew
