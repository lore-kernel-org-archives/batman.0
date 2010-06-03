Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Jun 2010 17:15:53 +0800
References: <1275509418.23599.42.camel@Joe-Laptop.home>
	<201006030156.42370.sven.eckelmann@gmx.de>
	<1275524401.23599.116.camel@Joe-Laptop.home>
In-Reply-To: <1275524401.23599.116.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201006031715.54584.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Convert
	MAC_FMT to %pM
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
To: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, devel <devel@driverdev.osuosl.org>, Greg Kroah-Hartman <gregkh@suse.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Thursday 03 June 2010 08:20:01 Joe Perches wrote:
> The patch changes the prefix from "batman-adv:" to "batman_adv: "
> so yes, it would break as-is.
> 
> I think the concept is broken though, I believe dmesg output
> specifically is not guaranteed to remain stable, and batman should
> use some other, perhaps private, logger based on ethtool events.

I think changing a dash to an underscore is not such a big deal (I did not 
check the rest of the patch yet). But I'm interested to hear more about your 
"private logger" idea because the current solution is far from being perfect. 
As we have to debug the routing protocol every now and then it would be very 
helpful to get direct access to some internal logging facility. In fact, that 
existed before (inside of /proc) but was removed to be more compliant with the 
linux kernel and the existing log facilities.

Regards,
Marek
