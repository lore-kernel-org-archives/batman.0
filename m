Return-Path: <bjo@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
In-Reply-To: <201101311933.01581.clemens-john@gmx.de>
References: <201101282346.16035.clemens-john@gmx.de>
	<1296323152.2725.6.camel@mytilus>
	<201101291900.51081.lindner_marek@yahoo.de>
	<201101311933.01581.clemens-john@gmx.de>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 01 Feb 2011 13:12:55 +0100
Message-ID: <1296562375.26635.5.camel@ostrea>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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

Hi,

> > I don't think the VPN is the problem here but the fact that you can't
> > bridge an interface running in adhoc mode. Ad-hoc is "lacks" a field in
> > the wifi header which makes bridging impossible.
> > However, I agree with your proposed solution - another router connected to
> > the Ethernet of the wrt54g can solve the issue.
> 
> This is not possible in this case (I don´t have another router).

Does Franco have another router which he could connect to the wrt54g? 

> Is there onother (maybe harder) way or a hack to do get the same result like 
> when bridging two interfaces? Maybe with iptables?

I think this would break our setup.

> Or does anyone know what the status of multiple ssid on wrt54g with kernel 2.6 
> is?

Maybe we should ask here:
http://wireless.kernel.org/en/users/Drivers/b43#support

I have no experience with brcm-chips due to I have only a brcm4318 in my
laptop.

regards
Bjoern
-- 
jabber: bjo@schafweide.org
bjo.nord-west.org | nord-west.org | freifunk-ol.de

