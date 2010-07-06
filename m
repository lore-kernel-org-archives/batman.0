Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Jul 2010 00:30:30 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007070006.51804.lindner_marek@yahoo.de>
	<201007070021.43888.clemens-john@gmx.de>
In-Reply-To: <201007070021.43888.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201007070030.30940.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Wednesday, July 07, 2010 00:21:38 Clemens John wrote:
> I still got two question left that I remembered when I read your answers:
> We discussed our networksetup on IRC (you remember?) and we decided to
> choose the setup with tinc an not sending batman advanced packages over
> VPN.

Oh yeah, I remember. Did you document your setup somewhere ? Others might find 
it useful to see why & how you did it.


> Now batman advanced nodes behind the VPN does not get listet in the
> originator tables of nodes on the other side of the VPN.
> But do they get listed on the gateway list? Can Batman advanced choose a
> gateway behind the VPN?

No, because the gateway information travel with the OGMs which you don't have 
on your VPN. Sending dhcp requests via unicast also does not work because the 
VPN interfaces are not controlled by batman.


> Last one: Is it right that the trunk version of batman advanced is not
> compatible with Batman advanced 0.2.1? Is trunk compatible with 2010.0.0?

No, the trunk is not compatible with any stable version. This has a very 
simple reason: It contains features which either change the packet format or 
change the behaviour or both. For instance, the gateway feature changes the 
packet format ...

Cheers,
Marek
