Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 5 Dec 2011 19:35:06 +0800
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<20111205112726.GC10131@lunn.ch>
In-Reply-To: <20111205112726.GC10131@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201112051935.06611.lindner_marek@yahoo.de>
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

On Monday, December 05, 2011 19:27:26 Andrew Lunn wrote:
> If i'm reading the patches correctly, it looks like you can change the
> algorithm at any time. Rather than making one algorithm deal with what
> ever state the previous algorithm left behind, would it not be better
> to only allow algorithm change when the soft interface is down and
> there is no local state?

Good point. Alternatively, we could add a cleanup call ?

Cheers,
Marek
