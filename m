Return-Path: <andrew@lunn.ch>
Date: Mon, 5 Dec 2011 12:27:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111205112726.GC10131@lunn.ch>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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

On Mon, Dec 05, 2011 at 05:56:22PM +0800, Marek Lindner wrote:
> Hi,
> 
> I massaged the RFC patches a little longer to integrate all the feedback
> received so far. They are ready to be considered 'real' patches now.

Hi Marek

If i'm reading the patches correctly, it looks like you can change the
algorithm at any time. Rather than making one algorithm deal with what
ever state the previous algorithm left behind, would it not be better
to only allow algorithm change when the soft interface is down and
there is no local state?

      Andrew

