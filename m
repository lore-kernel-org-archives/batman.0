Return-Path: <andrew@lunn.ch>
Date: Tue, 6 Oct 2009 11:49:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091006094908.GA6646@lunn.ch>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052201.30645.lindner_marek@yahoo.de>
	<d9bba8670910051354i1039f6f7x76c2467032f68db2@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
	<d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tue, Oct 06, 2009 at 11:26:01AM +0200, a wrote:
> It is correct. I'm using openwrt and, at the moment, without -M option.
> 1500byte packets work, with fragmentation.
> However, my TCP packets are small (about 60bytes). I have verified TCPDump
> file and packets arrive. It seems that the Linux IP stack does not forward
> them to the application.

Going back to your first email:

- B1 - bat0: 192.168.10.1/24 - default gateway: 192.168.10.2
- GW: bat0: 192.168.10.2/24,   eth1: 192.168.20.2/24
- EX: eth0: 192.168.20.3/24 - default gateway: 192.168.20.3

You default GW on EX does not make sense. You cannot use yourself as a
default gateway. It needs to be a remote device. In this case, EXs
default gateway should point to 192.168.20.2.

However, you say ping works, so that does not explain your problem.

Check your firewall rules. 

iptable -L

maybe one of the rules is causing the kernel to drop the packets.

      Andrew
