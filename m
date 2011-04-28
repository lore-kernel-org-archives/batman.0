Return-Path: <andrew@lunn.ch>
Date: Thu, 28 Apr 2011 18:10:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110428161031.GB4240@lunn.ch>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303940106-1457-3-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
 announcement mechanism
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Apr 27, 2011 at 11:35:04PM +0200, Antonio Quartulli wrote:
> The old HNA mechanism has been totally rewritten from scratch.
> The new mechanism consists in announcing local translation-table changes
> only, reducing the protocol overhead.
> 
> For details, please visit:
> http://www.open-mesh.org/wiki/batman-adv/Hna-improvements
> 
> Moreover:
> - COMPAT_VERSION has been increased to 14
> - batman-adv now depends on module "crc16" for tt crc computation

Hi Antonio

Shouldn't this dependency be listed in the Kconfig file? I think you
need to add

select CRC16

See for example ./drivers/w1/slaves/Kconfig. 

    Andrew
