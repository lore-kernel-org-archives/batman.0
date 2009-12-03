Return-Path: <andrew@lunn.ch>
Date: Thu, 3 Dec 2009 07:00:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091203060042.GB29768@lunn.ch>
References: <20091129200950.GA19275@pandem0nium>
	<20091203013122.GA2223@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091203013122.GA2223@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Removing the big batman lock
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

On Thu, Dec 03, 2009 at 02:31:22AM +0100, Linus L??ssing wrote:
> Hi Simon,
> 
> I just gave your patch a try on my laptop and could successfully,
> reproduceably crash my kernel in the following way:

This looks like a deadlock. 

Simon: Did you try lockdep on this new code? 

http://lwn.net/Articles/185666/

This should hopefully show you what locks are being taken in the wrong
order. This is something i keep intending on running, but never get
around to it. Now we have a probably deadlock, it might be enough
reason for me to actually do it.

	Andrew
