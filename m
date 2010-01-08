Return-Path: <andrew@lunn.ch>
Date: Fri, 8 Jan 2010 19:18:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100108181808.GH7597@lunn.ch>
References: <200912181714.58212.lindner_marek@yahoo.de>
	<DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>
	<201001072123.32104.lindner_marek@yahoo.de>
	<914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
	<20100107214343.GA2554@Linus-Debian> <4B47674B.6010508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B47674B.6010508@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Maximum MTU (was Re:  B.A.T.M.A.N. V outlook)
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

> Would you happen to know what the maximum MTU you could use on the
> wireless interface?

The 802.11 standard says the MSDU size is 2304 octets. How many IP
bytes you can fit into this depends on what encryption scheme you are
using, which adds different size headers.

However your hardware may not support this, since typically 1500 bytes
for Ethernet is what you need to work with. Also, as the packet gets
bigger, the more likely it is to get corrupted, and more likely that
the retry will also get corrupted etc...  If you do increase the frame
size to its max, i would suggest enabling RTC/CTS, use 5GHz, and in a
mesh network of 2 nodes....

	 Andrew
