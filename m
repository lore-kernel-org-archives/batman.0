Return-Path: <andrew@lunn.ch>
Date: Tue, 4 May 2010 07:14:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100504051436.GX3734@lunn.ch>
References: <201005030933.39124.lindner_marek@yahoo.de>
	<20100503165539.GW3734@lunn.ch>
	<201005040949.02215.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005040949.02215.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] updated README
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

Hi Marek

> * piped the README through nroff to get a consistent look & feel

It looks like this stage made use of UTF-8, or some sort of extended
character set:

vpn,  etc ... (anything with ethernet<E2><80><90>style layer 2). It compiles
against and should work with Linux 2.6.21 <E2><80><90>  2.6.33.   Supporting
older versions is not planned, but it<E2><80><99>s probably easy to backport

I don't have a locale set, being an English speaker and not needing
umlauts, accents, etc. I guess most embedded systems also don't have
locale support.

Could we have a 7-bit clean README?

      Thanks
	Andrew
